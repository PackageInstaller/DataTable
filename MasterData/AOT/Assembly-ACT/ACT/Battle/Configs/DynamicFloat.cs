using System;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct DynamicFloat
{
	private const int MAX_RECURSION_DEPTH = 10;

	[ThreadStatic]
	private static int s_RecursionDepth;

	public ParamSource source;

	public float value;

	public string tableKey;

	public int paramId;

	public int ItemskillId;

	public int SkillGroupId;

	public string SkillTableKeyMul;

	public string SkillTableKeyConst;

	public ConfigFunction<float> functionValue;

	public int rogueParamIndex;

	public float GetFloat(Ability ability, ActionMemory memory = default(ActionMemory))
	{
		if (s_RecursionDepth >= 10)
		{
			_ = LuminApplication.LogEnabled;
			if (source != ParamSource.Const)
			{
				return 0f;
			}
			return value;
		}
		s_RecursionDepth++;
		try
		{
			switch (source)
			{
			case ParamSource.Const:
				return value;
			case ParamSource.AbilityConst:
			{
				if (ability?.abilityConst == null)
				{
					return 0f;
				}
				ability.abilityConst.TryGetValue(tableKey, out var result);
				return result;
			}
			case ParamSource.CharacterSkillTable:
				return GetTableKeyParamValue(ability, tableKey);
			case ParamSource.CharacterSkillTableParamId:
				if (paramId < 1 || paramId > ConstParamId.ParamIdNames.Length)
				{
					_ = LuminApplication.LogEnabled;
					return 1f;
				}
				return GetTableKeyParamValue(ability, ConstParamId.ParamIdNames[paramId - 1]);
			case ParamSource.ItemSkillTable:
			{
				int itemskillId = ItemskillId;
				RuntimeConfigs.data.skillDetailLevelDatas.TryGetValue(itemskillId, out var skillDetailLevelData);
				int stringArrIndex = ability.skillLevelInfo.GetStringArrIndex(tableKey);
				if (!string.IsNullOrEmpty(tableKey) && stringArrIndex >= 0 && skillDetailLevelData != null)
				{
					if (ability.owner.TryGetCompAbility(out CompAbility component))
					{
						BMap<int, ModifiedSkill> modifiedSkills = component.modifiedSkills;
						if (modifiedSkills != null && modifiedSkills.TryGetValue(itemskillId, out var modifiedSkill))
						{
							return skillDetailLevelData.param[stringArrIndex] + modifiedSkill.param[stringArrIndex];
						}
					}
					return skillDetailLevelData.param[stringArrIndex];
				}
				return 0f;
			}
			case ParamSource.SkillGroupLevel:
			{
				byte skillGroupEventualLevel = ability.owner.GetCompCharacter().characterSource.GetSkillGroupEventualLevel(SkillGroupId);
				if (skillGroupEventualLevel != 0)
				{
					float num = Mathf.Max(GetTableKeyParamValue(ability, SkillTableKeyMul), 0f);
					float num2 = Mathf.Max(GetTableKeyParamValue(ability, SkillTableKeyConst), 0f);
					return (float)(int)skillGroupEventualLevel * num + num2;
				}
				return 0f;
			}
			case ParamSource.FunctionValue:
				if (ability != null)
				{
					_ = ability.owner;
					if (0 == 0 && functionValue != null)
					{
						if (memory.Equals(default))
						{
							memory = new ActionMemory(ability.owner, ability.owner, ability.owner, null, ability);
						}
						return functionValue.Return(memory);
					}
				}
				return 0f;
			case ParamSource.RogueCombatEffect:
			{
				if (MonoECS.instance.sceneStatus != SceneStatus.Rogue)
				{
					_ = LuminApplication.LogEnabled;
					return 0f;
				}
				_ = ability?.config?.name;
				float[] paras = CoreUtils.GetData(ability.skillLevelInfo.id, RuntimeConfigs.data.combatEffects).paras;
				if (rogueParamIndex < 0 || paras == null)
				{
					return 0f;
				}
				if (rogueParamIndex < paras.Length)
				{
					return paras[rogueParamIndex];
				}
				_ = LuminApplication.LogEnabled;
				return 0f;
			}
			default:
				return 0f;
			}
		}
		finally
		{
			s_RecursionDepth--;
		}
	}

	public static float GetTableKeyParamValue(Ability ability, string key)
	{
		if (string.IsNullOrEmpty(key) || ability == null)
		{
			return 1f;
		}
		bool flag = key.StartsWith("para");
		int skillIdWithLevel = ability.skillLevelInfo.GetSkillIdWithLevel();
		int stringArrIndex = ability.skillLevelInfo.GetStringArrIndex(key);
		if (!RuntimeConfigs.data.skillDetailLevelDatas.TryGetValue(skillIdWithLevel, out var skillDetailLevelData))
		{
			_ = LuminApplication.LogEnabled;
			return 1f;
		}
		float[] array = (flag ? skillDetailLevelData.param1 : skillDetailLevelData.param);
		if (stringArrIndex < 0 || stringArrIndex >= array.Length)
		{
			_ = LuminApplication.LogEnabled;
			return 1f;
		}
		return array[stringArrIndex];
	}

	public float GetFloatDifValue(Ability ability, int value = 0)
	{
		if (string.IsNullOrEmpty(tableKey))
		{
			return 0f;
		}
		int skillIdWithLevel = ability.skillLevelInfo.GetSkillIdWithLevel();
		int stringArrIndex = ability.skillLevelInfo.GetStringArrIndex(tableKey);
		if (!RuntimeConfigs.data.skillDetailLevelDatas.TryGetValue(skillIdWithLevel, out var skillDetailLevelData) || stringArrIndex < 0)
		{
			return 0f;
		}
		if (value <= 0)
		{
			return skillDetailLevelData.param[stringArrIndex];
		}
		int beforeSkillIdLevel = ability.skillLevelInfo.GetBeforeSkillIdLevel(value);
		if (RuntimeConfigs.data.skillDetailLevelDatas.TryGetValue(beforeSkillIdLevel, out var skillDetailLevelData2))
		{
			return skillDetailLevelData.param[stringArrIndex] - skillDetailLevelData2.param[stringArrIndex];
		}
		return skillDetailLevelData.param[stringArrIndex];
	}
}
