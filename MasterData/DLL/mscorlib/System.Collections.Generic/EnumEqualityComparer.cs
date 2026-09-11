using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
internal class EnumEqualityComparer<T> : EqualityComparer<T>, ISerializable where T : struct
{
	public override bool Equals(T x, T y)
	{
		int num = JitHelpers.UnsafeEnumCast(x);
		int num2 = JitHelpers.UnsafeEnumCast(y);
		return num == num2;
	}

	public override int GetHashCode(T obj)
	{
		return JitHelpers.UnsafeEnumCast(obj).GetHashCode();
	}

	public EnumEqualityComparer()
	{
	}

	protected EnumEqualityComparer(SerializationInfo information, StreamingContext context)
	{
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (Type.GetTypeCode(Enum.GetUnderlyingType(typeof(T))) != TypeCode.Int32)
		{
			info.SetType(typeof(ObjectEqualityComparer<T>));
		}
	}

	public override bool Equals(object obj)
	{
		return obj is EnumEqualityComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
