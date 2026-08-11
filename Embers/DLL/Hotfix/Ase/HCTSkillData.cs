#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using Unity.Mathematics;

namespace Ase;

public class HCTSkillData : ViewModelBase
{
	private int skillId;

	private string icon = "";

	private string oriIcon = "";

	private bool isSkinIcon;

	private string name = "";

	private int level;

	private string desc = "";

	private float baseDamage;

	private float baseFixDamage;

	private float baseTenacity;

	private float baseFixTenacity;

	private HeroSkillTypeEnum skillTypeEnum;

	private string skillType = "";

	private string skillFunc = "";

	private Dictionary<string, Ase.ECS.PropertyData> propertyList;

	private bool oriCoolingZero;

	private bool isChangeCooling;

	private float coolingDeltaEffect;

	private float coolingDeltaLevel;

	private List<string> skillConsumeKeyName;

	private List<float> skillConsumeVal;

	private bool isChangeConsume;

	private List<int> buffIds;

	private List<HCTSkillData> deriveSkills = new List<HCTSkillData>();

	private List<int> hideDeriveSkillDesc = new List<int>();

	private bool isOriginSkill;

	private List<DRCultivateSkillEffect> cultivateSkillEffect;

	private List<DRCultivateSkillLevel> cultivateSkillLevel;

	public List<DRCultivateSkillEffect> CultivateSkillEffect => cultivateSkillEffect;

	public List<DRCultivateSkillLevel> CultivateSkillLevel => cultivateSkillLevel;

	public int SkillId => skillId;

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
			IsSkinIcon = !string.IsNullOrEmpty(icon) && icon != oriIcon;
		}
	}

	public string OriIcon
	{
		get
		{
			return oriIcon;
		}
		private set
		{
			Set(ref oriIcon, value, "OriIcon");
			IsSkinIcon = !string.IsNullOrEmpty(icon) && icon != oriIcon;
		}
	}

	public bool IsSkinIcon
	{
		get
		{
			return isSkinIcon;
		}
		private set
		{
			Set(ref isSkinIcon, value, "IsSkinIcon");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public int Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public string SkillType
	{
		get
		{
			return skillType;
		}
		private set
		{
			Set(ref skillType, value, "SkillType");
		}
	}

	public HeroSkillTypeEnum SkillTypeEnum => skillTypeEnum;

	public string SkillFunc
	{
		get
		{
			return skillFunc;
		}
		private set
		{
			Set(ref skillFunc, value, "SkillFunc");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public List<float> SkillConsumeVal => skillConsumeVal;

	public List<string> SkillConsumeKeyName => skillConsumeKeyName;

	public bool IsChangeCooling => isChangeCooling;

	public bool IsChangeConsume => isChangeConsume;

	public List<HCTSkillData> DeriveSkills => deriveSkills;

	public List<int> HideDeriveSkillDesc => hideDeriveSkillDesc;

	public bool IsOriginSkill
	{
		get
		{
			return isOriginSkill;
		}
		private set
		{
			Set(ref isOriginSkill, value, "IsOriginSkill");
		}
	}

	public List<int> BuffIds => buffIds;

	public static HCTSkillData CreateDerive(DRHeroSKillConfig skillConfig, DRHeroTalentBig talentBig, HCTSkillData parentSkill)
	{
		HCTSkillData hCTSkillData = new HCTSkillData();
		hCTSkillData.skillId = skillConfig.Id;
		hCTSkillData.name = skillConfig.Name;
		hCTSkillData.icon = skillConfig.Icon;
		hCTSkillData.oriIcon = skillConfig.Icon;
		DRHeroSKillInfo heroSkillInfo = GetHeroSkillInfo(skillConfig.Id, skillConfig.HeroId);
		if (heroSkillInfo != null)
		{
			hCTSkillData.skillTypeEnum = heroSkillInfo.HeroSkillTypeEnum;
		}
		hCTSkillData.skillType = skillConfig.SkillType;
		hCTSkillData.skillFunc = skillConfig.ButtonTag;
		hCTSkillData.desc = skillConfig.Desc;
		hCTSkillData.isOriginSkill = false;
		hCTSkillData.oriCoolingZero = skillConfig.CoolingTime <= 0f;
		hCTSkillData.level = parentSkill.Level;
		hCTSkillData.InitPropertys(skillConfig, parentSkill);
		hCTSkillData.InitConsumeCondition(skillConfig.ConsumeCondition);
		hCTSkillData.InitDeriveLevelConsume(talentBig);
		hCTSkillData.baseDamage = skillConfig.BaseDamage;
		hCTSkillData.baseTenacity = skillConfig.BaseTenacity;
		hCTSkillData.baseFixDamage = skillConfig.FixDamage;
		hCTSkillData.baseFixTenacity = skillConfig.FixTenacity;
		return hCTSkillData;
	}

	public static HCTSkillData CreateOrigin(DRHeroSKillConfig skillConfig, DRHeroTalentBig talentBig, DRHeroTalentSmall[] talentSmalls)
	{
		HCTSkillData hCTSkillData = new HCTSkillData();
		hCTSkillData.skillId = skillConfig.Id;
		hCTSkillData.name = skillConfig.Name;
		hCTSkillData.icon = skillConfig.Icon;
		hCTSkillData.oriIcon = skillConfig.Icon;
		DRHeroSKillInfo heroSkillInfo = GetHeroSkillInfo(skillConfig.Id, skillConfig.HeroId);
		if (heroSkillInfo != null)
		{
			hCTSkillData.skillTypeEnum = heroSkillInfo.HeroSkillTypeEnum;
		}
		hCTSkillData.skillType = skillConfig.SkillType;
		hCTSkillData.skillFunc = skillConfig.ButtonTag;
		hCTSkillData.desc = skillConfig.Desc;
		hCTSkillData.oriCoolingZero = skillConfig.CoolingTime <= 0f;
		hCTSkillData.isOriginSkill = true;
		hCTSkillData.level = talentBig.Level;
		hCTSkillData.baseDamage = skillConfig.BaseDamage;
		hCTSkillData.baseTenacity = skillConfig.BaseTenacity;
		hCTSkillData.baseFixDamage = skillConfig.FixDamage;
		hCTSkillData.baseFixTenacity = skillConfig.FixTenacity;
		hCTSkillData.InitPropertys(skillConfig);
		hCTSkillData.InitConsumeCondition(skillConfig.ConsumeCondition);
		hCTSkillData.InitLevelEffect(talentBig);
		return hCTSkillData;
	}

	public static HCTSkillData CreateByDestiny(DRHeroSKillConfig skillConfig)
	{
		HCTSkillData hCTSkillData = new HCTSkillData();
		hCTSkillData.skillId = skillConfig.Id;
		hCTSkillData.name = skillConfig.Name;
		hCTSkillData.icon = skillConfig.Icon;
		hCTSkillData.oriIcon = skillConfig.Icon;
		DRHeroSKillInfo heroSkillInfo = GetHeroSkillInfo(skillConfig.Id, skillConfig.HeroId);
		if (heroSkillInfo != null)
		{
			hCTSkillData.skillTypeEnum = heroSkillInfo.HeroSkillTypeEnum;
		}
		hCTSkillData.skillType = skillConfig.SkillType;
		hCTSkillData.skillFunc = skillConfig.ButtonTag;
		hCTSkillData.desc = skillConfig.Desc;
		hCTSkillData.isOriginSkill = false;
		hCTSkillData.oriCoolingZero = skillConfig.CoolingTime <= 0f;
		hCTSkillData.InitPropertys(skillConfig);
		hCTSkillData.InitConsumeCondition(skillConfig.ConsumeCondition);
		hCTSkillData.baseDamage = skillConfig.BaseDamage;
		hCTSkillData.baseTenacity = skillConfig.BaseTenacity;
		hCTSkillData.baseFixDamage = skillConfig.FixDamage;
		hCTSkillData.baseFixTenacity = skillConfig.FixTenacity;
		return hCTSkillData;
	}

	public static HCTSkillData CreatePassive(HeroSkillTypeEnum typeEnum, string typeName, string name, string icon = "")
	{
		return new HCTSkillData
		{
			skillTypeEnum = typeEnum,
			skillType = typeName,
			name = name,
			icon = icon,
			oriIcon = icon,
			isOriginSkill = true
		};
	}

	public void RefreshPassive(HeroSkillTypeEnum typeEnum, string typeName, string name, string icon = "")
	{
		skillTypeEnum = typeEnum;
		Name = name;
		SkillType = typeName;
		IsOriginSkill = true;
		Icon = icon;
		OriIcon = icon;
	}

	private static DRHeroSKillInfo GetHeroSkillInfo(int skillId, int heroId)
	{
		DRHeroSKillInfo dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo p) => p.HeroId == heroId && p.SkillId == skillId);
		if (dataRow != null)
		{
			return dataRow;
		}
		dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo p) => p.HeroId == heroId && p.Id == skillId);
		if (dataRow != null)
		{
			return dataRow;
		}
		return GameEntry.DataTable.GetDataRow((DRHeroSKillInfo p) => p.HeroId == heroId && p.CommandBindSkillGroup != null && p.CommandBindSkillGroup.Contains(skillId));
	}

	public void RefreshIconSkin(int skinId, string skinSuffix, int heroId = 0)
	{
		if (skinId == 0)
		{
			Icon = OriIcon;
			return;
		}
		DRHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRHeroSkin>(skinId);
		if (dataRow == null || !dataRow.ChangeSkillIcon)
		{
			Icon = OriIcon;
			return;
		}
		if (string.IsNullOrEmpty(OriIcon) || string.IsNullOrEmpty(skinSuffix))
		{
			Icon = OriIcon;
			return;
		}
		if (!skinSuffix.StartsWith("_"))
		{
			skinSuffix = "_" + skinSuffix;
		}
		if (skinSuffix == "_0")
		{
			Icon = OriIcon;
		}
		else if (heroId > 0)
		{
			Icon = $"{OriIcon}_{heroId}{skinSuffix}";
		}
		else
		{
			Icon = OriIcon + skinSuffix;
		}
	}

	private void InitPropertys(DRHeroSKillConfig skillConfig)
	{
		propertyList = new Dictionary<string, Ase.ECS.PropertyData>();
		propertyList.Add("Skill_TalentDamageRatio", Ase.ECS.PropertyData.Create(0f));
		propertyList.Add("Skill_TalentFixDamageRatio", Ase.ECS.PropertyData.Create(0f));
		propertyList.Add("Skill_TalentTenacityRatio", Ase.ECS.PropertyData.Create(0f));
		propertyList.Add("Skill_TalentFixTenacityRatio", Ase.ECS.PropertyData.Create(0f));
		propertyList.Add("Skill_CoolingTime", Ase.ECS.PropertyData.Create(skillConfig.CoolingTime, skillConfig.CoolingTime));
		propertyList.Add("Skill_IsChargeSkill", Ase.ECS.PropertyData.Create(skillConfig.IsChargeSkill ? 1 : 0, skillConfig.IsChargeSkill ? 1 : 0));
		propertyList.Add("Skill_MaxChargeNumber", Ase.ECS.PropertyData.Create(skillConfig.MaxChargeNumber, skillConfig.MaxChargeNumber));
		propertyList.Add("Skill_ChargeTime", Ase.ECS.PropertyData.Create(skillConfig.ChargeTime, skillConfig.ChargeTime));
		propertyList.Add("Skill_IsInitChargeSuccess", Ase.ECS.PropertyData.Create(skillConfig.IsInitChargeSuccess ? 1 : 0, skillConfig.IsInitChargeSuccess ? 1 : 0));
		propertyList.Add("Skill_DeriveSkillWindowTime", Ase.ECS.PropertyData.Create(skillConfig.DeriveSkillWindowTime, skillConfig.DeriveSkillWindowTime));
		propertyList.Add("Skill_SkillRange", Ase.ECS.PropertyData.Create(skillConfig.SkillRange, skillConfig.SkillRange));
		propertyList.Add("Skill_SkillWidth", Ase.ECS.PropertyData.Create(skillConfig.SkillWidth, skillConfig.SkillWidth));
		propertyList.Add("Skill_SkillAngle", Ase.ECS.PropertyData.Create(skillConfig.SkillAngle, skillConfig.SkillAngle));
		propertyList.Add("Skill_LargeCircleLockRadius", Ase.ECS.PropertyData.Create(skillConfig.LargeCircleLockRadius, skillConfig.LargeCircleLockRadius));
	}

	private void InitPropertys(DRHeroSKillConfig skillConfig, HCTSkillData parentSkill)
	{
		propertyList = new Dictionary<string, Ase.ECS.PropertyData>();
		propertyList.Add("Skill_TalentDamageRatio", Ase.ECS.PropertyData.Create(parentSkill.propertyList["Skill_TalentDamageRatio"].MaxValue, parentSkill.propertyList["Skill_TalentDamageRatio"].MaxValue));
		propertyList.Add("Skill_TalentFixDamageRatio", Ase.ECS.PropertyData.Create(parentSkill.propertyList["Skill_TalentFixDamageRatio"].MaxValue, parentSkill.propertyList["Skill_TalentFixDamageRatio"].MaxValue));
		propertyList.Add("Skill_TalentTenacityRatio", Ase.ECS.PropertyData.Create(parentSkill.propertyList["Skill_TalentTenacityRatio"].MaxValue, parentSkill.propertyList["Skill_TalentTenacityRatio"].MaxValue));
		propertyList.Add("Skill_TalentFixTenacityRatio", Ase.ECS.PropertyData.Create(parentSkill.propertyList["Skill_TalentFixTenacityRatio"].MaxValue, parentSkill.propertyList["Skill_TalentFixTenacityRatio"].MaxValue));
		propertyList.Add("Skill_CoolingTime", Ase.ECS.PropertyData.Create(skillConfig.CoolingTime, skillConfig.CoolingTime));
		propertyList.Add("Skill_IsChargeSkill", Ase.ECS.PropertyData.Create(skillConfig.IsChargeSkill ? 1 : 0, skillConfig.IsChargeSkill ? 1 : 0));
		propertyList.Add("Skill_MaxChargeNumber", Ase.ECS.PropertyData.Create(skillConfig.MaxChargeNumber, skillConfig.MaxChargeNumber));
		propertyList.Add("Skill_ChargeTime", Ase.ECS.PropertyData.Create(skillConfig.ChargeTime, skillConfig.ChargeTime));
		propertyList.Add("Skill_IsInitChargeSuccess", Ase.ECS.PropertyData.Create(skillConfig.IsInitChargeSuccess ? 1 : 0, skillConfig.IsInitChargeSuccess ? 1 : 0));
		propertyList.Add("Skill_DeriveSkillWindowTime", Ase.ECS.PropertyData.Create(skillConfig.DeriveSkillWindowTime, skillConfig.DeriveSkillWindowTime));
		propertyList.Add("Skill_SkillRange", Ase.ECS.PropertyData.Create(skillConfig.SkillRange, skillConfig.SkillRange));
		propertyList.Add("Skill_SkillWidth", Ase.ECS.PropertyData.Create(skillConfig.SkillWidth, skillConfig.SkillWidth));
		propertyList.Add("Skill_SkillAngle", Ase.ECS.PropertyData.Create(skillConfig.SkillAngle, skillConfig.SkillAngle));
		propertyList.Add("Skill_LargeCircleLockRadius", Ase.ECS.PropertyData.Create(skillConfig.LargeCircleLockRadius, skillConfig.LargeCircleLockRadius));
	}

	private void InitConsumeCondition(string condition)
	{
		if (string.IsNullOrWhiteSpace(condition))
		{
			return;
		}
		try
		{
			if (skillConsumeVal != null)
			{
				skillConsumeVal.Clear();
			}
			else
			{
				skillConsumeVal = new List<float>();
			}
			if (skillConsumeKeyName != null)
			{
				skillConsumeKeyName.Clear();
			}
			else
			{
				skillConsumeKeyName = new List<string>();
			}
			string[][] array = JsonConvert.DeserializeObject<string[][]>(condition);
			foreach (string[] array2 in array)
			{
				if (array2.Length != 4)
				{
					Log.Error("冷却参数长度错误...");
					break;
				}
				if (int.Parse(array2[0]) == 1)
				{
					string key = array2[1];
					DRPropertyKeyName dataRow = GameEntry.DataTable.GetDataRow((DRPropertyKeyName p) => p.PropertyKey.Equals(key));
					skillConsumeKeyName.Add(dataRow.PropertyName2);
					skillConsumeVal.Add((int)math.floor(float.Parse(array2[2]) / dataRow.Scale));
				}
			}
		}
		catch (Exception)
		{
		}
	}

	public void AddDeriveSkill(HCTSkillData deriveSkill)
	{
		for (int i = 0; i < deriveSkills.Count; i++)
		{
			if (deriveSkills[i].skillId == deriveSkill.skillId)
			{
				return;
			}
		}
		deriveSkills.Add(deriveSkill);
	}

	public void HideDeriveSkillId(List<int> hideSkillId)
	{
		hideDeriveSkillDesc = hideSkillId;
	}

	public void DecDeriveSkill(int skillId)
	{
		for (int i = 0; i < deriveSkills.Count; i++)
		{
			if (deriveSkills[i].skillId == skillId)
			{
				deriveSkills.RemoveAt(i);
				break;
			}
		}
	}

	public void InitLevelEffect(DRHeroTalentBig curtalentBig)
	{
		cultivateSkillLevel = new List<DRCultivateSkillLevel>();
		Level = curtalentBig.Level;
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		int i;
		for (i = 1; i <= Level; i++)
		{
			DRHeroTalentBig talentBig = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == curtalentBig.SkillId && p.Level == i);
			if (talentBig == null)
			{
				Log.Error($"燃点表HeroTalentBig 表找不到SkillId为【{curtalentBig.SkillId}】Level 为 【{Level}】的配置！");
				continue;
			}
			DRCultivateSkillLevel dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillLevel p) => p.Id == talentBig.BattleValue);
			if (dataRow == null)
			{
				Log.Error($"燃点表配置异常，ID【{talentBig.Id}】，CultivateSkillLevel 表找不到Id为【{talentBig.BattleValue}】的配置！");
				continue;
			}
			UpdateCultureLevelCoolingAndConsume(dataRow);
			num += dataRow.TalentDamageRatio;
			num2 += dataRow.TalentFixDamageRatio;
			num3 += dataRow.TalentTenacityRatio;
			num4 += dataRow.TalentFixTenacityRatio;
		}
		propertyList["Skill_TalentDamageRatio"].Set(num, num);
		propertyList["Skill_TalentFixDamageRatio"].Set(num2, num2);
		propertyList["Skill_TalentTenacityRatio"].Set(num3, num3);
		propertyList["Skill_TalentFixTenacityRatio"].Set(num4, num4);
	}

	public void InitDeriveLevelConsume(DRHeroTalentBig curtalentBig)
	{
		cultivateSkillLevel = new List<DRCultivateSkillLevel>();
		int i;
		for (i = 1; i <= Level; i++)
		{
			DRHeroTalentBig talentBig = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == curtalentBig.SkillId && p.Level == i);
			if (talentBig == null)
			{
				Log.Error($"燃点表HeroTalentBig 表找不到SkillId为【{curtalentBig.SkillId}】Level 为 【{Level}】的配置！");
				continue;
			}
			DRCultivateSkillLevel dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillLevel p) => p.Id == talentBig.BattleValue);
			if (dataRow == null)
			{
				Log.Error($"燃点表配置异常，ID【{talentBig.Id}】，CultivateSkillLevel 表找不到Id为【{talentBig.BattleValue}】的配置！");
			}
			else
			{
				UpdateCultureLevelCoolingAndConsume(dataRow);
			}
		}
	}

	public void UpdateCultureEffect(DRCultivateSkillEffect cultivateSkillEffect)
	{
		if (this.cultivateSkillEffect == null)
		{
			this.cultivateSkillEffect = new List<DRCultivateSkillEffect>();
		}
		for (int i = 0; i < this.cultivateSkillEffect.Count; i++)
		{
			if (this.cultivateSkillEffect[i].Id == cultivateSkillEffect.Id)
			{
				return;
			}
		}
		this.cultivateSkillEffect.Add(cultivateSkillEffect);
		coolingDeltaEffect += cultivateSkillEffect.CoolingTime;
		if (!oriCoolingZero && coolingDeltaEffect + coolingDeltaLevel != 0f)
		{
			isChangeCooling = true;
		}
		if (!string.IsNullOrEmpty(cultivateSkillEffect.ConsumeCondition))
		{
			SettleConsume(cultivateSkillEffect.ConsumeCondition, "CultivateSkillEffect", cultivateSkillEffect.Id);
		}
	}

	public void UpdateCultureLevelCoolingAndConsume(DRCultivateSkillLevel cultivateSkillLevel)
	{
		for (int i = 0; i < this.cultivateSkillLevel.Count; i++)
		{
			if (this.cultivateSkillLevel[i].Id == cultivateSkillLevel.Id)
			{
				return;
			}
		}
		this.cultivateSkillLevel.Add(cultivateSkillLevel);
		coolingDeltaLevel += cultivateSkillLevel.TalentCooling;
		if (!oriCoolingZero && coolingDeltaEffect + coolingDeltaLevel != 0f)
		{
			isChangeCooling = true;
		}
		if (!string.IsNullOrEmpty(cultivateSkillLevel.TalentConsume))
		{
			SettleConsume(cultivateSkillLevel.TalentConsume, "CultivateSkillLevel", cultivateSkillLevel.Id);
		}
	}

	public void RefreshLevelEffect(int level)
	{
		DRHeroTalentBig talentBig = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == skillId && p.Level == level);
		if (talentBig == null)
		{
			Log.Error($"燃点表HeroTalentBig 表找不到SkillId为【{skillId}】Level 为 【{Level}】的配置！");
			return;
		}
		Level = level;
		DRCultivateSkillLevel dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillLevel p) => p.Id == talentBig.BattleValue);
		if (dataRow == null)
		{
			Log.Error($"燃点表配置异常，ID【{talentBig.Id}】，CultivateSkillLevel 表找不到Id为【{talentBig.BattleValue}】的配置！");
			return;
		}
		UpdateCultureLevelCoolingAndConsume(dataRow);
		propertyList["Skill_TalentDamageRatio"].Set(propertyList["Skill_TalentDamageRatio"].MaxValue + dataRow.TalentDamageRatio, propertyList["Skill_TalentDamageRatio"].MaxValue + dataRow.TalentDamageRatio);
		propertyList["Skill_TalentFixDamageRatio"].Set(propertyList["Skill_TalentFixDamageRatio"].MaxValue + dataRow.TalentFixDamageRatio, propertyList["Skill_TalentFixDamageRatio"].MaxValue + dataRow.TalentFixDamageRatio);
		propertyList["Skill_TalentTenacityRatio"].Set(propertyList["Skill_TalentTenacityRatio"].MaxValue + dataRow.TalentTenacityRatio, propertyList["Skill_TalentTenacityRatio"].MaxValue + dataRow.TalentTenacityRatio);
		propertyList["Skill_TalentFixTenacityRatio"].Set(propertyList["Skill_TalentFixTenacityRatio"].MaxValue + dataRow.TalentFixTenacityRatio, propertyList["Skill_TalentFixTenacityRatio"].MaxValue + dataRow.TalentFixTenacityRatio);
	}

	public void RefreshLevelEffect(HCTSkillData parentSkill)
	{
		coolingDeltaEffect = parentSkill.coolingDeltaEffect;
		coolingDeltaLevel = parentSkill.coolingDeltaLevel;
		for (int i = 0; i < parentSkill.cultivateSkillLevel.Count; i++)
		{
			bool flag = false;
			for (int j = 0; j < cultivateSkillLevel.Count; j++)
			{
				if (cultivateSkillLevel[j].Id == parentSkill.cultivateSkillLevel[i].Id)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				UpdateCultureLevelCoolingAndConsume(parentSkill.cultivateSkillLevel[i]);
			}
		}
		propertyList["Skill_TalentDamageRatio"].Set(parentSkill.propertyList["Skill_TalentDamageRatio"].MaxValue, parentSkill.propertyList["Skill_TalentDamageRatio"].MaxValue);
		propertyList["Skill_TalentFixDamageRatio"].Set(parentSkill.propertyList["Skill_TalentFixDamageRatio"].MaxValue, parentSkill.propertyList["Skill_TalentFixDamageRatio"].MaxValue);
		propertyList["Skill_TalentTenacityRatio"].Set(parentSkill.propertyList["Skill_TalentTenacityRatio"].MaxValue, parentSkill.propertyList["Skill_TalentTenacityRatio"].MaxValue);
		propertyList["Skill_TalentFixTenacityRatio"].Set(parentSkill.propertyList["Skill_TalentFixTenacityRatio"].MaxValue, parentSkill.propertyList["Skill_TalentFixTenacityRatio"].MaxValue);
	}

	public void AddBuffId(int battleBuffId)
	{
		if (buffIds == null)
		{
			buffIds = new List<int>();
		}
		buffIds.Add(battleBuffId);
	}

	public string GetDescNext()
	{
		DRHeroTalentBig big = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == skillId && p.Level == level + 1);
		if (big != null)
		{
			DRCultivateSkillLevel dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillLevel p) => p.Id == big.BattleValue);
			if (dataRow != null)
			{
				return desc.Replace("\\n", "\n").Replace("KeyDamage", NumericalExtension.GetOuterDisplayPercentValue(baseDamage * (propertyList["Skill_TalentDamageRatio"].MaxValue + dataRow.TalentDamageRatio))).Replace("KeyTenacity", NumericalExtension.GetOuterDisplayPercentValue(baseTenacity * (propertyList["Skill_TalentTenacityRatio"].MaxValue + dataRow.TalentTenacityRatio)))
					.Replace("KeyFixDamage", NumericalExtension.GetOuterDisplayValue(baseFixDamage * (propertyList["Skill_TalentFixDamageRatio"].MaxValue + dataRow.TalentFixDamageRatio)).Replace("KeyFixTenacity", NumericalExtension.GetOuterDisplayPercentValue(baseFixTenacity * (propertyList["Skill_TalentFixTenacityRatio"].MaxValue + dataRow.TalentFixTenacityRatio))));
			}
			Log.Error($"CultivateSkillLevel表找不到Id【{big.BattleValue}】的配置！HeroTalentBig Id【{big.Id}】");
		}
		return desc;
	}

	public string GetDesc()
	{
		if (desc == null)
		{
			return "";
		}
		return desc.Replace("\\n", "\n").Replace("KeyDamage", NumericalExtension.GetOuterDisplayPercentValue(baseDamage * propertyList["Skill_TalentDamageRatio"].MaxValue)).Replace("KeyTenacity", NumericalExtension.GetOuterDisplayPercentValue(baseTenacity * propertyList["Skill_TalentTenacityRatio"].MaxValue))
			.Replace("KeyFixDamage", NumericalExtension.GetOuterDisplayValue(baseFixDamage * propertyList["Skill_TalentFixDamageRatio"].MaxValue))
			.Replace("KeyFixTenacity", NumericalExtension.GetOuterDisplayPercentValue(baseFixTenacity * propertyList["Skill_TalentFixTenacityRatio"].MaxValue));
	}

	public float GetSkillCooling()
	{
		float num = (oriCoolingZero ? 0f : (propertyList["Skill_CoolingTime"].MaxValue + coolingDeltaEffect + coolingDeltaLevel));
		return math.clamp(num, 0f, num);
	}

	public bool SkillHideDesc(HCTSkillData skillData)
	{
		for (int i = 0; i < hideDeriveSkillDesc.Count; i++)
		{
			if (skillData.SkillId == hideDeriveSkillDesc[i])
			{
				return true;
			}
		}
		return false;
	}

	public void SetDeriveSkill(List<HCTSkillData> deriveSkills)
	{
		this.deriveSkills = deriveSkills;
	}

	private void SettleConsume(string consume, string exName, int id)
	{
		try
		{
			string[][] array = JsonConvert.DeserializeObject<string[][]>(consume);
			foreach (string[] array2 in array)
			{
				if (array2.Length != 4)
				{
					Log.Error($"{exName}表，Id【{id}】，冷却参数长度错误...");
				}
				else
				{
					if (int.Parse(array2[0]) != 1)
					{
						continue;
					}
					string propertyName = array2[1];
					int num = int.Parse(array2[2]);
					if (num == 0)
					{
						continue;
					}
					DRPropertyKeyName dataRow = GameEntry.DataTable.GetDataRow((DRPropertyKeyName p) => p.PropertyKey.Equals(propertyName));
					if (dataRow == null)
					{
						Log.Error("PropertyKeyName表找不到属性Key为【" + propertyName + "】的属性！");
						continue;
					}
					isChangeConsume = true;
					if (skillConsumeKeyName == null)
					{
						skillConsumeKeyName = new List<string>();
						skillConsumeVal = new List<float>();
						skillConsumeKeyName.Add(dataRow.PropertyName2);
						skillConsumeVal.Add(num);
						break;
					}
					bool flag = false;
					for (int num2 = 0; num2 < skillConsumeKeyName.Count; num2++)
					{
						if (skillConsumeKeyName[num2].Equals(dataRow.PropertyName))
						{
							skillConsumeVal[num2] += num;
							flag = true;
						}
					}
					if (!flag)
					{
						skillConsumeKeyName.Add(dataRow.PropertyName);
						skillConsumeVal.Add(num);
					}
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error($"{exName}表，Id【{id}】，处理参数发生异常... {ex.Message} / {ex.StackTrace}");
		}
	}

	public bool HasProperty()
	{
		if (propertyList != null)
		{
			return propertyList.Count > 0;
		}
		return false;
	}
}
