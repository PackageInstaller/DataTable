using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace System;

[Serializable]
[ComVisible(true)]
public abstract class ValueType
{
	private static class Internal
	{
		public static int hash_code_of_ptr_seed;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool InternalEquals(object o1, object o2, out object[] fields);

	internal static bool DefaultEquals(object o1, object o2)
	{
		if (o1 == null && o2 == null)
		{
			return true;
		}
		if (o1 == null || o2 == null)
		{
			return false;
		}
		RuntimeType runtimeType = (RuntimeType)o1.GetType();
		RuntimeType runtimeType2 = (RuntimeType)o2.GetType();
		if (runtimeType != runtimeType2)
		{
			return false;
		}
		bool result = InternalEquals(o1, o2, out var fields);
		if (fields == null)
		{
			return result;
		}
		for (int i = 0; i < fields.Length; i += 2)
		{
			object obj = fields[i];
			object obj2 = fields[i + 1];
			if (obj == null)
			{
				if (obj2 != null)
				{
					return false;
				}
			}
			else if (!obj.Equals(obj2))
			{
				return false;
			}
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		return DefaultEquals(this, obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int InternalGetHashCode(object o, out object[] fields);

	public override int GetHashCode()
	{
		int num = InternalGetHashCode(this, out var fields);
		if (fields != null)
		{
			for (int i = 0; i < fields.Length; i++)
			{
				if (fields[i] != null)
				{
					num ^= fields[i].GetHashCode();
				}
			}
		}
		return num;
	}

	internal static int GetHashCodeOfPtr(IntPtr ptr)
	{
		int num = (int)ptr;
		int hash_code_of_ptr_seed = Internal.hash_code_of_ptr_seed;
		if (hash_code_of_ptr_seed == 0)
		{
			hash_code_of_ptr_seed = num;
			Interlocked.CompareExchange(ref Internal.hash_code_of_ptr_seed, hash_code_of_ptr_seed, 0);
			hash_code_of_ptr_seed = Internal.hash_code_of_ptr_seed;
		}
		return num - hash_code_of_ptr_seed;
	}

	public override string ToString()
	{
		return GetType().FullName;
	}
}
