using System.Collections.Generic;

namespace Ase;

public class HomeComeTaskSortComparer : Comparer<ActivityTaskItemData>
{
	public static readonly HomeComeTaskSortComparer Instance = new HomeComeTaskSortComparer();

	public override int Compare(ActivityTaskItemData x, ActivityTaskItemData y)
	{
		if (x == y)
		{
			return 0;
		}
		if (x == null)
		{
			return 1;
		}
		if (y == null)
		{
			return -1;
		}
		int stateWeight = GetStateWeight(x.TaskState);
		int stateWeight2 = GetStateWeight(y.TaskState);
		if (stateWeight != stateWeight2)
		{
			return stateWeight.CompareTo(stateWeight2);
		}
		return x.TaskId.CompareTo(y.TaskId);
	}

	private static int GetStateWeight(ActivityTaskStateEnum state)
	{
		return state switch
		{
			ActivityTaskStateEnum.Accept => 0, 
			ActivityTaskStateEnum.Jump => 1, 
			ActivityTaskStateEnum.Normal => 2, 
			ActivityTaskStateEnum.Finished => 3, 
			_ => 9, 
		};
	}
}
