using System;

namespace GameFramework.Runtime;

public interface IThreadExecutor
{
	IAsyncResult Execute(Action action);

	IAsyncResult Execute<TResult>(Func<TResult> func);

	IAsyncResult Execute(Action<IPromise> action);

	IProgressResult<TProgress> Execute<TProgress>(Action<IProgressPromise<TProgress>> action);

	IAsyncResult Execute<TResult>(Action<IPromise<TResult>> action);

	IProgressResult<TProgress, TResult> Execute<TProgress, TResult>(Action<IProgressPromise<TProgress, TResult>> action);
}
