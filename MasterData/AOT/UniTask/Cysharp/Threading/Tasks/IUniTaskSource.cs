using System;
using System.Threading.Tasks.Sources;

namespace Cysharp.Threading.Tasks;

public interface IUniTaskSource : IValueTaskSource
{
	new UniTaskStatus GetStatus(short token);

	void OnCompleted(Action<object> continuation, object state, short token);

	new void GetResult(short token);

	UniTaskStatus UnsafeGetStatus();

	ValueTaskSourceStatus IValueTaskSource.GetStatus(short token)
	{
		return (ValueTaskSourceStatus)GetStatus(token);
	}

	void IValueTaskSource.GetResult(short token)
	{
		GetResult(token);
	}

	void IValueTaskSource.OnCompleted(Action<object> continuation, object state, short token, ValueTaskSourceOnCompletedFlags flags)
	{
		OnCompleted(continuation, state, token);
	}
}
public interface IUniTaskSource<out T> : IUniTaskSource, IValueTaskSource, IValueTaskSource<T>
{
	new T GetResult(short token);

	new UniTaskStatus GetStatus(short token)
	{
		return ((IUniTaskSource)this).GetStatus(token);
	}

	new void OnCompleted(Action<object> continuation, object state, short token)
	{
		((IUniTaskSource)this).OnCompleted(continuation, state, token);
	}

	ValueTaskSourceStatus IValueTaskSource<T>.GetStatus(short token)
	{
		return (ValueTaskSourceStatus)((IUniTaskSource)this).GetStatus(token);
	}

	T IValueTaskSource<T>.GetResult(short token)
	{
		return GetResult(token);
	}

	void IValueTaskSource<T>.OnCompleted(Action<object> continuation, object state, short token, ValueTaskSourceOnCompletedFlags flags)
	{
		((IUniTaskSource)this).OnCompleted(continuation, state, token);
	}
}
