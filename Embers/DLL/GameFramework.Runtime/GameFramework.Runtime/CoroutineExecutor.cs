using System;
using System.Collections;

namespace GameFramework.Runtime;

public class CoroutineExecutor : AbstractExecutor, ICoroutineExecutor
{
	public virtual void RunOnCoroutineNoReturn(IEnumerator routine)
	{
		Executors.RunOnCoroutineNoReturn(routine);
	}

	public virtual IAsyncResult RunOnCoroutine(IEnumerator routine)
	{
		return Executors.RunOnCoroutine(routine);
	}

	public virtual IAsyncResult RunOnCoroutine(Func<IPromise, IEnumerator> func)
	{
		return Executors.RunOnCoroutine(func);
	}

	public virtual IAsyncResult RunOnCoroutine<TResult>(Func<IPromise<TResult>, IEnumerator> func)
	{
		return Executors.RunOnCoroutine(func);
	}

	public virtual IProgressResult<TProgress> RunOnCoroutine<TProgress>(Func<IProgressPromise<TProgress>, IEnumerator> func)
	{
		return Executors.RunOnCoroutine(func);
	}

	public virtual IProgressResult<TProgress, TResult> RunOnCoroutine<TProgress, TResult>(Func<IProgressPromise<TProgress, TResult>, IEnumerator> func)
	{
		return Executors.RunOnCoroutine(func);
	}
}
