#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using GameFramework;
using UnityEngine;

namespace Ase;

public static class HeroModelExtension
{
	public static void AnalysisDestinyData(List<int> seatLevel, out int destinyLevel, out List<int> destinyData)
	{
		destinyLevel = 1;
		destinyData = new List<int>();
		if (seatLevel == null)
		{
			return;
		}
		destinyLevel = seatLevel.Count - 1;
		if (seatLevel.Count > 0)
		{
			destinyData = Enumerable.Reverse(Convert.ToString(seatLevel[seatLevel.Count - 1], 2).ToCharArray()).ToList().ConvertAll((char p) => int.Parse(p.ToString()));
		}
	}

	public static bool IsNullOrEmpty(this HeroModel heroModel)
	{
		return heroModel?.Empty ?? true;
	}

	public static float GetAttack(this HeroModel heroModel)
	{
		return heroModel.BaseAttack + heroModel.GetPropertyByUpgradeAndBreak("Attack");
	}

	public static float GetHp(this HeroModel heroModel)
	{
		return heroModel.BaseHP + heroModel.GetPropertyByUpgradeAndBreak("Hp");
	}

	public static float GetDefense(this HeroModel heroModel)
	{
		return heroModel.BaseDefense + heroModel.GetPropertyByUpgradeAndBreak("Defence");
	}

	public static float GetBaseEnergy(this HeroModel heroModel)
	{
		return heroModel.BaseEnergy;
	}

	public static float GetBaseEnergyRecovery(this HeroModel heroModel)
	{
		return heroModel.BaseEnergyRecovery;
	}

	public static float GetBaseCrit(this HeroModel heroModel)
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.CritBase);
		if (dataRow == null)
		{
			Log.Error($"ConstantConfig表找不到Id为【{Constant.ConstantConfig.CritBase}】的配置，请检查！");
			return 0f;
		}
		return dataRow.Value;
	}

	public static float GetCritRadio(this HeroModel heroModel)
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.CritDamageBase);
		if (dataRow == null)
		{
			Log.Error($"ConstantConfig表找不到Id为【{Constant.ConstantConfig.CritDamageBase}】的配置，请检查！");
			return 0.5f;
		}
		return dataRow.Value;
	}

	private static float GetPropertyByUpgradeAndBreak(this HeroModel heroModel, string propertyKey)
	{
		float num = 0f;
		Dictionary<int, DRHeroStar> drHeroStars = heroModel.DrHeroStars;
		if (drHeroStars == null)
		{
			return num;
		}
		for (int i = heroModel.MinStarLevel; i < heroModel.StarLevel + 1; i++)
		{
			drHeroStars.TryGetValue(i, out var value);
			drHeroStars.TryGetValue(i + 1, out var value2);
			int num2 = value?.NeedLv ?? 0;
			int num3 = value2?.NeedLv ?? heroModel.TotalMaxLevel;
			float num4 = ((i >= heroModel.MaxStarLevel) ? ((float)(heroModel.Level - num2)) : ((float)Mathf.Min(heroModel.Level - num2, num3 - num2)));
			GetParamByPropertyKey(heroModel, propertyKey, value, out var addProperty, out var baseGrowProperty);
			num += num4 * baseGrowProperty + addProperty;
		}
		return num;
	}

	private static void GetParamByPropertyKey(HeroModel heroModel, string propertyKey, DRHeroStar drData, out float addProperty, out float baseGrowProperty)
	{
		addProperty = 0f;
		baseGrowProperty = 0f;
		if (drData != null)
		{
			int num = ((drData.TargetStar >= 0) ? drData.TargetStar : 0);
			switch (propertyKey)
			{
			case "Hp":
				addProperty = ((heroModel.BreakAddHP.Count > num) ? heroModel.BreakAddHP[num] : 0f);
				baseGrowProperty = ((heroModel.GrowHP.Count > num) ? heroModel.GrowHP[num] : 0f);
				break;
			case "Defence":
				addProperty = ((heroModel.BreakAddDefense.Count > num) ? heroModel.BreakAddDefense[num] : 0f);
				baseGrowProperty = ((heroModel.GrowDefense.Count > num) ? heroModel.GrowDefense[num] : 0f);
				break;
			case "Attack":
				addProperty = ((heroModel.BreakAddAttack.Count > num) ? heroModel.BreakAddAttack[num] : 0f);
				baseGrowProperty = ((heroModel.GrowAttack.Count > num) ? heroModel.GrowAttack[num] : 0f);
				break;
			}
		}
	}

	public static NumericalProperty GetHeroTotalProperty(this HeroModel heroModel)
	{
		NumericalProperty numericalProperty = new NumericalProperty(heroModel);
		numericalProperty.Attach(heroModel.NumericalProperty);
		numericalProperty.Attach(heroModel.GetHeroArmoursProperty());
		numericalProperty.Attach(heroModel.GetHeroWeaponProperty());
		numericalProperty.Attach(heroModel.GetHeroTalentProperty());
		numericalProperty.Attach(heroModel.GetHeroDestinyProperty());
		numericalProperty.Attach(heroModel.GetHeroExtraProperty());
		numericalProperty.Attach(heroModel.GetPropertyByEntry());
		return numericalProperty;
	}

	public static NumericalProperty GetHeroArmoursProperty(this HeroModel heroModel)
	{
		NumericalProperty numericalProperty = new NumericalProperty(heroModel);
		if (heroModel.Armours != null)
		{
			foreach (ArmourData value in heroModel.Armours.Values)
			{
				if (value != null)
				{
					numericalProperty.Attach(value.NumericalProperty);
				}
			}
		}
		return numericalProperty;
	}

	public static NumericalProperty GetHeroWeaponProperty(this HeroModel heroModel)
	{
		NumericalProperty numericalProperty = new NumericalProperty(heroModel);
		if (heroModel.HeldWeapon != null)
		{
			numericalProperty.Attach(heroModel.HeldWeapon.NumericalProperty);
		}
		return numericalProperty;
	}

	public static NumericalProperty GetHeroTalentProperty(this HeroModel heroModel)
	{
		return heroModel.TalentProperty;
	}

	public static NumericalProperty GetHeroDestinyProperty(this HeroModel heroModel)
	{
		return heroModel.DestinyProperty;
	}

	public static NumericalProperty GetHeroExtraProperty(this HeroModel heroModel)
	{
		return heroModel.ExtraProperty;
	}

	public static List<EntryData> GetAllEntry(this HeroModel heroModel)
	{
		List<EntryData> list = heroModel.TalentEntryDataList.Attach(heroModel.DestinyEntryDataList).Attach(heroModel.ExtraEntryDataList);
		if (heroModel.HeldWeapon != null)
		{
			list = list.Attach(heroModel.HeldWeapon.EntryDataList);
		}
		if (heroModel.Armours != null)
		{
			foreach (ArmourData value in heroModel.Armours.Values)
			{
				if (value != null)
				{
					list = list.Attach(value.GetAllEntry());
				}
			}
		}
		return list;
	}

	public static List<int> GetAllEntrys(this HeroModel heroModel)
	{
		List<int> list = new List<int>();
		if (heroModel.HeldWeapon != null)
		{
			list.AddRange(heroModel.HeldWeapon.BuffIdList);
		}
		list.AddRange(heroModel.GetAllBuffIdByEntry());
		list.AddRange(heroModel.GetAllBuffIdByTalent());
		list.AddRange(heroModel.GetAllOuterBuffList(EnvironmentModifierType.Buff));
		return list;
	}

	public static List<int> GetAllBTId(this HeroModel heroModel)
	{
		return heroModel.GetAllOuterBuffList(EnvironmentModifierType.Paradox);
	}

	public static NumericalProperty GetPropertyByEntry(this HeroModel heroModel)
	{
		return NumericalExtension.Attach(heroModel, heroModel.GetAllEntry());
	}

	public static List<int> GetAllBuffIdByEntry(this HeroModel heroModel)
	{
		List<int> list = new List<int>();
		List<DREntry> allBuff = heroModel.GetAllEntry().GetAllBuff();
		if (allBuff != null)
		{
			foreach (DREntry item in allBuff)
			{
				list.AddRange(item.EntryKey);
			}
		}
		return list;
	}

	public static List<int> GetAllBuffIdByTalent(this HeroModel heroModel)
	{
		List<int> list = new List<int>();
		foreach (HCTSkillData value in heroModel.HCTSkillDatas.Values)
		{
			if (value.BuffIds != null)
			{
				list.AddRange(value.BuffIds);
			}
		}
		return list;
	}

	public static List<DREntry> GetAllBuffConfigByEntry(this HeroModel heroModel)
	{
		return heroModel.GetAllEntry().GetAllBuff();
	}

	public static bool GetVoiceOpenState(this HeroModel heroModel, DRVoice drVoice)
	{
		if (drVoice == null || heroModel.IsNullOrEmpty())
		{
			return false;
		}
		if (drVoice.LockType.Equals(0))
		{
			return true;
		}
		if (drVoice.LockType.Equals(1))
		{
			return heroModel.FeelingLevel >= drVoice.LockNum;
		}
		if (drVoice.LockType.Equals(2))
		{
			return heroModel.StarLevel >= drVoice.LockNum;
		}
		if (drVoice.LockType.Equals(3))
		{
			return Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetHeroSkinOwnerShopSituation(drVoice.LockNum) ?? false;
		}
		return false;
	}

	public static bool GetStoryOpenState(DRHeroStory drHeroStory)
	{
		if (drHeroStory == null)
		{
			return false;
		}
		if (drHeroStory.OpenType == 0)
		{
			return true;
		}
		if (drHeroStory.OpenType == 1)
		{
			ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
			if (service != null)
			{
				TaskDataViewModel currentMainTask = service.GetCurrentMainTask();
				if (currentMainTask != null)
				{
					return currentMainTask.CopyOpen >= drHeroStory.OpenNum;
				}
			}
		}
		else if (drHeroStory.OpenType == 2)
		{
			IHeroService service2 = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
			if (service2 != null)
			{
				HeroModel heroById = service2.GetHeroById(drHeroStory.HeroId);
				if (!heroById.IsNullOrEmpty())
				{
					return heroById.FeelingLevel >= drHeroStory.OpenNum;
				}
			}
		}
		return false;
	}
}
