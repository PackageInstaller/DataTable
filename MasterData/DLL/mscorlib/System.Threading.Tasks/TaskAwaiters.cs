namespace System.Threading.Tasks;

internal static class TaskAwaiters
{
	public static ForceAsyncAwaiter ForceAsync(this Task task)
	{
		return new ForceAsyncAwaiter(task);
	}
}
