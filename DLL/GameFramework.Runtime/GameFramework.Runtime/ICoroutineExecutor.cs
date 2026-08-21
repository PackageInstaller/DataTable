using System;
using System.Collections;

namespace GameFramework.Runtime;

public interface ICoroutineExecutor
{
	void RunOnCoroutineNoReturn(IEnumerator routine);

	IAsyncResult RunOnCoroutine(IEnumerator routine);

	IAsyncResult RunOnCoroutine(Func<IPromise, IEnumerator> func);

	IAsyncResult RunOnCoroutine<TResult>(Func<IPromise<TResult>, IEnumerator> func);

	IProgressResult<TProgress> RunOnCoroutine<TProgress>(Func<IProgressPromise<TProgress>, IEnumerator> func);

	IProgressResult<TProgress, TResult> RunOnCoroutine<TProgress, TResult>(Func<IProgressPromise<TProgress, TResult>, IEnumerator> func);
}
