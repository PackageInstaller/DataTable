using System;

namespace GameFramework.Runtime;

public interface IAsyncTask : IAsyncResult
{
	IAsyncTask OnPreExecute(Action callback, bool runOnMainThread = true);

	IAsyncTask OnPostExecute(Action callback, bool runOnMainThread = true);

	IAsyncTask OnError(Action<Exception> callback, bool runOnMainThread = true);

	IAsyncTask OnFinish(Action callback, bool runOnMainThread = true);

	IAsyncTask Start(int delay);

	IAsyncTask Start();
}
public interface IAsyncTask<TResult> : IAsyncResult<TResult>, IAsyncResult
{
	IAsyncTask<TResult> OnPreExecute(Action callback, bool runOnMainThread = true);

	IAsyncTask<TResult> OnPostExecute(Action<TResult> callback, bool runOnMainThread = true);

	IAsyncTask<TResult> OnError(Action<Exception> callback, bool runOnMainThread = true);

	IAsyncTask<TResult> OnFinish(Action callback, bool runOnMainThread = true);

	IAsyncTask<TResult> Start(int delay);

	IAsyncTask<TResult> Start();
}
