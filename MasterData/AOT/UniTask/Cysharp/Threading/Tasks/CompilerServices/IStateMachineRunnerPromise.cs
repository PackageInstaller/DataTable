using System;
using System.Threading.Tasks.Sources;

namespace Cysharp.Threading.Tasks.CompilerServices;

internal interface IStateMachineRunnerPromise : IUniTaskSource, IValueTaskSource
{
	Action MoveNext { get; }

	UniTask Task { get; }

	void SetResult();

	void SetException(Exception exception);
}
internal interface IStateMachineRunnerPromise<T> : IUniTaskSource<T>, IUniTaskSource, IValueTaskSource, IValueTaskSource<T>
{
	Action MoveNext { get; }

	UniTask<T> Task { get; }

	void SetResult(T result);

	void SetException(Exception exception);
}
