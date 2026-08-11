using System;
using System.Collections.Generic;
using System.Linq;

namespace Ase;

public class DrawCardActivityInfo
{
	public int AllTimes;

	public List<int> DrawState;

	public Dictionary<int, int> PositionRewards;

	public static List<int> AnalysisDrawState(int actTypeId, long state)
	{
		DRActivitySkinGet dataRow = GameEntry.DataTable.GetDataRow((DRActivitySkinGet p) => p.ActivityId == actTypeId);
		if (dataRow == null)
		{
			return new List<int>();
		}
		List<int> list = Enumerable.Reverse(Convert.ToString(state, 2).ToCharArray()).ToList().ConvertAll((char p) => int.Parse(p.ToString()));
		int count = list.Count;
		int count2 = dataRow.RewardIdGroup.Count;
		if (count < count2)
		{
			for (int num = 0; num < count2 - count; num++)
			{
				list.Add(0);
			}
		}
		return list;
	}

	public static void InitPosRewardInfo(DrawCardActivityInfo info, List<PbPositionReward> serverData)
	{
		info.PositionRewards = serverData?.ToDictionary((PbPositionReward p) => p.Pos, (PbPositionReward p) => p.RewardConfigId) ?? new Dictionary<int, int>();
	}

	public static void AddPosRewardInfo(DrawCardActivityInfo info, int pos, int rewardConfigId)
	{
		if (info.PositionRewards == null)
		{
			info.PositionRewards = new Dictionary<int, int>();
		}
		if (info.PositionRewards.ContainsKey(pos))
		{
			info.PositionRewards[pos] = rewardConfigId;
		}
		else
		{
			info.PositionRewards.Add(pos, rewardConfigId);
		}
	}
}
