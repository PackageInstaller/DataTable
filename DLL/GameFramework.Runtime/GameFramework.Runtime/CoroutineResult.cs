using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class CoroutineResult : AsyncResult, ICoroutinePromise, IPromise
{
	protected List<Coroutine> coroutines = new List<Coroutine>();

	public CoroutineResult()
		: base(cancelable: true)
	{
	}

	public override bool Cancel()
	{
		if (IsDone)
		{
			return false;
		}
		cancellationRequested = true;
		foreach (Coroutine coroutine in coroutines)
		{
			Executors.StopCoroutine(coroutine);
		}
		SetCancelled();
		return true;
	}

	public void AddCoroutine(Coroutine coroutine)
	{
		coroutines.Add(coroutine);
	}
}
public class CoroutineResult<TResult> : AsyncResult<TResult>, ICoroutinePromise<TResult>, IPromise<TResult>, IPromise, ICoroutinePromise
{
	protected List<Coroutine> coroutines = new List<Coroutine>();

	public CoroutineResult()
		: base(true)
	{
	}

	public override bool Cancel()
	{
		if (IsDone)
		{
			return false;
		}
		cancellationRequested = true;
		foreach (Coroutine coroutine in coroutines)
		{
			Executors.StopCoroutine(coroutine);
		}
		SetCancelled();
		return true;
	}

	public void AddCoroutine(Coroutine coroutine)
	{
		coroutines.Add(coroutine);
	}
}
