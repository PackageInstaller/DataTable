using System.Runtime.CompilerServices;

namespace System.Threading;

public readonly struct AsyncLocalValueChangedArgs<T>
{
	[CompilerGenerated]
	private readonly T PreviousValue__BackingField;

	[CompilerGenerated]
	private readonly bool ThreadContextChanged__BackingField;

	public T CurrentValue { get; }

	internal AsyncLocalValueChangedArgs(T previousValue, T currentValue, bool contextChanged)
	{
		this = default;
		PreviousValue__BackingField = previousValue;
		CurrentValue = currentValue;
		ThreadContextChanged__BackingField = contextChanged;
	}
}
