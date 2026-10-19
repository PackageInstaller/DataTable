using System.Collections.Generic;
using System.Text;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Sound;
using ACT.UI;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;

public class CharacterLevelUpEffect : BaseUIComponent
{
	private enum LevelUpEffectState
	{
		None,
		ShowingExp,
		WaitingLevelUp,
		ShowingLevelUp
	}

	public TextMeshProUGUI addNumber;

	public TargetValueMaskBar expChangeBar;

	public GameObject levelUpEffect;

	public GameObject gainExpEffect;

	public BetterAnimation anim;

	public float expDuration = 5f;

	public float levelUpDuration = 5f;

	private EntityCharacterXPData _curLevelMaxData;

	private int _displayLevel;

	private LevelUpEffectState _currentLevelUpEffectState;

	private float _expDurationStartTime;

	private float _levelUpDurationStartTime;

	private StringBuilder _sb;

	private Character _curCharacter;

	private bool _calExpDataFinish;

	private long _accumulatedExp;

	private long _pendingExp;

	private bool _isExpCapped;

	private void Awake()
	{
		_sb = new StringBuilder();
	}

	protected override void OnUnityDestroy()
	{
		_displayLevel = 0;
		_isExpCapped = false;
		_calExpDataFinish = false;
		_currentLevelUpEffectState = LevelUpEffectState.None;
		_levelUpDurationStartTime = 0f;
		_expDurationStartTime = 0f;
	}

	public void Initialize(Character character)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterExpAdd, OnExpGained);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_LevelUp, SetExpCapped);
		_curCharacter = character;
		if (_curCharacter == null && LuminApplication.LogEnabled)
		{
			Debug.LogError("对应角色为空");
		}
	}

	public void UnInitialize()
	{
		gainExpEffect.SetActive(value: false);
		levelUpEffect.SetActive(value: false);
		_isExpCapped = false;
		_calExpDataFinish = false;
		_displayLevel = 0;
		_currentLevelUpEffectState = LevelUpEffectState.None;
		_levelUpDurationStartTime = 0f;
		_expDurationStartTime = 0f;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterExpAdd, OnExpGained);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_LevelUp, SetExpCapped);
	}

	public void OnExpGained(BaseEventContent obj)
	{
		if (obj is MonsterExpAddEvt monsterExpAddEvt)
		{
			switch (_currentLevelUpEffectState)
			{
			case LevelUpEffectState.None:
				StartShowExp(monsterExpAddEvt.addNum);
				break;
			case LevelUpEffectState.ShowingExp:
				_accumulatedExp += monsterExpAddEvt.addNum;
				ResetExpTimer();
				break;
			case LevelUpEffectState.WaitingLevelUp:
				_pendingExp += monsterExpAddEvt.addNum;
				break;
			case LevelUpEffectState.ShowingLevelUp:
				_pendingExp += monsterExpAddEvt.addNum;
				break;
			}
		}
	}

	private void SetExpCapped(BaseEventContent obj)
	{
		if (obj is CharacterUpdateEvt characterUpdateEvt && characterUpdateEvt.character.Equals(_curCharacter))
		{
			_isExpCapped = true;
		}
	}

	private void StartShowExp(long expAmount)
	{
		_currentLevelUpEffectState = LevelUpEffectState.ShowingExp;
		_accumulatedExp = expAmount;
		_pendingExp = 0L;
		_expDurationStartTime = Time.unscaledTime;
		CalExpDisplayData(_accumulatedExp);
		DisplayNewExp(_accumulatedExp);
	}

	private void ResetExpTimer()
	{
		_expDurationStartTime = Time.unscaledTime;
		RefreshExpBar(_accumulatedExp);
	}

	private void Update()
	{
		switch (_currentLevelUpEffectState)
		{
		case LevelUpEffectState.ShowingExp:
			if (_expDurationStartTime + expDuration < Time.unscaledTime)
			{
				OnExpTimerEnd();
			}
			break;
		case LevelUpEffectState.ShowingLevelUp:
			if (_levelUpDurationStartTime + levelUpDuration < Time.unscaledTime)
			{
				OnLevelUpTimerEnd();
			}
			break;
		}
	}

	private void OnExpTimerEnd()
	{
		if (_isExpCapped)
		{
			_isExpCapped = false;
			StartWaitingLevelUp();
		}
		else
		{
			_currentLevelUpEffectState = LevelUpEffectState.None;
			HideExp();
		}
	}

	private void StartWaitingLevelUp()
	{
		_currentLevelUpEffectState = LevelUpEffectState.WaitingLevelUp;
		anim?.GetSequence("ExpHide").OnComplete((AnimationBuilder _) =>
		{
			_calExpDataFinish = false;
			gainExpEffect.SetActive(value: false);
			StartShowLevelUp();
		}).Play();
	}

	private void StartShowLevelUp()
	{
		_currentLevelUpEffectState = LevelUpEffectState.ShowingLevelUp;
		_levelUpDurationStartTime = Time.unscaledTime;
		_pendingExp = 0L;
		DisplayLevelUp();
	}

	private void OnLevelUpTimerEnd()
	{
		levelUpEffect.gameObject.SetActive(value: false);
		if (_pendingExp > 0)
		{
			CalExpDisplayData(_pendingExp);
			StartShowExp(_pendingExp);
		}
		else
		{
			_currentLevelUpEffectState = LevelUpEffectState.None;
		}
	}

	private void CalExpDisplayData(long exp)
	{
		int num = 0;
		_displayLevel = _curCharacter.Level;
		EntityCharacterXPData data = CoreUtils.GetData(_curCharacter.GetCharacterXpId(), RuntimeConfigs.data.entityCharacterXPDatas);
		if (data != null)
		{
			num = data.xpTotal;
		}
		int num2 = num + _curCharacter.Exp - (int)exp;
		foreach (EntityCharacterXPData value in RuntimeConfigs.data.entityCharacterXPDatas.Values)
		{
			if (value.xpTotal > num2)
			{
				_curLevelMaxData = RuntimeConfigs.data.entityCharacterXPDatas[value.id];
				break;
			}
		}
		_calExpDataFinish = true;
	}

	private void DisplayNewExp(long exp)
	{
		if (_curCharacter != null)
		{
			gainExpEffect.SetActive(value: true);
			anim?.GetSequence("ExpGain").OnComplete((AnimationBuilder _) =>
			{
				RefreshExpBar(exp);
			}).Play();
		}
	}

	private void RefreshExpBar(long paddingExp)
	{
		if (_curLevelMaxData.id - 1000 == _displayLevel)
		{
			TargetValueMaskBar targetValueMaskBar = expChangeBar;
			float targetValue = (expChangeBar.Value = 1f);
			targetValueMaskBar.TargetValue = targetValue;
		}
		else
		{
			TargetValueMaskBar targetValueMaskBar2 = expChangeBar;
			float targetValue = (expChangeBar.Value = (float)_curCharacter.Exp / (float)_curLevelMaxData.xpEachLv);
			targetValueMaskBar2.TargetValue = targetValue;
		}
		_sb.Clear();
		addNumber.SetText(_sb.Append("+").Append(paddingExp));
		if (!addNumber.gameObject.activeInHierarchy)
		{
			addNumber.gameObject.SetActive(value: true);
		}
	}

	private void HideExp()
	{
		_calExpDataFinish = false;
		anim?.GetSequence("ExpHide").OnComplete((AnimationBuilder _) =>
		{
			gainExpEffect.SetActive(value: false);
		}).Play();
	}

	private void DisplayLevelUp()
	{
		levelUpEffect.gameObject.SetActive(value: true);
		anim?.GetSequence("LevelUp").Play();
		if (ParentUIView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
			if (curTeamCharacters != null && curTeamCharacters.IndexOf(_curCharacter) == MonoECS.instance.localPlayer.battleEntityIndex)
			{
				monoBattleMainBaseView.BloodBar.InitMainEntityBloodBar(MonoECS.instance.mainEntity.GetCompAbility().hp);
			}
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Role/Upgrade_Click", new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void HideLevelUp()
	{
	}
}
