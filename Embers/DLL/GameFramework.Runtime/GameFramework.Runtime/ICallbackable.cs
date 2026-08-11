using System;

namespace GameFramework.Runtime;

public interface ICallbackable
{
	void OnCallback(Action<IAsyncResult> callback);
}
public interface ICallbackable<TResult>
{
	void OnCallback(Action<IAsyncResult<TResult>> callback);
}
