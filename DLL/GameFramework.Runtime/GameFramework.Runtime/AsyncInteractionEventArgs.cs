using System.Threading.Tasks;

namespace GameFramework.Runtime;

public class AsyncInteractionEventArgs : InteractionEventArgs
{
	public TaskCompletionSource<object> Source { get; }

	public AsyncInteractionEventArgs(TaskCompletionSource<object> source, object context)
		: base(context, delegate
		{
			source.TrySetResult(null);
		})
	{
		Source = source;
	}
}
