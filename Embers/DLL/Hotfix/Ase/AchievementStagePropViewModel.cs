using System.Collections.Generic;

namespace Ase;

public class AchievementStagePropViewModel : OptionBase
{
	private List<AchievementStageItemData> achievementStageItemDataList;

	public List<AchievementStageItemData> AchievementStageItemDataList
	{
		get
		{
			return achievementStageItemDataList;
		}
		set
		{
			Set(ref achievementStageItemDataList, value, "AchievementStageItemDataList");
		}
	}

	public AchievementStagePropViewModel(OptionBase parent, int medalId, int curNum, int medalank)
	{
		base.parent = parent;
		achievementStageItemDataList = new List<AchievementStageItemData>();
		DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataTable<DRAchievementMedal>().GetDataRows((DRAchievementMedal p) => p.MedalId == medalId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			achievementStageItemDataList.Add(new AchievementStageItemData(this, dataRows[num], curNum, medalank, num));
		}
	}
}
