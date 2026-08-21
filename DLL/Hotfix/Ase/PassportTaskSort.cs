using System.Collections.Generic;

namespace Ase;

public class PassportTaskSort : Comparer<PassportTaskItemData>
{
	public override int Compare(PassportTaskItemData x, PassportTaskItemData y)
	{
		if (y.PassportTaskState.CompareTo(x.PassportTaskState) != 0)
		{
			return x.PassportTaskState.CompareTo(y.PassportTaskState);
		}
		if (y.TaskId.CompareTo(x.TaskId) != 0)
		{
			return x.TaskId.CompareTo(y.TaskId);
		}
		return 0;
	}
}
