using System;

namespace GameFramework.Runtime;

public interface IProgressTask<TProgress> : IProgressResult<TProgress>, IAsyncResult
{
	IProgressTask<TProgress> OnPreExecute(Action callback, bool runOnMainThread = true);

	IProgressTask<TProgress> OnPostExecute(Action callback, bool runOnMainThread = true);

	IProgressTask<TProgress> OnError(Action<Exception> callback, bool runOnMainThread = true);

	IProgressTask<TProgress> OnFinish(Action callback, bool runOnMainThread = true);

	IProgressTask<TProgress> OnProgressUpdate(Action<TProgress> callback, bool runOnMainThread = true);

	IProgressTask<TProgress> Start(int delay);

	IProgressTask<TProgress> Start();
}
public interface IProgressTask<TProgress, TResult> : IProgressResult<TProgress, TResult>, IAsyncResult<TResult>, IAsyncResult, IProgressResult<TProgress>
{
	IProgressTask<TProgress, TResult> OnPreExecute(Action callback, bool runOnMainThread = true);

	IProgressTask<TProgress, TResult> OnPostExecute(Action<TResult> callback, bool runOnMainThread = true);

	IProgressTask<TProgress, TResult> OnError(Action<Exception> callback, bool runOnMainThread = true);

	IProgressTask<TProgress, TResult> OnFinish(Action callback, bool runOnMainThread = true);

	IProgressTask<TProgress, TResult> OnProgressUpdate(Action<TProgress> callback, bool runOnMainThread = true);

	IProgressTask<TProgress, TResult> Start(int delay);

	IProgressTask<TProgress, TResult> Start();
}
