using System.Threading.Tasks;

namespace GameFramework.Runtime;

public abstract class AsyncInteractionActionBase<TNotification> : IInteractionAction
{
	public void OnRequest(object sender, InteractionEventArgs args)
	{
		AsyncInteractionEventArgs e = args as AsyncInteractionEventArgs;
		TaskCompletionSource<object> source = e.Source;
		TNotification notification = (TNotification)e.Context;
		Action(notification).ContinueWith(delegate(Task t)
		{
			if (t.IsFaulted)
			{
				source.TrySetException(t.Exception);
			}
			else if (t.IsCanceled)
			{
				source.TrySetCanceled();
			}
			else
			{
				source.TrySetResult(null);
			}
		}, TaskContinuationOptions.ExecuteSynchronously);
	}

	public abstract Task Action(TNotification notification);
}
