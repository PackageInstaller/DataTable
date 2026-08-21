using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class CoroutineProgressResult<TProgress> : ProgressResult<TProgress>, ICoroutineProgressPromise<TProgress>, IProgressPromise<TProgress>, IPromise, ICoroutinePromise
{
	protected List<Coroutine> coroutines = new List<Coroutine>();

	public CoroutineProgressResult()
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
public class CoroutineProgressResult<TProgress, TResult> : ProgressResult<TProgress, TResult>, ICoroutineProgressPromise<TProgress, TResult>, IProgressPromise<TProgress, TResult>, IProgressPromise<TProgress>, IPromise, IPromise<TResult>, ICoroutineProgressPromise<TProgress>, ICoroutinePromise
{
	protected List<Coroutine> coroutines = new List<Coroutine>();

	public CoroutineProgressResult()
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
