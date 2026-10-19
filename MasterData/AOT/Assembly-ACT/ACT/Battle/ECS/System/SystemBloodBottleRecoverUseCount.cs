using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using Bamboo.ECS;
using Fundamental;
using Runtime.Utility;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemBloodBottleRecoverUseCount : ECSSystem
{
	private struct BottleRecoverProperty
	{
		public float RecoverCd;

		public int RecoverCount;

		public bool PropertyIsLegal()
		{
			if (RecoverCd > 0f)
			{
				return RecoverCount != 0;
			}
			return false;
		}
	}

	private BottleRecoverProperty _bottleRecover;

	private float _recoverCdDuration;

	private float _recoverCdFillAmount;

	private bool _hasSentInCurrentCd;

	private float _beforeCd;

	private int _beforeRecoverCount;

	private bool _enterUseCd;

	private float _useCdTotal;

	public float RecoverCdFillAmount => _recoverCdFillAmount;

	public float curUseCd { get; private set; }

	public float useCdDuration { get; private set; }

	public override Filter MajorFilter { get; }

	public event Action OnCdDurationChanged;

	public event Action OnCdEnd;

	protected override void OnCreate()
	{
		_bottleRecover = new BottleRecoverProperty
		{
			RecoverCd = 0f,
			RecoverCount = 0
		};
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RecoverBottleUseCountDirect, RecoverUseCountDirect);
	}

	public override void Update()
	{
		base.Update();
		float currentDeltaTime = GameManager.timeSystem.GetCurrentDeltaTime();
		if (_enterUseCd)
		{
			curUseCd -= currentDeltaTime;
			if (curUseCd <= 0f)
			{
				_enterUseCd = false;
				curUseCd = 0f;
				useCdDuration = 0f;
			}
			else
			{
				useCdDuration = Mathf.Clamp01(curUseCd / _useCdTotal);
			}
		}
		if (Singleton<GameState>.instance.RunningState != GameRunningState.Playing)
		{
			return;
		}
		BloodBottleData bloodBottleData = (Model<BloodBottleModel>.HasInstance() ? Model<BloodBottleModel>.Interface.CurTeamEquipBottle : null);
		if (bloodBottleData == null || bloodBottleData.alreadyUseCount == 0)
		{
			if (_recoverCdDuration > 0f || _beforeCd > 0f)
			{
				CancelRecoverCd();
			}
		}
		else
		{
			if (!TryRefreshForwardAssistStrikerBottleRecoverConfig())
			{
				return;
			}
			if (_bottleRecover.RecoverCount == 0 || Mathf.Approximately(_bottleRecover.RecoverCd, 0f))
			{
				_recoverCdFillAmount = 0f;
				return;
			}
			if (_recoverCdDuration > 0f)
			{
				_recoverCdDuration = Mathf.Max(0f, _recoverCdDuration - currentDeltaTime);
			}
			_recoverCdFillAmount = ((_recoverCdDuration <= 0f) ? 1f : Mathf.Clamp01(1f - _recoverCdDuration / _bottleRecover.RecoverCd));
			OnCdDurationChanged?.Invoke();
			if (!(_recoverCdDuration > 0f) && _bottleRecover.RecoverCount > 0 && !_hasSentInCurrentCd)
			{
				_hasSentInCurrentCd = true;
				SendRecoverBottleUseCount(_bottleRecover.RecoverCount);
			}
		}
	}

	private void ResetCd(float cdDuration)
	{
		if (!Mathf.Approximately(_beforeCd, cdDuration))
		{
			_bottleRecover.RecoverCd = Mathf.Max(0f, cdDuration);
			_beforeCd = _bottleRecover.RecoverCd;
			_recoverCdDuration = _bottleRecover.RecoverCd;
			_recoverCdFillAmount = ((_bottleRecover.RecoverCd > 0f) ? 0f : 1f);
			_hasSentInCurrentCd = false;
			OnCdDurationChanged?.Invoke();
		}
	}

	public void ResetRecoverCount(int count)
	{
		if (_beforeRecoverCount != count)
		{
			_bottleRecover.RecoverCount = count;
			_beforeRecoverCount = count;
		}
	}

	private void SendRecoverBottleUseCount(int recoverCount)
	{
		BloodBottleModel bloodBottleModel = Model<BloodBottleModel>.Interface;
		BloodBottleData bottle = bloodBottleModel.CurTeamEquipBottle;
		if (bottle == null)
		{
			return;
		}
		if (bottle.isLocalBottle)
		{
			bloodBottleModel.UpdateBottleUseCount(bottle, bottle.alreadyUseCount - recoverCount);
			_hasSentInCurrentCd = false;
			_recoverCdDuration = _bottleRecover.RecoverCd;
			_recoverCdFillAmount = 0f;
			OnCdEnd?.Invoke();
			RefreshCurrentBottleHud();
			return;
		}
		G.service.RecoverBottleUseCount(recoverCount, (int count) =>
		{
			if (count != -1)
			{
				BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
				if (curTeamEquipBottle == bottle && !curTeamEquipBottle.isLocalBottle)
				{
					Model<BloodBottleModel>.Interface.UpdateBottleUseCount(curTeamEquipBottle, count);
					_hasSentInCurrentCd = false;
					_recoverCdDuration = _bottleRecover.RecoverCd;
					_recoverCdFillAmount = 0f;
					OnCdEnd?.Invoke();
					RefreshCurrentBottleHud();
				}
			}
		});
	}

	private void RefreshCurrentBottleHud()
	{
		if (Singleton<BloodBottleHandler>.HasInstance())
		{
			Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId);
		}
	}

	private bool TryRefreshForwardAssistStrikerBottleRecoverConfig()
	{
		if (MPPlayer.local != null && MPPlayer.local.IsTrialRuntimeBattleTeam)
		{
			return TryRefreshTrialTeamBottleRecoverConfig();
		}
		Team teamInfo = TeamInfoExtension.GetTeamInfo();
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (teamInfo == null || curCharacterRepository == null)
		{
			return false;
		}
		for (int i = 0; i < teamInfo.CharacterIds.Count; i++)
		{
			int characterId = teamInfo.CharacterIds[i];
			if (CharacterDataHelper.TryGetCharacter(curCharacterRepository, characterId, out var character) && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
			{
				CompAbility compAbility = entity.GetCompAbility();
				if (compAbility != null && compAbility.characterDamageType == CharacterDamageType.AssistStriker)
				{
					ResetCd(compAbility.GetAssistStrikerBottleRecoverCd);
					ResetRecoverCount(compAbility.GetAssistStrikerBottleRecoverCount);
					return true;
				}
			}
		}
		for (int j = 0; j < teamInfo.ExtraCharacterIds.Count; j++)
		{
			int characterId2 = teamInfo.ExtraCharacterIds[j];
			if (CharacterDataHelper.TryGetExtraCharacter(curCharacterRepository, characterId2, out var character2) && EntityHelper.TryGetBattleEntityByCharacter(character2, out var entity2))
			{
				CompAbility compAbility2 = entity2.GetCompAbility();
				if (compAbility2 != null && compAbility2.characterDamageType == CharacterDamageType.AssistStriker)
				{
					ResetCd(compAbility2.GetAssistStrikerBottleRecoverCd);
					ResetRecoverCount(compAbility2.GetAssistStrikerBottleRecoverCount);
					return true;
				}
			}
		}
		return false;
	}

	private bool TryRefreshTrialTeamBottleRecoverConfig()
	{
		IReadOnlyList<Character> characters = MPPlayer.local.CurrentRuntimeBattleTeam.Characters;
		for (int i = 0; i < characters.Count; i++)
		{
			Character character = characters[i];
			if (character != null && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
			{
				CompAbility compAbility = entity.GetCompAbility();
				if (compAbility != null && compAbility.characterDamageType == CharacterDamageType.AssistStriker)
				{
					ResetCd(compAbility.GetAssistStrikerBottleRecoverCd);
					ResetRecoverCount(compAbility.GetAssistStrikerBottleRecoverCount);
					return true;
				}
			}
		}
		return false;
	}

	private void RecoverUseCountDirect(BaseEventContent obj)
	{
		BloodBottleData curEquipBottle = (Model<BloodBottleModel>.HasInstance() ? Model<BloodBottleModel>.Interface.CurTeamEquipBottle : null);
		if (curEquipBottle == null || !(obj is RecoverEquipBottleUseCountWithoutPropertyEvt { recoverCount: not 0 } recoverEquipBottleUseCountWithoutPropertyEvt))
		{
			return;
		}
		if (curEquipBottle.isLocalBottle)
		{
			Model<BloodBottleModel>.Interface.UpdateBottleUseCount(curEquipBottle, curEquipBottle.alreadyUseCount - recoverEquipBottleUseCountWithoutPropertyEvt.recoverCount);
			RefreshCurrentBottleHud();
			return;
		}
		G.service.RecoverBottleUseCount(recoverEquipBottleUseCountWithoutPropertyEvt.recoverCount, (int count) =>
		{
			if (count != -1)
			{
				BloodBottleData curTeamEquipBottle = Model<BloodBottleModel>.Interface.CurTeamEquipBottle;
				if (curTeamEquipBottle == curEquipBottle && !curTeamEquipBottle.isLocalBottle)
				{
					Model<BloodBottleModel>.Interface.UpdateBottleUseCount(curTeamEquipBottle, count);
					RefreshCurrentBottleHud();
				}
			}
		});
	}

	public void EnterUseCd()
	{
		_useCdTotal = (float)RuntimeConfigs.data.game.potionCd / 1000f;
		curUseCd = _useCdTotal;
		useCdDuration = 1f;
		_enterUseCd = true;
	}

	public void CancelRecoverCd()
	{
		_recoverCdDuration = 0f;
		_recoverCdFillAmount = 0f;
		_hasSentInCurrentCd = false;
		_beforeCd = 0f;
		OnCdEnd?.Invoke();
	}
}
