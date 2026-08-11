using System;
using System.Runtime.ExceptionServices;

namespace Cysharp.Threading.Tasks.Internal;

internal class ThrowObserver<T> : IObserver<T>
{
	public static readonly ThrowObserver<T> Instance = new ThrowObserver<T>();

	private ThrowObserver()
	{
	}

	public void OnCompleted()
	{
	}

	public void OnError(Exception error)
	{
		ExceptionDispatchInfo.Capture(error).Throw();
	}

	public void OnNext(T value)
	{
	}
}
