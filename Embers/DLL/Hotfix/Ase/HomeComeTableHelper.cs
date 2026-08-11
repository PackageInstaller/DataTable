using System.Collections.Generic;
using System.Linq;

namespace Ase;

public static class HomeComeTableHelper
{
	public const int AllGiftRewardDescId = 10001;

	public const int AllGiftRewardFallbackId = 1001001;

	private static readonly Dictionary<int, HomeComeTaskJumpConfig> s_TaskJumpConfig = new Dictionary<int, HomeComeTaskJumpConfig>();

	public static bool TryGetTaskJump(int taskId, out HomeComeTaskJumpConfig config)
	{
		return s_TaskJumpConfig.TryGetValue(taskId, out config);
	}

	public static List<DRHomeComeSign> GetSignRowsSorted()
	{
		DRHomeComeSign[] dataRows = GameEntry.DataTable.GetDataRows((DRHomeComeSign p) => p.Id > 0);
		if (dataRows != null)
		{
			return (from p in dataRows
				orderby p.SignDate, p.Id
				select p).ToList();
		}
		return new List<DRHomeComeSign>();
	}

	public static List<DRHomeComeTask> GetTaskRowsSorted()
	{
		DRHomeComeTask[] dataRows = GameEntry.DataTable.GetDataRows((DRHomeComeTask p) => p.Id > 0);
		if (dataRows != null)
		{
			return (from p in dataRows
				orderby GetTaskStage(p), p.Sort, p.Id
				select p).ToList();
		}
		return new List<DRHomeComeTask>();
	}

	public static int GetTaskStage(DRHomeComeTask taskRow)
	{
		if (taskRow == null)
		{
			return 1;
		}
		if (taskRow.FinishType <= 0)
		{
			return 1;
		}
		return taskRow.FinishType;
	}

	public static int GetTaskTargetValue(DRHomeComeTask taskRow)
	{
		if (taskRow == null || taskRow.FinishEx == null || taskRow.FinishEx.Count <= 0)
		{
			return 1;
		}
		int num = taskRow.FinishEx[taskRow.FinishEx.Count - 1];
		if (num <= 0)
		{
			return 1;
		}
		return num;
	}

	public static List<PropDataBase> BuildRewardPropsFromRewardDesc(int rewardDescId)
	{
		List<PropDataBase> list = new List<PropDataBase>();
		DRHomeComeRewardDesc dataRow = GameEntry.DataTable.GetDataRow<DRHomeComeRewardDesc>(rewardDescId);
		if (dataRow == null)
		{
			return list;
		}
		AddReward(list, 1, dataRow.Item1, dataRow.ItemSup1);
		AddReward(list, 1, dataRow.Item2, dataRow.ItemSup2);
		return list;
	}

	public static List<PropDataBase> BuildRewardPropsFromReward(int rewardId)
	{
		List<PropDataBase> list = new List<PropDataBase>();
		DRHomeComeReward dataRow = GameEntry.DataTable.GetDataRow<DRHomeComeReward>(rewardId);
		if (dataRow == null)
		{
			return list;
		}
		AddReward(list, dataRow.ItemType, dataRow.Item1, dataRow.ItemSup1);
		AddReward(list, dataRow.ItemType, dataRow.Item2, dataRow.ItemSup2);
		return list;
	}

	public static List<KnapsackItemViewModel> BuildKnapsackItemViewModels(int rewardId, OptionBase parent)
	{
		List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
		List<PropDataBase> list2 = BuildRewardPropsFromReward(rewardId);
		for (int i = 0; i < list2.Count; i++)
		{
			if (list2[i] != null && !list2[i].Empty)
			{
				list.Add(new KnapsackItemViewModel(parent, list2[i]));
			}
		}
		return list;
	}

	public static HomeComeSignIdMode DetectSignIdMode(HomeComeData data, IList<DRHomeComeSign> rows)
	{
		if (data == null || rows == null || rows.Count <= 0 || data.SignedIds == null || data.SignedIds.Count <= 0)
		{
			return HomeComeSignIdMode.RowId;
		}
		bool flag = rows.Any((DRHomeComeSign p) => data.SignedIds.Contains(p.Id));
		if (rows.Any((DRHomeComeSign p) => data.SignedIds.Contains(p.SignDate)) && !flag)
		{
			return HomeComeSignIdMode.SignDay;
		}
		return HomeComeSignIdMode.RowId;
	}

	public static int GetSignRequestId(DRHomeComeSign row, HomeComeSignIdMode mode)
	{
		if (row == null)
		{
			return 0;
		}
		if (mode != HomeComeSignIdMode.SignDay)
		{
			return row.Id;
		}
		return row.SignDate;
	}

	public static int GetSignAlternateRequestId(DRHomeComeSign row, HomeComeSignIdMode mode)
	{
		if (row == null)
		{
			return 0;
		}
		if (mode != HomeComeSignIdMode.SignDay)
		{
			return row.SignDate;
		}
		return row.Id;
	}

	private static void AddReward(List<PropDataBase> list, int itemType, int itemId, int itemCount)
	{
		if (list != null && itemId > 0 && itemCount > 0)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(itemType, itemId, itemCount);
			if (propDataBase == null || propDataBase.Empty)
			{
				propDataBase = PropDataBase.CreateByType(1, itemId, itemCount);
			}
			if (propDataBase != null && !propDataBase.Empty)
			{
				list.Add(propDataBase);
			}
		}
	}
}
