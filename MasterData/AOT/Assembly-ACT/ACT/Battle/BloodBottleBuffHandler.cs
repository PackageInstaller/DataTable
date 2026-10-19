using System.Collections.Generic;
using System.Text;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.RichText;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class BloodBottleBuffHandler : Singleton<BloodBottleBuffHandler>
{
	public class SkillCache
	{
		public int RecoverSkill;

		public int ActiveSkill;

		public int PassiveSkill;
	}

	public BMap<(int bottleId, int level), SkillCache> bottleBuffCache;

	private Dictionary<int, BloodBottleData> m_BloodBottles => Model<BloodBottleModel>.Interface.curSceneBloodBottleInfo._allBottles;

	public BSet<int> posstiveBuffGroup { get; private set; }

	public BSet<int> activeBuffGroup { get; private set; }

	public BSet<int> bottleEquipMatBuff { get; private set; }

	public string curBuff { get; private set; } = "";

	public override void Init()
	{
		if (posstiveBuffGroup == null)
		{
			posstiveBuffGroup = BSetPool<int>.Default.Get();
		}
		if (activeBuffGroup == null)
		{
			activeBuffGroup = BSetPool<int>.Default.Get();
		}
		if (bottleBuffCache == null)
		{
			bottleBuffCache = BMapPool<(int, int), SkillCache>.Default.Get();
		}
		if (bottleEquipMatBuff == null)
		{
			bottleEquipMatBuff = BSetPool<int>.Default.Get();
		}
		foreach (KeyValuePair<int, BloodBottleData> bloodBottle in m_BloodBottles)
		{
			CacheBottleSkills(bloodBottle.Key);
		}
		foreach (BloodBottleData localBloodBottle in Model<BloodBottleModel>.Interface.localBloodBottles)
		{
			CacheBottleSkills(localBloodBottle);
		}
		base.Init();
	}

	public override void UnInit()
	{
		if (posstiveBuffGroup != null)
		{
			BSetPool<int>.Default.Recycle(posstiveBuffGroup);
			posstiveBuffGroup = null;
		}
		if (activeBuffGroup != null)
		{
			BSetPool<int>.Default.Recycle(activeBuffGroup);
			activeBuffGroup = null;
		}
		if (bottleBuffCache != null)
		{
			BMapPool<(int, int), SkillCache>.Default.Recycle(bottleBuffCache);
			bottleBuffCache = null;
		}
		if (bottleEquipMatBuff != null)
		{
			BSetPool<int>.Default.Recycle(bottleEquipMatBuff);
			bottleEquipMatBuff = null;
		}
		base.UnInit();
	}

	public void RefreshBuffData()
	{
		posstiveBuffGroup.Clear();
		activeBuffGroup.Clear();
		bottleBuffCache.Clear();
		bottleEquipMatBuff.Clear();
		foreach (KeyValuePair<int, BloodBottleData> bloodBottle in m_BloodBottles)
		{
			CacheBottleSkills(bloodBottle.Key);
		}
		foreach (BloodBottleData localBloodBottle in Model<BloodBottleModel>.Interface.localBloodBottles)
		{
			CacheBottleSkills(localBloodBottle);
		}
	}

	private void CacheBottleSkills(int bottleId)
	{
		BloodBottleData bloodBottleById = Model<BloodBottleModel>.Interface.GetBloodBottleById(bottleId);
		CacheBottleSkills(bloodBottleById);
	}

	public void CacheBottleSkills(BloodBottleData bottleData)
	{
		if (bottleData != null)
		{
			int maxLevel = bottleData.maxLevel;
			for (int i = 1; i <= maxLevel; i++)
			{
				SkillCache value = new SkillCache
				{
					RecoverSkill = GetCachedSkill(bottleData.healSkillId, i),
					ActiveSkill = GetCachedSkill(bottleData.usedSkillId, i)
				};
				bottleBuffCache[(bottleData.uid, i)] = value;
			}
		}
	}

	private int GetCachedSkill(int skillGroupId, int level)
	{
		if (skillGroupId == 0 || level == 0)
		{
			return 0;
		}
		if (!RuntimeConfigs.data.skillGroupDatas.TryGetValue(skillGroupId, out var value))
		{
			return 0;
		}
		return CoreUtils.GetData(value.skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas).id;
	}

	public void UpdateBuffData(int bottleId, bool exceptMaterial = false)
	{
		if (bottleId == 0)
		{
			activeBuffGroup.Clear();
			posstiveBuffGroup.Clear();
			bottleEquipMatBuff.Clear();
			return;
		}
		BloodBottleData bloodBottleData = ((bottleId == Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId) ? Model<BloodBottleModel>.Interface.CurTeamEquipBottle : Model<BloodBottleModel>.Interface.GetBloodBottleById(bottleId));
		if (bloodBottleData != null && bottleBuffCache.TryGetValue((bloodBottleData.uid, bloodBottleData.curLevel), out var value))
		{
			activeBuffGroup.Clear();
			posstiveBuffGroup.Clear();
			if (value.RecoverSkill != 0)
			{
				activeBuffGroup.Add(value.RecoverSkill);
			}
			if (value.ActiveSkill != 0)
			{
				posstiveBuffGroup.Add(value.ActiveSkill);
			}
			if (value.PassiveSkill != 0)
			{
				posstiveBuffGroup.Add(value.PassiveSkill);
			}
			if (!exceptMaterial)
			{
				UpdateMaterialBuff(bottleId);
			}
		}
	}

	public void UpdateMaterialBuff(int bottleId)
	{
		BloodBottleData bloodBottleData = ((bottleId == Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId) ? Model<BloodBottleModel>.Interface.CurTeamEquipBottle : Model<BloodBottleModel>.Interface.GetBloodBottleById(bottleId));
		if (bloodBottleData == null)
		{
			return;
		}
		bottleEquipMatBuff.Clear();
		foreach (int materialId in bloodBottleData.materialIds)
		{
			if (materialId != 0 && materialId != -1 && RuntimeConfigs.data.skillGroupDatas.TryGetValue(RuntimeConfigs.data.potionAdditivess[materialId].useAbilityName, out var value))
			{
				bottleEquipMatBuff.Add(value.skillTotalIds[0]);
			}
		}
	}

	private void AddBuffToEntity(Entity entity, int buffId)
	{
		if (buffId != 0)
		{
			SkillDetailData data = CoreUtils.GetData(buffId, RuntimeConfigs.data.skillDetailDatas);
			if (data != null && entity.IsCharacter() && entity.IsAlive())
			{
				MPSkill skillLevelInfo = new MPSkill
				{
					id = data.id,
					level = 1
				};
				entity.GetCompAbility()?.AddAbility(entity, data.abilityName, AbilitySource.BloodBottle, skillLevelInfo, 1);
			}
		}
	}

	public void ApplyAllBuffsToEntity(Entity entity, bool exceptMaterial = false)
	{
		if (entity.IsValid)
		{
			RemoveAllBuffsFromEntity(entity);
			AddPassiveBuffs(entity);
			if (!exceptMaterial)
			{
				AddMaterialBuffs(entity);
			}
		}
	}

	public void AddAllBuffsToEntityWithoutRemove(Entity entity, bool exceptMaterial = false)
	{
		if (entity.IsValid)
		{
			AddPassiveBuffs(entity);
			if (!exceptMaterial)
			{
				AddMaterialBuffs(entity);
			}
		}
	}

	public void RemoveAllBuffsFromEntity(Entity entity, bool exceptMaterial = false)
	{
		foreach (int item in posstiveBuffGroup)
		{
			SkillDetailData data = CoreUtils.GetData(item, RuntimeConfigs.data.skillDetailDatas);
			entity.GetCompAbility()?.RemoveAbility(data.abilityName);
		}
		if (!exceptMaterial && entity.IsValid)
		{
			RemoveMaterialBuffs(entity);
		}
	}

	private void AddPassiveBuffs(Entity eb)
	{
		foreach (int item in posstiveBuffGroup)
		{
			AddBuffToEntity(eb, item);
		}
	}

	private void AddActiveBuffs(Entity eb)
	{
		foreach (int item in activeBuffGroup)
		{
			AddBuffToEntity(eb, item);
		}
	}

	public void AddMaterialBuffs(Entity eb)
	{
		if (eb == null)
		{
			return;
		}
		foreach (int item in bottleEquipMatBuff)
		{
			AddBuffToEntity(eb, item);
		}
	}

	public void RemoveMaterialBuffs(Entity eb)
	{
		foreach (int item in bottleEquipMatBuff)
		{
			SkillDetailData data = CoreUtils.GetData(item, RuntimeConfigs.data.skillDetailDatas);
			eb.GetCompAbility()?.RemoveAbility(data?.abilityName);
		}
	}

	public void ChangeCurBuff(string _buff)
	{
		curBuff = _buff;
	}

	private SkillGroupData GetSkillGroupData(int groupId)
	{
		return CoreUtils.GetData(groupId, RuntimeConfigs.data.skillGroupDatas);
	}

	private SkillGroupLevelData GetSkillGroupLevelData(int skillGroupId, int bottleLevel)
	{
		int num = skillGroupId * 100 + bottleLevel;
		if (num != 0)
		{
			return CoreUtils.GetData(num, RuntimeConfigs.data.skillGroupLevelDatas);
		}
		return null;
	}

	public string GetSpecifyLevelBottleSkillDes(BloodBottleData bottle, StringBuilder sb, int bottleLevel, bool detailDesc)
	{
		PotionData data = CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas);
		SkillGroupData skillGroupData = GetSkillGroupData(data.healSkillId);
		SkillGroupData skillGroupData2 = GetSkillGroupData(data.useExtraSkillId);
		if (skillGroupData == null && skillGroupData2 == null)
		{
			return string.Empty;
		}
		SkillGroupLevelData skillGroupLevelData = GetSkillGroupLevelData(skillGroupData?.id ?? 0, bottleLevel);
		SkillGroupLevelData skillGroupLevelData2 = GetSkillGroupLevelData(skillGroupData2?.id ?? 0, 1);
		if (skillGroupLevelData == null && skillGroupLevelData2 == null)
		{
			return string.Empty;
		}
		sb.Clear();
		if (skillGroupLevelData != null)
		{
			for (int i = 0; i < skillGroupLevelData.skillDes.Length; i++)
			{
				if (!AppendSkillDes(skillGroupLevelData.skillDes[i], detailDesc, isNotHealSkill: true))
				{
					return string.Empty;
				}
				if (i == skillGroupLevelData.skillDes.Length - 1)
				{
					sb.Append("。");
				}
			}
		}
		if (skillGroupLevelData2 != null)
		{
			for (int j = 0; j < skillGroupLevelData2.skillDes.Length; j++)
			{
				if (!AppendSkillDes(skillGroupLevelData2.skillDes[j], detailDesc, isNotHealSkill: false))
				{
					return string.Empty;
				}
				if (j == skillGroupLevelData2.skillDes.Length - 1)
				{
					sb.Append("。");
				}
			}
		}
		return sb.ToString();
		bool AppendSkillDes(int massageDataId, bool flag, bool isNotHealSkill)
		{
			SkillDetailMessageData data2 = CoreUtils.GetData(massageDataId, RuntimeConfigs.data.skillDetailMessageDatas);
			if (data2 == null)
			{
				return false;
			}
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", flag ? data2.detailDescLocal : data2.briefDescLocal, isSmart: false);
			string value = CustomTagParser.ReplaceText(data2.skillid, localizeString, (!isNotHealSkill) ? 1 : bottleLevel);
			sb.Append(value);
			return true;
		}
	}

	public string GetBottleMatDesc(BloodBottleMaterial mat, bool isDetailDesc)
	{
		return GetBottleMatNameByUid(mat.uid, isDetailDesc);
	}

	public string GetBottleMatNameByUid(int matUid, bool isDetailDesc)
	{
		int useAbilityName = CoreUtils.GetData(matUid, RuntimeConfigs.data.potionAdditivess).useAbilityName;
		if (useAbilityName == 0)
		{
			return string.Empty;
		}
		SkillGroupData skillGroupData = GetSkillGroupData(useAbilityName);
		if (skillGroupData == null)
		{
			return string.Empty;
		}
		SkillGroupLevelData skillGroupLevelData = GetSkillGroupLevelData(skillGroupData.id, 1);
		if (skillGroupLevelData == null)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		int num = -1;
		int[] skillDes = skillGroupLevelData.skillDes;
		foreach (int id in skillDes)
		{
			num++;
			SkillDetailMessageData data = CoreUtils.GetData(id, RuntimeConfigs.data.skillDetailMessageDatas);
			if (data == null)
			{
				return string.Empty;
			}
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", isDetailDesc ? data.detailDescLocal : data.briefDescLocal, isSmart: false);
			string value = CustomTagParser.ReplaceText(data.skillid, localizeString, 1);
			stringBuilder.Append(value);
			if (num == skillGroupLevelData.skillDes.Length - 1)
			{
				stringBuilder.Append("。");
			}
		}
		return stringBuilder.ToString();
	}
}
