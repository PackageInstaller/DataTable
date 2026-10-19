using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Game.Data;
using ACT.MultiPlayer;
using Bamboo.Collections;

namespace ACT.Core;

public static class TableRule
{
	public static int GetWeaponUpGradeId(int upGradeTypeId, int level)
	{
		return upGradeTypeId * 100 + level;
	}

	public static int GetWeaponBreakId(int weaponId, int stage)
	{
		return weaponId * 10 + stage;
	}

	public static int GetCharacterLevelId(this Character character)
	{
		return GetCharacterLevelId(character.Id, character.Stage);
	}

	public static int GetCharacterNextStageId(this Character character)
	{
		return GetCharacterNextStageId(character.Id, character.Stage);
	}

	public static int GetCharacterLastStageId(this Character character)
	{
		return GetLastCharacterLevelId(character.Id, character.Stage);
	}

	public static int GetCharacterLevelId(int id, int stage)
	{
		return id * 100 + stage;
	}

	public static int GetCharacterNextStageId(int id, int stage)
	{
		return id * 100 + stage + 1;
	}

	public static int GetLastCharacterLevelId(int id, int stage)
	{
		return id * 100 + stage - 1;
	}

	public static int GetConstellationId(int id, int stage)
	{
		return id * 10 + stage;
	}

	public static int GetSkillGroupId(int skillId)
	{
		return skillId / 10;
	}

	public static int GetSkillGroupLevelId(this SkillGroupData skillGroupData, int level)
	{
		return GetSkillGroupLevelId(skillGroupData.id, level);
	}

	public static int GetSkillGroupLevelId(int skillGroupId, int level)
	{
		return skillGroupId * 100 + level;
	}

	public static void GetAllSkillGroups(int characterId, List<int> groups)
	{
		for (int i = 0; i < 7; i++)
		{
			if (RuntimeConfigs.data.entityCharacterLevelDatas.TryGetValue(characterId * 100 + i, out var value))
			{
				int[] newSkill = value.newSkill;
				foreach (int item in newSkill)
				{
					groups.Add(item);
				}
			}
		}
	}

	public static void GetAllConstellations(int characterId, List<int> groups)
	{
		for (int i = 1; i <= 6; i++)
		{
			groups.Add(characterId * 10 + i);
		}
	}

	public static int GetCharacterMaxXpId(this Character character)
	{
		_ = RuntimeConfigs.data.entityCharacterDatas[character.Id];
		int levelMax = RuntimeConfigs.data.entityCharacterLevelDatas[character.GetCharacterLevelId()].levelMax;
		return 1000 + levelMax;
	}

	public static int GetCharacterXpId(this Character character)
	{
		_ = RuntimeConfigs.data.entityCharacterDatas[character.Id];
		return 1000 + character.Level;
	}

	public static int GetCharacterNextXpId(this Character character)
	{
		_ = RuntimeConfigs.data.entityCharacterDatas[character.Id];
		return 1000 + character.Level + 1;
	}

	public static int GetCharacterXpId(this Character character, int index)
	{
		_ = RuntimeConfigs.data.entityCharacterDatas[character.Id];
		return 1000 + index;
	}

	public static int GetSkillIdWithLevel(this MPSkill skill)
	{
		return skill.id * 100 + skill.level;
	}

	public static int GetBeforeSkillIdLevel(this MPSkill skill, int value)
	{
		return skill.id * 100 + value;
	}

	public static SkillDetailLevelData GetSkillDetailLevelData(this MPSkill skill)
	{
		return CoreUtils.GetData(skill.id * 100 + skill.level, RuntimeConfigs.data.skillDetailLevelDatas);
	}

	public static SkillGroupLevelData GetSkillGroupLevelData(int skillGroupId, int level)
	{
		if (level == 0)
		{
			return null;
		}
		if (RuntimeConfigs.data.skillGroupDatas.ContainsKey(skillGroupId))
		{
			return CoreUtils.GetData(skillGroupId * 100 + level, RuntimeConfigs.data.skillGroupLevelDatas);
		}
		return null;
	}

	public static int GetStringArrIndex(this MPSkill skill, string value)
	{
		if (RuntimeConfigs.data.skillDetailDatas.TryGetValue(skill.id, out var value2))
		{
			string[] array = value2.validParam;
			if (value.StartsWith("param"))
			{
				array = value2.validParam1;
			}
			int num = Array.IndexOf(array, value);
			if (num == -1)
			{
				_ = LuminApplication.LogEnabled;
			}
			return num;
		}
		_ = LuminApplication.LogEnabled;
		return -1;
	}

	public static void GetActiveEliteSkillIds(int characterId, int activeLevelNum, ref BList<int> ids)
	{
		ids.Clear();
		int[] array = CoreUtils.GetData(characterId, RuntimeConfigs.data.eliteTrainingMaps)?.characterSkill;
		if (array != null)
		{
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill1Num)
			{
				ids.Add(CoreUtils.GetData(array[0], RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0]);
			}
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill2Num)
			{
				ids.Add(CoreUtils.GetData(array[1], RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0]);
			}
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill3Num)
			{
				ids.Add(CoreUtils.GetData(array[2], RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0]);
			}
		}
	}

	public static void GetActiveEliteSkillGroupId(int characterId, int activeLevelNum, ref List<int> ids)
	{
		ids.Clear();
		int[] array = CoreUtils.GetData(characterId, RuntimeConfigs.data.eliteTrainingMaps)?.characterSkill;
		if (array != null && array.Length > 0)
		{
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill1Num)
			{
				ids.Add(array[0]);
			}
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill2Num)
			{
				ids.Add(array[1]);
			}
			if (activeLevelNum >= RuntimeConfigs.data.game.eliteSkill3Num)
			{
				ids.Add(array[2]);
			}
		}
	}

	public static int GetLevelMaterialId(this EquipData equipData, int level)
	{
		return equipData.space * 10000 + level;
	}

	public static int GetMissionId(long subMissionID)
	{
		return GetMissionId((int)subMissionID);
	}

	public static int GetMissionId(int subMissionID)
	{
		return subMissionID / 100;
	}

	public static int GetNpcTableID(int npcConfigUid)
	{
		return npcConfigUid / 1000 % 1000;
	}

	public static int GetNpcMapAreaID(int npcConfigUid)
	{
		return npcConfigUid / 1000000 % 100;
	}

	public static int GetNpcTypeID(int npcConfigUid)
	{
		return npcConfigUid / 100000000;
	}

	public static int GenerateNpcUniqueID(int areaID, int npcTypeID, int npcTableID, int configIndex)
	{
		return npcTypeID * 100000000 + areaID * 1000000 + npcTableID * 1000 + configIndex;
	}

	public static PotionData GetBloodBottleByItemId(int itemId)
	{
		return RuntimeConfigs.data.potionDatas.FirstOrDefault((KeyValuePair<int, PotionData> i) => i.Value.itemId == itemId).Value;
	}

	public static PotionAdditives GetBloodBottleMaterialByItemId(int itemId)
	{
		return RuntimeConfigs.data.potionAdditivess.FirstOrDefault((KeyValuePair<int, PotionAdditives> i) => i.Value.itemId == itemId).Value;
	}
}
