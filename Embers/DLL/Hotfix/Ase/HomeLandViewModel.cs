#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomeLandViewModel : OptionBase
{
	private Dictionary<int, HomelandEffectData> curLevelEffect;

	private Dictionary<int, HomelandBuildingData> buildingDatas;

	private int homelandLevel;

	private int homelandLevelMax;

	public Dictionary<int, HomelandEffectData> CurLevelEffect => curLevelEffect;

	public Dictionary<int, HomelandBuildingData> BuildingDatas => buildingDatas;

	public int HomelandLevel => homelandLevel;

	public int HomelandLevelMax => homelandLevelMax;

	public HomeLandViewModel(int level, Dictionary<int, int> buildingLevels)
	{
		homelandLevel = level;
		DRHomeLandLevelInfo[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRHomeLandLevelInfo>();
		homelandLevelMax = allDataRow[allDataRow.Length - 1].Id;
		curLevelEffect = new Dictionary<int, HomelandEffectData>();
		DRHomeLandLevelEffect[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRHomeLandLevelEffect>();
		for (int i = 0; i < allDataRow2.Length; i++)
		{
			curLevelEffect.Add(allDataRow2[i].Id, new HomelandEffectData(allDataRow2[i]));
		}
		buildingDatas = new Dictionary<int, HomelandBuildingData>();
		DRBuildingInfo[] buildingInfo = GameEntry.DataTable.GetAllDataRow<DRBuildingInfo>();
		Dictionary<int, float> dictionary = new Dictionary<int, float>();
		for (int j = 0; j < buildingInfo.Length; j++)
		{
			int blv = ((!buildingLevels.ContainsKey(buildingInfo[j].Id)) ? 1 : buildingLevels[buildingInfo[j].Id]);
			buildingDatas.Add(buildingInfo[j].Id, new HomelandBuildingData(buildingInfo[j], blv, homelandLevel));
			try
			{
				DRBuildingLevelInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRBuildingLevelInfo p) => p.BuildingId == buildingInfo[j].Id && p.Level <= blv);
				for (int num = 0; num < dataRows.Length; num++)
				{
					for (int num2 = 0; num2 < dataRows[num].UpgradeEffectId.Count; num2++)
					{
						int key = dataRows[num].UpgradeEffectId[num2];
						float num3 = dataRows[num].UpgradeEffectVal[num2];
						if (dictionary.ContainsKey(key))
						{
							if (dictionary[key] < num3)
							{
								dictionary[key] = num3;
							}
						}
						else
						{
							dictionary.Add(key, num3);
						}
					}
				}
			}
			catch (Exception)
			{
				Log.Error("获取家园建筑效果数值出现异常，请检查配置表BuildingLevelInfo！");
			}
		}
		foreach (KeyValuePair<int, float> item in dictionary)
		{
			if (curLevelEffect.ContainsKey(item.Key))
			{
				curLevelEffect[item.Key].SetVal(item.Value);
			}
		}
	}

	public void UpgradeLevel(int level)
	{
		homelandLevel = level;
		foreach (KeyValuePair<int, HomelandBuildingData> buildingData in buildingDatas)
		{
			buildingData.Value.CheckUnlock(homelandLevel);
		}
	}

	public void UpgradeBuildingLevel(int buildingType)
	{
		if (buildingDatas.ContainsKey(buildingType))
		{
			buildingDatas[buildingType].UpgradeLevel(buildingDatas[buildingType].Level + 1, homelandLevel);
		}
	}

	public void UpdateBuildingHarvestPoint(int buildingType, bool redPoint)
	{
		if (buildingDatas.ContainsKey(buildingType))
		{
			bool num = buildingDatas[buildingType].CanHarvest != redPoint && (buildingType == 1 || buildingType == 2);
			buildingDatas[buildingType].UpdateHarvest(redPoint);
			if (num)
			{
				Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, (buildingType == 1) ? HomelandMsgType.HomelandFarmRed : HomelandMsgType.HomelandSailRed));
			}
		}
	}

	public void AddBuildingData(int buildingType, HomelandBuildingData homelandBuildingData)
	{
		if (buildingDatas.ContainsKey(buildingType))
		{
			buildingDatas[buildingType] = homelandBuildingData;
		}
		else
		{
			buildingDatas.Add(buildingType, homelandBuildingData);
		}
	}

	public bool CheckCanUpgradeLevel()
	{
		try
		{
			if (buildingDatas != null)
			{
				foreach (KeyValuePair<int, HomelandBuildingData> buildingData in buildingDatas)
				{
					if (buildingData.Value.CheckCanUpgrade(homelandLevel))
					{
						return true;
					}
				}
			}
			if (homelandLevel == homelandLevelMax)
			{
				return false;
			}
			DRHomeLandLevelInfo dataRow = GameEntry.DataTable.GetDataRow((DRHomeLandLevelInfo p) => p.Id == homelandLevel + 1);
			if (dataRow == null)
			{
				return false;
			}
			int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
			int accountLevelNeed = dataRow.AccountLevelNeed;
			if (level < accountLevelNeed)
			{
				return false;
			}
			if (dataRow.NeedItem.Count != dataRow.NeedItemCount.Count)
			{
				Log.Error($"HomeLandLevelInfo表，Id【{homelandLevel + 1}】，道具数量不匹配！");
				return false;
			}
			if (MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin) < dataRow.MoneyNeed)
			{
				return false;
			}
			return true;
		}
		catch (Exception)
		{
		}
		return false;
	}

	public bool CheckCanHarvestByType(int type)
	{
		if (buildingDatas.ContainsKey(type))
		{
			return buildingDatas[type].CanHarvest;
		}
		return false;
	}

	public float GetEffectVal(int effectId)
	{
		if (curLevelEffect.ContainsKey(effectId))
		{
			return curLevelEffect[effectId].CurVal;
		}
		Log.Error($"家园等级效果，找不到Id为【{effectId}】的效果！");
		return 0f;
	}

	public void UpdateBuildingEffect(List<BuildingEffectItemViewModel> effectItem)
	{
		for (int i = 0; i < effectItem.Count; i++)
		{
			if (curLevelEffect.ContainsKey(effectItem[i].EffectId))
			{
				curLevelEffect[effectItem[i].EffectId].SetVal(effectItem[i].NextVal);
			}
		}
	}
}
