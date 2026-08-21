using System;

namespace Cysharp.Threading.Tasks;

public interface IUniTaskSource
{
	UniTaskStatus GetStatus(short token);

	void OnCompleted(Action<object> continuation, object state, short token);

	void GetResult(short token);

	UniTaskStatus UnsafeGetStatus();
}
public interface IUniTaskSource<out T> : IUniTaskSource
{
	new T GetResult(short token);
}
