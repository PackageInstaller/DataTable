using GameFramework.Runtime;

namespace Ase;

public class TaskChangeNotifyMessager : MessageBase
{
	public TaskSystem.TaskChangeNotifyType changeNotifyType;

	public TaskDataViewModel taskDataViewModel;

	public TaskChangeNotifyMessager(object sender, TaskDataViewModel taskDataViewModel, TaskSystem.TaskChangeNotifyType changeNotifyType)
		: base(sender)
	{
		this.taskDataViewModel = taskDataViewModel;
		this.changeNotifyType = changeNotifyType;
	}
}
