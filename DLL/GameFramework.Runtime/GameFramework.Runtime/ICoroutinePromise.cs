using UnityEngine;

namespace GameFramework.Runtime;

public interface ICoroutinePromise : IPromise
{
	void AddCoroutine(Coroutine coroutine);
}
public interface ICoroutinePromise<TResult> : IPromise<TResult>, IPromise, ICoroutinePromise
{
}
