using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using Runtime.Utility;
using UnityEngine;

namespace ACT.Model;

public class CustomUIModel : Model<CustomUIModel>
{
	private const string _characterOperateBtnConfigsAddressablePath = "CharacterOperateBtnConfigs";

	private DeviceInputMode lastInputMode;

	private AssetLoadHandle _handle;

	private CharacterOperateBtnConfigs _configs;

	private Dictionary<EntityId, CharacterOperateBtnGroupData> _curTeamCharacterOperateBtnGroupData;

	public SchemeWrapper Scheme { get; private set; }

	public CharacterOperateBtnConfigs characterOperateBtnConfigs => _configs;

	public Dictionary<EntityId, CharacterOperateBtnGroupData> CurTeamCharacterOperateBtnGroupData => _curTeamCharacterOperateBtnGroupData;

	public event Action ChangeToTouchScreenScheme;

	public event Action ChangeToKeyBoardMouseScheme;

	public event Action ChangeToHandleScheme;

	protected override void Init()
	{
		Scheme = new SchemeWrapper();
		_curTeamCharacterOperateBtnGroupData = DictionaryPool<EntityId, CharacterOperateBtnGroupData>.Get();
		AddEventListener();
		MonoECS.instance.onInputModeChange.AddListener(OnDeviceTypeChanged);
		InitCharacterOperateBtnConfigData();
	}

	protected override void UnInit()
	{
		Scheme.UnInit();
		DictionaryPool<EntityId, CharacterOperateBtnGroupData>.Release(_curTeamCharacterOperateBtnGroupData);
		ChangeToTouchScreenScheme = null;
		ChangeToKeyBoardMouseScheme = null;
		ChangeToHandleScheme = null;
		RemoveEventListener();
		MonoECS.instance.onInputModeChange.RemoveListener(OnDeviceTypeChanged);
	}

	protected override void OnDestroy()
	{
		_configs = null;
		AssetStationManager.Root.Release(_handle);
	}

	private void InitCharacterOperateBtnConfigData()
	{
		_handle = AssetStationManager.Root.Load<CharacterOperateBtnConfigs>("CharacterOperateBtnConfigs");
		_configs = _handle.As<CharacterOperateBtnConfigs>();
	}

	public Entity GetTargetEntity(int characterId)
	{
		Character bagCharacter = G.localPlayer.GetBagCharacter(characterId);
		if (bagCharacter == null)
		{
			return default;
		}
		if (bagCharacter.Id == characterId)
		{
			if (!EntityHelper.TryGetBattleEntityByCharacter(bagCharacter, out var entity))
			{
				return default;
			}
			return entity;
		}
		return default;
	}

	private void AddCharacterOperateBtnData(Entity eb)
	{
		CompCharacter compCharacter = eb.GetCompCharacter();
		if (compCharacter == null || compCharacter.characterSource == null)
		{
			return;
		}
		CompOperateBtn compOperateBtn = eb.GetCompOperateBtn();
		if (compOperateBtn == null)
		{
			return;
		}
		int num = compCharacter.characterSource.Id();
		CharacterOperateBtnGroupData btnData = compOperateBtn.GetBtnData();
		if (btnData == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色 {num}的operateBtn上操作按钮数据为空！");
			}
		}
		else if (_curTeamCharacterOperateBtnGroupData.TryAdd(eb.Id, btnData))
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CurTeamOperateBtnGroupDataChanged, null);
		}
	}

	private void RemoveCharacterOperateBtnData(Entity eb)
	{
		CompCharacter compCharacter = eb.GetCompCharacter();
		if (compCharacter != null && compCharacter.characterSource != null && _curTeamCharacterOperateBtnGroupData.Remove(eb.Id))
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CurTeamOperateBtnGroupDataChanged, null);
		}
	}

	public CharacterOperateBtnConfig GetCharacterOperateBtnConfig(Entity entity)
	{
		CharacterOperateBtnConfigs characterOperateBtnConfigs = _handle.As<CharacterOperateBtnConfigs>();
		int characterId = entity.GetCompCharacter()?.characterSource.Id() ?? 0;
		if (characterId == 0 && LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色entity:{entity.Id},沒有CompCharacter");
		}
		return characterOperateBtnConfigs.characterConfigs.FirstOrDefault((CharacterOperateBtnConfig i) => i.characterId == characterId);
	}

	public CustomUIScheme GetCurScheme()
	{
		return Scheme.CurScheme;
	}

	public void SetMobileCurScheme(int schemeId)
	{
		Scheme.MobileSetCurScheme(schemeId);
	}

	public bool TryGetScheme(int schemeId, out CustomUIScheme scheme)
	{
		if (Scheme.TryGetScheme(schemeId, out var scheme2))
		{
			scheme = scheme2;
			return true;
		}
		scheme = null;
		return false;
	}

	public void OnDeviceTypeChanged(DeviceInputMode curType)
	{
		switch (curType)
		{
		case DeviceInputMode.TouchScreen:
			ChangeToTouchScreenScheme?.Invoke();
			break;
		case DeviceInputMode.KeyboardAndMouse:
			ChangeToKeyBoardMouseScheme?.Invoke();
			break;
		case DeviceInputMode.Gamepad:
			ChangeToHandleScheme?.Invoke();
			break;
		}
		lastInputMode = MonoECS.instance.InputMode;
	}

	public void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnAddCharacterBattlePart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnRemoveCharacterBattlePart, OnRemoveCharacterBattlePart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_CountChange, OnSkillCountChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Skill_CdChange, OnSkillCdChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_Add, OnAbilityAdd);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_Remove, OnAbilityRemove);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_StackChange, OnAbilityStackChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_Ability_DurationChange, OnAbilityDurationChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DynamicVal_ValChange, OnDynamicValValChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterNormalEnergyChange, OnEnergyValChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CharacterEnergyChange, OnUltraEnergyChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OperateBtnRebindSkill, OnRebindSkillBtn);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AssistVal_Change, OnAssistValChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterSpeicalEnergyChange, OnSpecialEnergyChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_BoolParamChange, OnMotionBoolParamChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_IntParamChange, OnMotionIntParamChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterNormalEnergyActiveChange, OnNormalEnergyActiveChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterSpecialEnergyActiveChange, OnSpecialEnergyActiveChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterAssetActiveChange, OnAssistActiveChange);
	}

	public void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnAddCharacterBattlePart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnRemoveCharacterBattlePart, OnRemoveCharacterBattlePart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_CountChange, OnSkillCountChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Skill_CdChange, OnSkillCdChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_Add, OnAbilityAdd);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_Remove, OnAbilityRemove);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_StackChange, OnAbilityStackChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_Ability_DurationChange, OnAbilityDurationChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DynamicVal_ValChange, OnDynamicValValChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterNormalEnergyChange, OnEnergyValChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CharacterEnergyChange, OnUltraEnergyChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OperateBtnRebindSkill, OnRebindSkillBtn);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AssistVal_Change, OnAssistValChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterSpeicalEnergyChange, OnSpecialEnergyChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_BoolParamChange, OnMotionBoolParamChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_IntParamChange, OnMotionIntParamChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterNormalEnergyActiveChange, OnNormalEnergyActiveChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterSpecialEnergyActiveChange, OnSpecialEnergyActiveChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterAssetActiveChange, OnAssistActiveChange);
	}

	private void OnAddCharacterBattlePart(BaseEventContent obj)
	{
		if (obj is SpawnCharacterBattlePartEvt spawnCharacterBattlePartEvt)
		{
			AddCharacterOperateBtnData(spawnCharacterBattlePartEvt.entityBehave);
		}
	}

	private void OnRemoveCharacterBattlePart(BaseEventContent obj)
	{
		if (obj is RemoveCharacterBattlePartEvt removeCharacterBattlePartEvt)
		{
			RemoveCharacterOperateBtnData(removeCharacterBattlePartEvt.entityBehave);
		}
	}

	private void OnAssistValChange(BaseEventContent obj)
	{
		if (obj is AssistValChangeEvt assistValChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(assistValChangeEvt.eb.Id, out var value))
		{
			value.ProcessAssistDataChange(assistValChangeEvt);
		}
	}

	private void OnUltraEnergyChange(BaseEventContent obj)
	{
		if (obj is CharacterUltraEnergyUpdateEvt characterUltraEnergyUpdateEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(characterUltraEnergyUpdateEvt.entity.Id, out var value))
		{
			value.ProcessUltraEnergyChange(characterUltraEnergyUpdateEvt);
		}
	}

	private void OnDynamicValValChange(BaseEventContent obj)
	{
		_ = obj is DynamicValValChangeEvt;
	}

	private void OnSkillCdChange(BaseEventContent obj)
	{
		if (obj is SkillCdChangeEvt skillCdChangeEvt)
		{
			skillCdChangeEvt.eb.GetCompCharacter()?.characterSource.Id();
			if (_curTeamCharacterOperateBtnGroupData.TryGetValue(skillCdChangeEvt.eb.Id, out var value))
			{
				value.ProcessSkillCdChange(skillCdChangeEvt);
			}
		}
	}

	private void OnSkillCountChange(BaseEventContent obj)
	{
		if (obj is SkillCountChangeEvt skillCountChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(skillCountChangeEvt.eb.Id, out var value))
		{
			value.ProcessSkillCountChange(skillCountChangeEvt);
		}
	}

	private void OnAbilityDurationChange(BaseEventContent obj)
	{
		if (obj is AbilityDurationChangeEvt abilityDurationChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(abilityDurationChangeEvt.entity.Id, out var value))
		{
			value.ProcessAbilityDurationChange(abilityDurationChangeEvt);
		}
	}

	private void OnAbilityAdd(BaseEventContent obj)
	{
		if (obj is AbilityAddEvt abilityAddEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(abilityAddEvt.eb.Id, out var value))
		{
			value.ProcessAbilityAdd(abilityAddEvt);
		}
	}

	private void OnAbilityRemove(BaseEventContent obj)
	{
		if (obj is AbilityRemoveEvt abilityRemoveEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(abilityRemoveEvt.originalOwner.Id, out var value))
		{
			value.ProcessAbilityRemove(abilityRemoveEvt);
		}
	}

	private void OnAbilityStackChange(BaseEventContent obj)
	{
		if (obj is AbilityStackChangeEvt abilityStackChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(abilityStackChangeEvt.eb.Id, out var value))
		{
			value.ProcessAbilityStackChange(abilityStackChangeEvt);
		}
	}

	private void OnEnergyValChange(BaseEventContent obj)
	{
		if (obj is CharacterNormalEnergyChangeEvt characterNormalEnergyChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(characterNormalEnergyChangeEvt.entity.Id, out var value))
		{
			value.ProcessEnergyChange(characterNormalEnergyChangeEvt);
		}
	}

	private void OnRebindSkillBtn(BaseEventContent obj)
	{
		if (obj is RebindSkillBtnEvt rebindSkillBtnEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(rebindSkillBtnEvt.entity.Id, out var value))
		{
			value.ProcessRebindSkillChangeBtnState(rebindSkillBtnEvt);
		}
	}

	private void OnSpecialEnergyChange(BaseEventContent obj)
	{
		if (obj is CharacterSpecialEnergyChangeEvt characterSpecialEnergyChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(characterSpecialEnergyChangeEvt.entity.Id, out var value))
		{
			value.ProcessSpecialEnergyChange(characterSpecialEnergyChangeEvt);
		}
	}

	private void OnMotionBoolParamChange(BaseEventContent obj)
	{
		if (obj is MotionBoolParamChangeEvt motionBoolParamChangeEvt && motionBoolParamChangeEvt.entity.IsCharacter() && _curTeamCharacterOperateBtnGroupData.TryGetValue(motionBoolParamChangeEvt.entity.Id, out var value))
		{
			value.ProcessMotionBoolParamChange(motionBoolParamChangeEvt);
		}
	}

	private void OnMotionIntParamChange(BaseEventContent obj)
	{
		if (obj is MotionIntParamChangeEvt motionIntParamChangeEvt && motionIntParamChangeEvt.entity.IsCharacter() && _curTeamCharacterOperateBtnGroupData.TryGetValue(motionIntParamChangeEvt.entity.Id, out var value))
		{
			value.ProcessMotionIntParamChange(motionIntParamChangeEvt);
		}
	}

	private void OnMotionStateChange(BaseEventContent obj)
	{
		if (obj is MotionStateChangeEvt motionStateChangeEvt && motionStateChangeEvt.entity.IsCharacter() && _curTeamCharacterOperateBtnGroupData.TryGetValue(motionStateChangeEvt.entity.Id, out var value))
		{
			value.ProcessMotionStateChange(motionStateChangeEvt);
		}
	}

	private void OnNormalEnergyActiveChange(BaseEventContent obj)
	{
		if (obj is CharacterNormalEnergyActiveChangeEvt characterNormalEnergyActiveChangeEvt)
		{
			characterNormalEnergyActiveChangeEvt.entity.GetCompCharacter()?.characterSource.Id();
			if (_curTeamCharacterOperateBtnGroupData.TryGetValue(characterNormalEnergyActiveChangeEvt.entity.Id, out var value))
			{
				value.ProcessNormalEnergyActiveChange(characterNormalEnergyActiveChangeEvt);
			}
		}
	}

	private void OnSpecialEnergyActiveChange(BaseEventContent obj)
	{
		if (obj is CharacterSpecialEnergyActiveChangeEvt characterSpecialEnergyActiveChangeEvt && _curTeamCharacterOperateBtnGroupData.TryGetValue(characterSpecialEnergyActiveChangeEvt.entity.Id, out var value))
		{
			value.ProcessSpecialEnergyActiveChange(characterSpecialEnergyActiveChangeEvt);
		}
	}

	private void OnAssistActiveChange(BaseEventContent obj)
	{
		if (obj is CharacterAssistActiveChangeEvt characterAssistActiveChangeEvt)
		{
			characterAssistActiveChangeEvt.entity.GetCompCharacter()?.characterSource.Id();
			if (_curTeamCharacterOperateBtnGroupData.TryGetValue(characterAssistActiveChangeEvt.entity.Id, out var value))
			{
				value.ProcessAssistActiveChange(characterAssistActiveChangeEvt);
			}
		}
	}
}
