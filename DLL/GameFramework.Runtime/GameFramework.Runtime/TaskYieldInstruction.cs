using System.Runtime.ExceptionServices;
using System.Threading.Tasks;
using UnityEngine;

namespace GameFramework.Runtime;

public class TaskYieldInstruction : CustomYieldInstruction
{
	private readonly Task task;

	public override bool keepWaiting
	{
		get
		{
			if (task.Exception != null)
			{
				ExceptionDispatchInfo.Capture(task.Exception).Throw();
			}
			return !task.IsCompleted;
		}
	}

	public TaskYieldInstruction(Task task)
	{
		this.task = task;
	}
}
public class TaskYieldInstruction<T> : CustomYieldInstruction
{
	private readonly Task<T> task;

	public override bool keepWaiting
	{
		get
		{
			if (task.Exception != null)
			{
				ExceptionDispatchInfo.Capture(task.Exception).Throw();
			}
			return !task.IsCompleted;
		}
	}

	public TaskYieldInstruction(Task<T> task)
	{
		this.task = task;
	}
}
