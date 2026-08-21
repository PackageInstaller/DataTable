using System;

namespace NodeCanvas.Framework;

public interface IInvokable : IGraphElement
{
	string GetInvocationID();

	object Invoke(params object[] args);

	void InvokeAsync(Action<object> callback, params object[] args);
}
