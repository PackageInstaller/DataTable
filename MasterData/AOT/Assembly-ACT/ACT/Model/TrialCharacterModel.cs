using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.Model;

public class TrialCharacterModel : Model<TrialCharacterModel>
{
	private readonly List<Character> _trialCharacters = new List<Character>();

	private Character[] _normalCharacters = Array.Empty<Character>();

	private PBVector3 _normalSyncPosition;

	private CharacterSyncInfo _normalCharacterSyncInfo;

	private bool _hasReplacedCharacters;

	private bool _isExitingTrialCharacterMode;

	private const int TrialCharacterJoinedTipLocalizeId = 80003;

	private const int TrialCharacterLeftTipLocalizeId = 80004;

	public bool IsTrialMode { get; private set; }

	public bool IsExitingTrialCharacterMode => _isExitingTrialCharacterMode;

	public IReadOnlyList<Character> TrialCharacters => _trialCharacters;

	public PBVector3 NormalSyncPosition => _normalSyncPosition;

	public CharacterSyncInfo NormalCharacterSyncInfo => _normalCharacterSyncInfo;

	public override ContextType ContextType => ContextType.GAME;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
	}

	private void OnExitEvent(BaseEventContent obj)
	{
		MPPlayer.local?.ResetRuntimeBattleTeamForSession();
		IsTrialMode = false;
		_hasReplacedCharacters = false;
		_isExitingTrialCharacterMode = false;
		_trialCharacters.Clear();
		_normalCharacters = Array.Empty<Character>();
		ClearNormalSyncSnapshot();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
		MPPlayer.local?.ResetRuntimeBattleTeamForSession();
		IsTrialMode = false;
		_hasReplacedCharacters = false;
		_isExitingTrialCharacterMode = false;
		_trialCharacters.Clear();
		_normalCharacters = Array.Empty<Character>();
		ClearNormalSyncSnapshot();
	}

	public async UniTask EnterTrialCharacterMode(IEnumerable<int> probationIds, int battleIndex, int trialPotionId)
	{
		if (IsTrialMode)
		{
			Debug.LogWarning("已处于试用角色模式，忽略重复进入请求。");
			return;
		}
		List<Character> trialCharacters = CharacterDataHelper.CreateTrialCharacterTeamByProbationIds(probationIds);
		if (trialCharacters.Count == 0)
		{
			Debug.LogError("进入试用角色模式失败：未构建出有效的试用角色。");
			return;
		}
		SyncGameInfoReq syncGameInfoReq = MonoECS.instance.GetSyncGameInfoReq();
		MonoECS.instance.SyncGameInfos();
		if (G.service is LocalGameService localGameService)
		{
			localGameService.SaveGame();
		}
		CaptureNormalSyncSnapshot(syncGameInfoReq);
		_normalCharacters = GetCurrentNormalBattleCharacters();
		_trialCharacters.Clear();
		_trialCharacters.AddRange(trialCharacters);
		InitializeTrialCharacterStatus(_trialCharacters);
		IsTrialMode = true;
		try
		{
			await ReplaceWithBlackScreen(() => ReplaceWithTrialCharacters(trialPotionId, battleIndex));
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			await RecoverNormalTeamAfterEnterFailure();
			throw;
		}
		ShowTrialCharacterTeamTip(trialCharacters, 80003);
	}

	public async UniTask ExitTrialCharacterMode()
	{
		if (_isExitingTrialCharacterMode)
		{
			await UniTask.WaitUntil(() => !_isExitingTrialCharacterMode);
		}
		else
		{
			if (!IsTrialMode)
			{
				return;
			}
			_isExitingTrialCharacterMode = true;
			Character[] trialCharacters = _trialCharacters.ToArray();
			try
			{
				await ReplaceWithBlackScreen(async () =>
				{
					Character[] currentNormalBattleCharacters = GetCurrentNormalBattleCharacters();
					await MPPlayer.local.RestoreNormalRuntimeBattleTeam(_trialCharacters, currentNormalBattleCharacters, MPPlayer.local.GetNormalRuntimeBattleIndex(MPPlayer.local.NormalBattleTeamData.BattleCharacterIdx));
					IsTrialMode = false;
					MPPlayer.local.RefreshNormalRuntimeBattleTeamPotion();
					MPPlayer.local.RefreshActiveTeamAbilities();
					MPPlayer.local.NotifyBattleCharacterChanged();
					_trialCharacters.Clear();
					_normalCharacters = Array.Empty<Character>();
					ClearNormalSyncSnapshot();
					_hasReplacedCharacters = false;
				});
				if (!Singleton<TeleportMoveManager>.instance.IsWebberCabinFlow)
				{
					ShowTrialCharacterTeamTip(trialCharacters, 80004);
				}
			}
			finally
			{
				_isExitingTrialCharacterMode = false;
			}
		}
	}

	private static void ShowTrialCharacterTeamTip(IEnumerable<Character> characters, int tipLocalizeId)
	{
		List<string> list = new List<string>();
		foreach (Character character in characters)
		{
			if (character != null)
			{
				if (!RuntimeConfigs.data.entityDatas.TryGetValue(character.Id, out var value))
				{
					Debug.LogError($"试用角色提示失败：未找到角色 {character.Id} 的实体配置。");
				}
				else
				{
					list.Add(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal));
				}
			}
		}
		if (list.Count != 0)
		{
			GameUtility.OpenToolTip(new LocalizedString("Common", tipLocalizeId) { 
			{
				"0",
				new StringVariable
				{
					Value = string.Join("、", list)
				}
			} });
		}
	}

	private void CaptureNormalSyncSnapshot(SyncGameInfoReq syncInfo)
	{
		_normalSyncPosition = syncInfo?.Position?.Clone();
		_normalCharacterSyncInfo = syncInfo?.CharacterInfo?.Clone();
	}

	private void ClearNormalSyncSnapshot()
	{
		_normalSyncPosition = null;
		_normalCharacterSyncInfo = null;
	}

	private async UniTask ReplaceWithTrialCharacters(int trialPotionId, int battleIndex)
	{
		_hasReplacedCharacters = true;
		await MPPlayer.local.ReplaceTrialRuntimeBattleTeam(_normalCharacters, _trialCharacters, trialPotionId, battleIndex);
	}

	private async UniTask RecoverNormalTeamAfterEnterFailure()
	{
		if (_hasReplacedCharacters)
		{
			try
			{
				await MPPlayer.local.RestoreNormalRuntimeBattleTeam(_trialCharacters, _normalCharacters, MPPlayer.local.GetNormalRuntimeBattleIndex(MPPlayer.local.NormalBattleTeamData.BattleCharacterIdx));
				MPPlayer.local.RefreshActiveTeamAbilities();
				MPPlayer.local.NotifyBattleCharacterChanged();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		IsTrialMode = false;
		_hasReplacedCharacters = false;
		_trialCharacters.Clear();
		_normalCharacters = Array.Empty<Character>();
		ClearNormalSyncSnapshot();
	}

	private static async UniTask ReplaceWithBlackScreen(Func<UniTask> replaceAction, float fadeInTime = 0.5f, float fadeOutTime = 0.5f)
	{
		MonoECS.instance.PushPauseAllInput();
		try
		{
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(fadeInTime)
			});
			await replaceAction();
			if (!Singleton<TeleportMoveManager>.instance.IsWebberCabinFlow)
			{
				await Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
				{
					fadeOutTime = TimeSpan.FromSeconds(fadeOutTime)
				});
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			throw;
		}
		finally
		{
			MonoECS.instance.PopPauseAllInput();
		}
	}

	private static Character[] GetCurrentNormalBattleCharacters()
	{
		return (MPPlayer.local?.CurrentBattleTeam)?.GetTeamCharacters()?.ToArray() ?? Array.Empty<Character>();
	}

	private void InitializeTrialCharacterStatus(IEnumerable<Character> characters)
	{
		foreach (Character character in characters)
		{
			character.Status = new CharacterStatus
			{
				Hp = RuntimeConfigs.data.game.hpSync,
				ExPower = 0f,
				AssistPower = 0f,
				EnergyPower = 0f,
				SpecialEnergyPower = 0f
			};
		}
	}
}
