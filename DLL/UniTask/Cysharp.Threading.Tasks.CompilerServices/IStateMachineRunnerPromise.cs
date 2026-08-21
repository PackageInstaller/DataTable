using System;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal interface IStateMachineRunnerPromise : IUniTaskSource
{
	Action MoveNext { get; }

	UniTask Task { get; }

	void SetResult();

	void SetException(Exception exception);
}
internal interface IStateMachineRunnerPromise<T> : IUniTaskSource<T>, IUniTaskSource
{
	Action MoveNext { get; }

	UniTask<T> Task { get; }

	void SetResult(T result);

	void SetException(Exception exception);
}
