namespace GameFramework.Runtime;

public interface IProgressResult<TProgress> : IAsyncResult
{
	TProgress Progress { get; }

	new IProgressCallbackable<TProgress> Callbackable();
}
public interface IProgressResult<TProgress, TResult> : IAsyncResult<TResult>, IAsyncResult, IProgressResult<TProgress>
{
	new IProgressCallbackable<TProgress, TResult> Callbackable();
}
