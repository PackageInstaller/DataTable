using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public class TaskShowEvent : PopupEvent
{
	private int taskId;

	public int TaskId => taskId;

	public TaskShowEvent(int taskId, Func<UniTask> showEvent)
		: base(showEvent)
	{
		this.taskId = taskId;
	}
}
