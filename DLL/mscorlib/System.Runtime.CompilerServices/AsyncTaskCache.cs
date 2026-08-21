using System.Threading;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

internal static class AsyncTaskCache
{
	internal static readonly Task<bool> TrueTask = CreateCacheableTask(result: true);

	internal static readonly Task<bool> FalseTask = CreateCacheableTask(result: false);

	internal static readonly Task<int>[] Int32Tasks = CreateInt32Tasks();

	private static Task<int>[] CreateInt32Tasks()
	{
		Task<int>[] array = new Task<int>[10];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = CreateCacheableTask(i + -1);
		}
		return array;
	}

	internal static Task<TResult> CreateCacheableTask<TResult>(TResult result)
	{
		return new Task<TResult>(canceled: false, result, (TaskCreationOptions)16384, default(CancellationToken));
	}
}
