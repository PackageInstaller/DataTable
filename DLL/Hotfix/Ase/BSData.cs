using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class BSData : ViewModelBase
{
	private int damage;

	private int tenacity;

	private int cure;

	private int cureSelf;

	private int cureOther;

	private int hitCount;

	private int critical;

	private int injureCount;

	private int injureValue;

	private int fallCount;

	private int skillId;

	private List<int> deriveSkillList;

	private string skillIcon;

	private string skillName;

	private bool isSkinIcon;

	private int release;

	private bool highlight;

	private bool hasChild;

	private bool isTotalItem;

	private HeroSkillTypeEnum skillType;

	public bool IsSkinIcon => isSkinIcon;

	public int Damage
	{
		get
		{
			return damage;
		}
		private set
		{
			Set(ref damage, value, "Damage");
		}
	}

	public int Tenacity
	{
		get
		{
			return tenacity;
		}
		private set
		{
			Set(ref tenacity, value, "Tenacity");
		}
	}

	public int Cure
	{
		get
		{
			return cure;
		}
		private set
		{
			Set(ref cure, value, "Cure");
		}
	}

	public int CureSelf
	{
		get
		{
			return cureSelf;
		}
		private set
		{
			Set(ref cureSelf, value, "CureSelf");
		}
	}

	public int CureOther
	{
		get
		{
			return cureOther;
		}
		private set
		{
			Set(ref cureOther, value, "CureOther");
		}
	}

	public int HitCount
	{
		get
		{
			return hitCount;
		}
		private set
		{
			Set(ref hitCount, value, "HitCount");
		}
	}

	public int Critical
	{
		get
		{
			return critical;
		}
		private set
		{
			Set(ref critical, value, "Critical");
		}
	}

	public int InjureCount
	{
		get
		{
			return injureCount;
		}
		private set
		{
			Set(ref injureCount, value, "InjureCount");
		}
	}

	public int InjureValue
	{
		get
		{
			return injureValue;
		}
		private set
		{
			Set(ref injureValue, value, "InjureValue");
		}
	}

	public int FallCount
	{
		get
		{
			return fallCount;
		}
		private set
		{
			Set(ref fallCount, value, "FallCount");
		}
	}

	public int SkillId
	{
		get
		{
			return skillId;
		}
		private set
		{
			Set(ref skillId, value, "SkillId");
		}
	}

	public string SkillIcon
	{
		get
		{
			return skillIcon;
		}
		private set
		{
			Set(ref skillIcon, value, "SkillIcon");
		}
	}

	public string SkillName
	{
		get
		{
			return skillName;
		}
		private set
		{
			Set(ref skillName, value, "SkillName");
		}
	}

	public int Release
	{
		get
		{
			return release;
		}
		private set
		{
			Set(ref release, value, "Release");
		}
	}

	public bool Highlight
	{
		get
		{
			return highlight;
		}
		private set
		{
			Set(ref highlight, value, "Highlight");
		}
	}

	public bool HasChild
	{
		get
		{
			return hasChild;
		}
		private set
		{
			Set(ref hasChild, value, "HasChild");
		}
	}

	public HeroSkillTypeEnum SkillType
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

	public List<int> DeriveSkillList => deriveSkillList;

	public bool IsTotalItem => isTotalItem;

	public string RefreshIconSkin(string oriIcon, int skinId, string skinSuffix, int heroId = 0)
	{
		if (skinId == 0)
		{
			return oriIcon;
		}
		DRHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRHeroSkin>(skinId);
		if (dataRow == null || !dataRow.ChangeSkillIcon)
		{
			return oriIcon;
		}
		if (string.IsNullOrEmpty(oriIcon) || string.IsNullOrEmpty(skinSuffix))
		{
			return oriIcon;
		}
		if (!skinSuffix.StartsWith("_"))
		{
			skinSuffix = "_" + skinSuffix;
		}
		if (skinSuffix == "_0")
		{
			return oriIcon;
		}
		if (heroId > 0)
		{
			return $"{oriIcon}_{heroId}{skinSuffix}";
		}
		return oriIcon + skinSuffix;
	}

	public BSData(int skillId, BattleHeroData battleHeroData)
	{
		this.skillId = skillId;
		DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == skillId);
		if (dataRow != null)
		{
			skillIcon = RefreshIconSkin(dataRow.Icon, battleHeroData.HeroModel.SkinConfigId, battleHeroData.HeroModel.SkinSuffix);
			isSkinIcon = skillIcon != dataRow.Icon;
			skillName = dataRow.Name;
			highlight = dataRow.SkillLabelTypeEnum.Contains("HighlightSkill");
		}
		if (dataRow != null)
		{
			return;
		}
		DRBattlePropInfo dataRow2 = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.PropSkillID == skillId);
		if (dataRow2 != null)
		{
			skillIcon = dataRow2.Icon;
			skillName = dataRow2.Name;
			{
				foreach (KeyValuePair<int, BattleProps> propsDatum in battleHeroData.HeroModel.PropsData)
				{
					if (propsDatum.Value.SkillId == skillId)
					{
						if (propsDatum.Key == 1)
						{
							skillType = HeroSkillTypeEnum.PropSkill;
							isTotalItem = true;
						}
						else
						{
							skillType = HeroSkillTypeEnum.DeputyPropSkill;
							isTotalItem = true;
						}
						break;
					}
				}
				return;
			}
		}
		skillIcon = "";
		skillName = "";
	}

	public BSData(DRHeroSKillInfo sKillInfo, List<BSData> bsDatas, HeroModel heroModel)
	{
		skillId = -sKillInfo.SkillId;
		skillType = sKillInfo.HeroSkillTypeEnum;
		DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == sKillInfo.SkillId);
		if (dataRow != null)
		{
			skillName = dataRow.Name;
			skillIcon = RefreshIconSkin(dataRow.Icon, heroModel.SkinConfigId, heroModel.SkinSuffix);
			isSkinIcon = skillIcon != dataRow.Icon;
			highlight = dataRow.SkillLabelTypeEnum.Contains("HighlightSkill");
		}
		deriveSkillList = ((sKillInfo.CommandBindSkillGroup.Count > 1) ? new List<int>() : null);
		for (int num = 0; num < bsDatas.Count; num++)
		{
			if (deriveSkillList != null)
			{
				deriveSkillList.Add(bsDatas[num].skillId);
			}
			damage += bsDatas[num].damage;
			tenacity += bsDatas[num].tenacity;
			cure += bsDatas[num].cure;
			cureSelf += bsDatas[num].cureSelf;
			cureOther += bsDatas[num].cureOther;
			hitCount += bsDatas[num].hitCount;
			critical += bsDatas[num].critical;
			injureCount += bsDatas[num].injureCount;
			injureValue += bsDatas[num].injureValue;
			fallCount += bsDatas[num].fallCount;
			release += bsDatas[num].release;
		}
		hasChild = CheckHasChild(sKillInfo.Id);
		isTotalItem = true;
	}

	public BSData(DRBattlePropInfo battlePropInfo, HeroSkillTypeEnum skillTypeEnum, List<BSData> bsDatas)
	{
		skillId = -battlePropInfo.PropSkillID;
		skillType = skillTypeEnum;
		skillName = battlePropInfo.Name;
		skillIcon = battlePropInfo.Icon;
		isSkinIcon = false;
		highlight = false;
		deriveSkillList = null;
		for (int i = 0; i < bsDatas.Count; i++)
		{
			if (deriveSkillList != null)
			{
				deriveSkillList.Add(bsDatas[i].skillId);
			}
			damage += bsDatas[i].damage;
			tenacity += bsDatas[i].tenacity;
			cure += bsDatas[i].cure;
			cureSelf += bsDatas[i].cureSelf;
			cureOther += bsDatas[i].cureOther;
			hitCount += bsDatas[i].hitCount;
			critical += bsDatas[i].critical;
			injureCount += bsDatas[i].injureCount;
			injureValue += bsDatas[i].injureValue;
			fallCount += bsDatas[i].fallCount;
			release += bsDatas[i].release;
		}
		hasChild = false;
		isTotalItem = true;
	}

	private bool CheckHasChild(int skillInfoId)
	{
		if (deriveSkillList == null)
		{
			return false;
		}
		if (deriveSkillList.Count > 2)
		{
			return true;
		}
		if (deriveSkillList.Count == 1 && deriveSkillList[0] == skillInfoId)
		{
			return false;
		}
		return true;
	}

	public void AddSkillInfo(DRHeroSKillInfo sKillInfo)
	{
		SkillType = sKillInfo.HeroSkillTypeEnum;
	}

	public void AddSkillInfo(DRBattlePropInfo battlePropInfo)
	{
		SkillType = HeroSkillTypeEnum.PropSkill;
	}

	public BSData()
	{
		isTotalItem = true;
	}

	public void AddSkillStatData(EntityStatInfo.SkillStatData skillValue)
	{
		damage += skillValue.damage;
		tenacity += skillValue.tenacity;
		cure += skillValue.recover;
		cureSelf += skillValue.recoverSelf;
		cureOther += skillValue.recoverOther;
		hitCount += skillValue.hitCount;
		critical += skillValue.critCount;
	}

	public void AddSecondTotalData1(EntityStatInfo.SkillStatData skillValue)
	{
		damage += skillValue.damage;
		tenacity += skillValue.tenacity;
		cure += skillValue.recover;
		cureSelf += skillValue.recoverSelf;
		cureOther += skillValue.recoverOther;
	}

	public void AddReleaseSkillData(int releaseSkillValue)
	{
		release += releaseSkillValue;
	}

	public void AddSecondTotalDataDown(int falldown)
	{
		fallCount += falldown;
	}

	public void AddSecondTotalDataInjureCount(int injureCount)
	{
		this.injureCount += injureCount;
	}

	public void AddSecondTotalDataInjureDamage(int injureDamage)
	{
		injureValue += injureDamage;
	}

	public void SetDeriveSkillType(HeroSkillTypeEnum skillTypeEnum)
	{
		SkillType = skillTypeEnum;
	}
}
