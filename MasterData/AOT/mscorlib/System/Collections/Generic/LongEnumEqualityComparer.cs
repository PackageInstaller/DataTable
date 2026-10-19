using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
internal sealed class LongEnumEqualityComparer<T> : EqualityComparer<T>, ISerializable where T : struct
{
	public override bool Equals(T x, T y)
	{
		long num = JitHelpers.UnsafeEnumCastLong(x);
		long num2 = JitHelpers.UnsafeEnumCastLong(y);
		return num == num2;
	}

	public override int GetHashCode(T obj)
	{
		return JitHelpers.UnsafeEnumCastLong(obj).GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return obj is LongEnumEqualityComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}

	public LongEnumEqualityComparer()
	{
	}

	public LongEnumEqualityComparer(SerializationInfo information, StreamingContext context)
	{
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.SetType(typeof(ObjectEqualityComparer<T>));
	}
}
