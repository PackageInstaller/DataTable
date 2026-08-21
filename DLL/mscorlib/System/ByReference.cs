using System.Runtime.CompilerServices;

namespace System;

internal ref struct ByReference<T>
{
	private IntPtr _value;

	public ref T Value
	{
		[Intrinsic]
		get
		{
			throw new NotSupportedException();
		}
	}

	[Intrinsic]
	public ByReference(ref T value)
	{
		throw new NotSupportedException();
	}
}
