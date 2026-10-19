using System;
using System.Collections.Generic;
using ACT;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Localization;

namespace Runtime.Model;

public class CharacterModel : Model<CharacterModel>, IJumpable
{
	public const int CriticalChancePropertyId = 300;

	private const int CriticalDamagePropertyId = 400;

	private const int CriticalDamagePropertyTypeId = 4;

	private const int CriticalConversionPropertyId = 5700;

	private const int CriticalConversionPropertyTypeId = 57;

	private const int CriticalConversionMannerType = 2;

	public bool SelectFirstEquipSlotInOverview;

	public bool SelectFirstDiscSlotInEquipmentSubview;

	public int CharacterMaxLevel => RuntimeConfigs.data.playerLevelDatas[RuntimeConfigs.data.playerLevelDatas.Count].characterLevel;

	public LuminModelType JumpSourceType => LuminModelType.CharacterView;

	public void OpenCharacterTeam(List<Character> characters, CharacterUID? defaultCharacterUID = null, int pageIndex = -1)
	{
		if (characters == null || characters.Count <= 0)
		{
			return;
		}
		NewUIManager instance = Singleton<NewUIManager>.instance;
		if (instance != null)
		{
			IBaseUIController topActivePanel = instance.GetTopActivePanel();
			bool flag = topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_CHARACTER && topActivePanel.State == UIState.Opened && topActivePanel.ExpectedState == UIExpectedState.Open;
			bool flag2 = NewUIManager.IsRequireBlackScreenTransition(UI_TYPE.UI_CHARACTER) && !instance.IsUIManagerBusy() && !flag;
			UIOpenResult uIOpenResult = instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
			{
				DisplayCharacters = new List<Character>(characters),
				defaultCharacterUID = defaultCharacterUID,
				PageIndex = pageIndex
			});
			if ((uIOpenResult.IsValid & flag2) && instance.QueueContains(uIOpenResult.Uid))
			{
				instance.ShowBlackScreenImmediate();
			}
		}
	}

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChangeSystemProperties, ChangeSystemPropertyByMap);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_LevelUp, OnCharacterLevelUp);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_AddElite, AddEliteProperty);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_RemoveElite, RemoveEliteProperty);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_Add, CharacterPropertiesRefresh);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_Remove, CharacterRemove);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SystemPropertyChange, PropertyHasChanged);
	}

	private void SetCharacterSystemPropertiesData(Character character)
	{
		if (character.Level - 1 > 0)
		{
			Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
			foreach (Properties item in CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas).characterPorpertyAdd)
			{
				dictionary[item.property] = item.value * (float)(character.Level - 1);
			}
			character.systemProperty.CalSystemProperties(dictionary, 1);
			DictionaryPool<int, float>.Release(dictionary);
		}
		Dictionary<int, float> dictionary2 = DictionaryPool<int, float>.Get();
		foreach (var (id, num3) in character.EliteInfo.Levels)
		{
			if (num3 != 0)
			{
				EliteTrainingPoint data = CoreUtils.GetData(id, RuntimeConfigs.data.eliteTrainingPoints);
				for (int i = 0; i < data.attrId.Length; i++)
				{
					float value = data.attrIncreaseNum[i] * (float)num3;
					dictionary2[data.attrId[i]] = value;
				}
			}
		}
		int eliteActiveLevel = character.GetEliteActiveLevel();
		if (eliteActiveLevel == 0)
		{
			return;
		}
		List<int> ids = ListPool<int>.Get();
		TableRule.GetActiveEliteSkillGroupId(character.Id, eliteActiveLevel, ref ids);
		foreach (int item2 in ids)
		{
			SkillGroupLevelData skillGroupLevelData = TableRule.GetSkillGroupLevelData(item2, 1);
			if (skillGroupLevelData == null || skillGroupLevelData.skillProperty.Count <= 0)
			{
				continue;
			}
			foreach (Properties item3 in skillGroupLevelData.skillProperty)
			{
				if (dictionary2.ContainsKey(item3.property))
				{
					dictionary2[item3.property] += item3.value;
				}
				else
				{
					dictionary2.Add(item3.property, item3.value);
				}
			}
		}
		if (dictionary2.Count > 0)
		{
			character.systemProperty.ReplaceSystemProperties(dictionary2, SystemPropertySource.Elite);
		}
		DictionaryPool<int, float>.Release(dictionary2);
	}

	private void RemoveEliteProperty(BaseEventContent obj)
	{
		Character character = ((CharacterRefresh)obj).character;
		Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
		if (EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			entity.GetCompAbility().OnElitePointLevelReset();
		}
		properties.Clear();
		character.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.Elite, ref properties, withoutZero: true);
		if (properties.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("精英化重置时获取的精英化系统属性为空！");
			}
			DictionaryPool<int, float>.Release(properties);
			return;
		}
		foreach (KeyValuePair<int, float> item in properties)
		{
			character.systemProperty.CalSystemProperty(item.Key, 4, item.Value, remove: true);
		}
		character.DisPatchSystemPropertiesChange(character, properties, 4, isRemove: true);
		DictionaryPool<int, float>.Release(properties);
	}

	private void AddEliteProperty(BaseEventContent obj)
	{
		if (!(obj is CharacterRefresh { character: var character }))
		{
			return;
		}
		Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
		foreach (var (id, num3) in character.EliteInfo.Levels)
		{
			if (num3 != 0)
			{
				EliteTrainingPoint data = CoreUtils.GetData(id, RuntimeConfigs.data.eliteTrainingPoints);
				for (int i = 0; i < data.attrId.Length; i++)
				{
					float value = data.attrIncreaseNum[i] * (float)num3;
					properties[data.attrId[i]] = value;
				}
			}
		}
		int eliteActiveLevel = character.GetEliteActiveLevel();
		if (eliteActiveLevel == 0)
		{
			return;
		}
		List<int> ids = ListPool<int>.Get();
		TableRule.GetActiveEliteSkillGroupId(character.Id, eliteActiveLevel, ref ids);
		foreach (int item in ids)
		{
			SkillGroupLevelData skillGroupLevelData = TableRule.GetSkillGroupLevelData(item, 1);
			if (skillGroupLevelData == null || skillGroupLevelData.skillProperty.Count <= 0)
			{
				continue;
			}
			foreach (Properties item2 in skillGroupLevelData.skillProperty)
			{
				if (properties.ContainsKey(item2.property))
				{
					properties[item2.property] += item2.value;
				}
				else
				{
					properties.Add(item2.property, item2.value);
				}
			}
		}
		if (properties.Count > 0)
		{
			character.systemProperty.ReplaceSystemProperties(properties, SystemPropertySource.Elite);
		}
		character.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.Elite, ref properties, withoutZero: true);
		if (properties.Count > 0)
		{
			character.DisPatchSystemPropertiesChange(character, properties, 4);
		}
		DictionaryPool<int, float>.Release(properties);
	}

	private void OnCharacterLevelUp(BaseEventContent obj)
	{
		CharacterUpdateEvt characterUpdateEvt = (CharacterUpdateEvt)obj;
		if (characterUpdateEvt == null)
		{
			return;
		}
		Character character = characterUpdateEvt.character;
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		dictionary.Clear();
		foreach (Properties item in CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas).characterPorpertyAdd)
		{
			dictionary[item.property] = item.value * (float)(character.Level - 1);
		}
		character.systemProperty.ReplaceSystemProperties(dictionary, SystemPropertySource.LevelUp);
		Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
		character.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.LevelUp, ref properties, withoutZero: true);
		if (properties.Count > 0)
		{
			character.DisPatchSystemPropertiesChange(character, properties, 1);
		}
		DictionaryPool<int, float>.Release(properties);
		DictionaryPool<int, float>.Release(dictionary);
	}

	private void ChangeSystemPropertyByMap(BaseEventContent obj)
	{
		if (!(obj is ChangeSystemProperties { traget: var traget } changeSystemProperties))
		{
			return;
		}
		if (traget == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		if (changeSystemProperties.systemSource == 3)
		{
			traget.systemProperty.ClearSystemPropertiesBySource(SystemPropertySource.Equip);
		}
		if (changeSystemProperties.isReplace)
		{
			traget.systemProperty.ReplaceSystemProperties(changeSystemProperties.properties, (SystemPropertySource)changeSystemProperties.systemSource);
		}
		else
		{
			traget.systemProperty.CalSystemProperties(changeSystemProperties.properties, changeSystemProperties.systemSource, changeSystemProperties.isRemove);
		}
	}

	private void CharacterPropertiesRefresh(BaseEventContent obj)
	{
		if (!(obj is CharacterRefresh characterRefresh))
		{
			return;
		}
		if (characterRefresh.character == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("刷新属性的子世界角色为空");
			}
		}
		else
		{
			InitCharacterProperties(characterRefresh.character);
		}
	}

	public void InitCharacterProperties(Character character)
	{
		if (character == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("初始化角色系统属性失败：Character 为空。");
			}
			return;
		}
		if (character.HasInitializedSystemProperties)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"Character[{character.Id}] 的系统属性已初始化，跳过重复构建。");
			}
			return;
		}
		try
		{
			character.RefreshWithoutEquip();
			SetCharacterSystemPropertiesData(character);
			character.SetCharacterElement();
			character.MarkSystemPropertiesInitialized();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private async void CharacterRemove(BaseEventContent obj)
	{
		if (obj is CharacterRefresh { character: not null } characterRefresh)
		{
			await Singleton<GameManager>.instance.worldManager.ReleaseCharacterBattleEntity((SceneStatus)characterRefresh.sceneIndex, characterRefresh.character);
		}
	}

	private void PropertyHasChanged(BaseEventContent obj)
	{
		if (obj is SystemPropertyChange propertyChange)
		{
			AddCharacterCriticalChanceValue(propertyChange);
		}
	}

	private void AddCharacterCriticalChanceValue(SystemPropertyChange propertyChange)
	{
		Character beLongCharacter = propertyChange.beLongCharacter;
		if (beLongCharacter?.systemProperty != null && IsCriticalConversionCharacter(beLongCharacter))
		{
			float num;
			switch (propertyChange.propertyId)
			{
			default:
				return;
			case 4:
			case 400:
				num = propertyChange.changeVal * beLongCharacter.systemProperty.GetResultPropertyValue(57);
				break;
			case 57:
			case 5700:
				num = propertyChange.changeVal * beLongCharacter.systemProperty.GetResultPropertyValue(4);
				break;
			}
			if (!Mathf.Approximately(num, 0f))
			{
				beLongCharacter.systemProperty.CalSystemProperty(300, 8, num, propertyChange.isReduce);
				Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
				beLongCharacter.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.CriticalConversion, ref properties);
				beLongCharacter.DisPatchSystemPropertiesChange(beLongCharacter, properties, 8);
				DictionaryPool<int, float>.Release(properties);
			}
		}
	}

	public static bool TryCalculateCriticalConversionChance(Character character, float conversionRate, float criticalDamage, out float criticalChance)
	{
		criticalChance = 0f;
		if (!IsCriticalConversionCharacter(character))
		{
			return false;
		}
		criticalChance = conversionRate * criticalDamage;
		return true;
	}

	public static bool IsCriticalConversionCharacter(Character character)
	{
		if (character == null)
		{
			return false;
		}
		int key = character.Id;
		if (character.IsTrailCharacter)
		{
			int key2 = ((character.TrialProbationId > 0) ? character.TrialProbationId : character.Id);
			if (RuntimeConfigs.data?.entityCharacterProbations == null || !RuntimeConfigs.data.entityCharacterProbations.TryGetValue(key2, out var value) || value == null)
			{
				return false;
			}
			key = value.characterId;
		}
		if (RuntimeConfigs.data?.entityCharacterDatas != null && RuntimeConfigs.data.entityCharacterDatas.TryGetValue(key, out var value2))
		{
			return value2.mannerType == 2;
		}
		return false;
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChangeSystemProperties, ChangeSystemPropertyByMap);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_LevelUp, OnCharacterLevelUp);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_AddElite, AddEliteProperty);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_RemoveElite, RemoveEliteProperty);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_Add, CharacterPropertiesRefresh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_Remove, CharacterRemove);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SystemPropertyChange, PropertyHasChanged);
		SelectFirstEquipSlotInOverview = false;
		SelectFirstDiscSlotInEquipmentSubview = false;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.DrawCard);
		if (jumpData.Params[0] == 1 && jumpData.Params.Count >= 3)
		{
			switch (jumpData.Params[2])
			{
			case 1:
				flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.CharacterSkill);
				break;
			case 2:
				flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Equip);
				break;
			case 3:
				flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Elitist);
				break;
			}
		}
		if (flag)
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Hide,
			Message = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.CanNotGoTo)
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
		{
			defaultCharacterId = jumpData.Params[1],
			PageIndex = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0)
		});
	}
}
