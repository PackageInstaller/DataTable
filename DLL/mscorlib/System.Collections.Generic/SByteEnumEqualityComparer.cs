using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
internal sealed class SByteEnumEqualityComparer<T> : EnumEqualityComparer<T>, ISerializable where T : struct
{
	public SByteEnumEqualityComparer()
	{
	}

	public SByteEnumEqualityComparer(SerializationInfo information, StreamingContext context)
	{
	}

	public override int GetHashCode(T obj)
	{
		return ((sbyte)JitHelpers.UnsafeEnumCast(obj)).GetHashCode();
	}
}
