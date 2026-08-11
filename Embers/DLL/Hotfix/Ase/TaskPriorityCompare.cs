using System.Collections.Generic;

namespace Ase;

public class TaskPriorityCompare : IComparer<TaskDataViewModel>
{
	public int Compare(TaskDataViewModel x, TaskDataViewModel y)
	{
		return x.Priority.CompareTo(y.Priority);
	}
}
