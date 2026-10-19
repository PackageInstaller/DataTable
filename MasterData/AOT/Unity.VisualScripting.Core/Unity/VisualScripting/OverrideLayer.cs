using System;

namespace Unity.VisualScripting;

public struct OverrideLayer<T> : IDisposable
{
	public OverrideStack<T> stack { get; }

	internal OverrideLayer(OverrideStack<T> stack, T item)
	{
		Ensure.That("stack").IsNotNull(stack);
		this.stack = stack;
		stack.BeginOverride(item);
	}

	public void Dispose()
	{
		stack.EndOverride();
	}
}
