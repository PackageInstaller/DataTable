namespace System.Threading.Tasks;

public static class TaskExtensions
{
	public static Task Unwrap(this Task<Task> task)
	{
		if (task == null)
		{
			throw new ArgumentNullException("task");
		}
		object task2;
		if (task.IsCompletedSuccessfully)
		{
			task2 = task.Result;
			if (task2 == null)
			{
				return Task.FromCanceled(new CancellationToken(canceled: true));
			}
		}
		else
		{
			task2 = Task.CreateUnwrapPromise<VoidTaskResult>(task, lookForOce: false);
		}
		return (Task)task2;
	}
}
