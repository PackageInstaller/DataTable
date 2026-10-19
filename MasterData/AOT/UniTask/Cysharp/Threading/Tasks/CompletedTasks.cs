namespace Cysharp.Threading.Tasks;

internal static class CompletedTasks
{
	public static readonly UniTask<AsyncUnit> AsyncUnit = UniTask.FromResult(Cysharp.Threading.Tasks.AsyncUnit.Default);

	public static readonly UniTask<bool> True = UniTask.FromResult(value: true);

	public static readonly UniTask<bool> False = UniTask.FromResult(value: false);

	public static readonly UniTask<int> Zero = UniTask.FromResult(0);

	public static readonly UniTask<int> MinusOne = UniTask.FromResult(-1);

	public static readonly UniTask<int> One = UniTask.FromResult(1);
}
