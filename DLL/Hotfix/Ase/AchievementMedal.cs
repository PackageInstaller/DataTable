using System.Collections.Generic;

namespace Ase;

public struct AchievementMedal
{
	public int MedalId;

	public string MedalIcon;

	public int MedalNum;

	public int MedalRank;

	public int CurRank;

	public List<int> ConditionList;

	public List<int> Target;

	public List<List<int>> BattleTarget;

	public List<int> CompareFlagList;

	public List<int> SettlementcheckPamIndex;

	public string MedalName;

	public string MedalDesc;

	public int MedalRarity;

	public int AchievementType;

	public BattleObserverEventEnum BattleObserverEventEnum;

	public void SetNum(int num)
	{
		MedalNum = num;
		int id = MedalId;
		DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.MedalId == id);
		foreach (DRAchievementMedal dRAchievementMedal in dataRows)
		{
			if (dRAchievementMedal.Value <= num)
			{
				CurRank = dRAchievementMedal.Rank;
				continue;
			}
			break;
		}
	}

	public void SetRank(int rank)
	{
		MedalRank = rank;
		int id = MedalId;
		int num = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.MedalId == id).Length;
		int targetRank = rank + 1;
		if (rank >= num)
		{
			targetRank--;
		}
		DRAchievementMedal dataRow = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRow((DRAchievementMedal p) => p.MedalId == id && p.Rank == targetRank);
		SetAchievementInfo(dataRow);
	}

	public void SetAchievementInfo(DRAchievementMedal drAchievementMedal)
	{
		if (drAchievementMedal != null)
		{
			MedalName = drAchievementMedal.Name;
			MedalDesc = drAchievementMedal.Desc;
			MedalRarity = drAchievementMedal.Rarity;
			ConditionList = drAchievementMedal.Condition;
			Target = drAchievementMedal.Target;
			MedalIcon = drAchievementMedal.MedalIcon;
			BattleTarget = drAchievementMedal.BattleTarget;
			CompareFlagList = drAchievementMedal.CompareFlag;
			SettlementcheckPamIndex = drAchievementMedal.SettlementcheckPamIndex;
		}
	}
}
