using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompCharacter : EcsComponent, ITableKey
{
	public ICharacterSource characterSource;

	public void InitProperties(CompAbility compAbility)
	{
		compAbility.characterDamageType = (CharacterDamageType)RuntimeConfigs.data.entityCharacterDatas[characterSource.Id()].characterDamageType;
		int[] characterTagGroup = RuntimeConfigs.data.entityCharacterDatas[characterSource.Id()].characterTagGroup;
		compAbility.characterFrequencyType = GameUtility.ToCharacterFrequencyFlags(characterTagGroup);
		compAbility.mannerType = (MannerType)RuntimeConfigs.data.entityCharacterDatas[characterSource.Id()].mannerType;
		Character character = characterSource as Character;
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		foreach (Properties item in CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas).characterPorpertyBase)
		{
			dictionary.Add(item.property, item.value);
		}
		compAbility.PushProperties(dictionary, needCal: false, PropertySource.Character, character.Id);
		DictionaryPool<int, float>.Release(dictionary);
		if (character != null)
		{
			Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
			foreach (SystemPropertySource value in Enum.GetValues(typeof(SystemPropertySource)))
			{
				if (value != SystemPropertySource.None)
				{
					properties.Clear();
					if (character.systemProperty == null)
					{
						return;
					}
					character.systemProperty.GetSystemPropertiesBySource(value, ref properties, withoutZero: true);
					if (properties.Count > 0)
					{
						compAbility.PushProperties(properties, needCal: false, PropertySource.System, (int)value);
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning($"[系统]'{value}'修改的属性值没有数据，如果是没进行过系统养成的角色，请忽略，若不是，检查一下!!!!!!!!!!!!!!");
					}
				}
			}
			DictionaryPool<int, float>.Release(properties);
		}
		compAbility.CalAllProperty();
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		characterSource = null;
	}

	public void InitDummyAbilities(CompAbility compAbility)
	{
		int key = characterSource.Id();
		Dictionary<int, EntityCharacterData> entityCharacterDatas = RuntimeConfigs.data.entityCharacterDatas;
		Dictionary<int, SkillGroupData> skillGroupDatas = RuntimeConfigs.data.skillGroupDatas;
		EntityCharacterData entityCharacterData = entityCharacterDatas[key];
		ObjectPool<Ability> abilityPool = GameManager.abilitySystem.abilityPool;
		int[] skillGroupIds = entityCharacterData.skillGroupIds;
		foreach (int num in skillGroupIds)
		{
			byte skillGroupLevel = characterSource.GetSkillGroupLevel(num);
			if (skillGroupLevel == 0)
			{
				continue;
			}
			SkillGroupData data = CoreUtils.GetData(num, skillGroupDatas);
			if (data == null)
			{
				continue;
			}
			int[] skillTotalIds = data.skillTotalIds;
			foreach (int num2 in skillTotalIds)
			{
				MPSkill skillLevelInfo = new MPSkill
				{
					id = num2,
					level = skillGroupLevel
				};
				Ability ability = abilityPool.Get();
				ability.Init(compAbility.owner, compAbility.owner, AbilitySource.UpgradeSkill, skillLevelInfo);
				if (data.skillType == 12)
				{
					SkillDetailData data2 = CoreUtils.GetData(num2, RuntimeConfigs.data.skillDetailDatas);
					if (data2 == null)
					{
						Debug.LogError($"{num2} 核心被动添加失败！");
					}
					else
					{
						compAbility.AddAbility(compAbility.owner, data2.abilityName, AbilitySource.UpgradeSkill, skillLevelInfo, 1);
					}
				}
				else
				{
					if (compAbility.dummyAbilities.ContainsKey(skillLevelInfo.id))
					{
						abilityPool.Release(compAbility.dummyAbilities[skillLevelInfo.id]);
					}
					compAbility.dummyAbilities[skillLevelInfo.id] = ability;
				}
			}
		}
	}
}
