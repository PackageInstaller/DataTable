using System.Collections.Generic;

namespace Ase;

public class GameActivitySort : Comparer<GameActivityItemData>
{
	public override int Compare(GameActivityItemData x, GameActivityItemData y)
	{
		if (y.TaskState.CompareTo(x.TaskState) != 0)
		{
			return y.TaskState.CompareTo(x.TaskState);
		}
		if (y.TaskId.CompareTo(x.TaskId) != 0)
		{
			return x.TaskId.CompareTo(y.TaskId);
		}
		return 0;
	}
}
