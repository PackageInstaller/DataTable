using System.Collections.Generic;

namespace Ase;

public class PhasedActivitySort : Comparer<ActivityTaskItemData>
{
	public override int Compare(ActivityTaskItemData x, ActivityTaskItemData y)
	{
		if (y.IsPhasedActivityTask.CompareTo(x.IsPhasedActivityTask) != 0)
		{
			return y.IsPhasedActivityTask.CompareTo(x.IsPhasedActivityTask);
		}
		if (y.TaskState.CompareTo(x.TaskState) != 0)
		{
			return x.TaskState.CompareTo(y.TaskState);
		}
		if (y.Uid.CompareTo(x.Uid) != 0)
		{
			return x.Uid.CompareTo(y.Uid);
		}
		return 0;
	}
}
