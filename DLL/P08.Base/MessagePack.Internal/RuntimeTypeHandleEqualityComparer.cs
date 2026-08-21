using System;
using System.Collections.Generic;

namespace MessagePack.Internal;

public class RuntimeTypeHandleEqualityComparer : IEqualityComparer<RuntimeTypeHandle>
{
	public static readonly IEqualityComparer<RuntimeTypeHandle> Default = new RuntimeTypeHandleEqualityComparer();

	private RuntimeTypeHandleEqualityComparer()
	{
	}

	public bool Equals(RuntimeTypeHandle x, RuntimeTypeHandle y)
	{
		return x.Equals(y);
	}

	public int GetHashCode(RuntimeTypeHandle obj)
	{
		return obj.GetHashCode();
	}
}
