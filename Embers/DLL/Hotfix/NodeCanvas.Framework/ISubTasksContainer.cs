using System;

namespace NodeCanvas.Framework;

[Obsolete("This is no longer used nor required")]
public interface ISubTasksContainer
{
	Task[] GetSubTasks();
}
