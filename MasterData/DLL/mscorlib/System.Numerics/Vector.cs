using System.Globalization;
using System.Numerics.Hashing;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.Numerics;

[Intrinsic]
public struct Vector<T> : IEquatable<Vector<T>>, IFormattable where T : struct
{
	private struct VectorSizeHelper
	{
		internal Vector<T> _placeholder;

		internal byte _byte;
	}

	private Register register;

	private static readonly int s_count = InitializeCount();

	private static readonly Vector<T> s_zero = default(Vector<T>);

	private static readonly Vector<T> s_one = new Vector<T>(GetOneValue());

	private static readonly Vector<T> s_allOnes = new Vector<T>(GetAllBitsSetValue());

	public static int Count
	{
		[Intrinsic]
		get
		{
			return s_count;
		}
	}

	public static Vector<T> Zero
	{
		[Intrinsic]
		get
		{
			return s_zero;
		}
	}

	public unsafe T this[int index]
	{
		[Intrinsic]
		get
		{
			if (index >= Count || index < 0)
			{
				throw new IndexOutOfRangeException(SR.Format("Specified argument was out of the range of valid values.", index));
			}
			if (typeof(T) == typeof(byte))
			{
				fixed (byte* byte_ = &register.byte_0)
				{
					return (T)(object)byte_[index];
				}
			}
			if (typeof(T) == typeof(sbyte))
			{
				fixed (sbyte* sbyte_ = &register.sbyte_0)
				{
					return (T)(object)sbyte_[index];
				}
			}
			if (typeof(T) == typeof(ushort))
			{
				fixed (ushort* uint16_ = &register.uint16_0)
				{
					return (T)(object)uint16_[index];
				}
			}
			if (typeof(T) == typeof(short))
			{
				fixed (short* int16_ = &register.int16_0)
				{
					return (T)(object)int16_[index];
				}
			}
			if (typeof(T) == typeof(uint))
			{
				fixed (uint* uint32_ = &register.uint32_0)
				{
					return (T)(object)uint32_[index];
				}
			}
			if (typeof(T) == typeof(int))
			{
				fixed (int* int32_ = &register.int32_0)
				{
					return (T)(object)int32_[index];
				}
			}
			if (typeof(T) == typeof(ulong))
			{
				fixed (ulong* uint64_ = &register.uint64_0)
				{
					return (T)(object)uint64_[index];
				}
			}
			if (typeof(T) == typeof(long))
			{
				fixed (long* int64_ = &register.int64_0)
				{
					return (T)(object)int64_[index];
				}
			}
			if (typeof(T) == typeof(float))
			{
				fixed (float* single_ = &register.single_0)
				{
					return (T)(object)single_[index];
				}
			}
			if (typeof(T) == typeof(double))
			{
				fixed (double* double_ = &register.double_0)
				{
					return (T)(object)double_[index];
				}
			}
			throw new NotSupportedException("Specified type is not supported");
		}
	}

	private unsafe static int InitializeCount()
	{
		VectorSizeHelper vectorSizeHelper = default(VectorSizeHelper);
		byte* ptr = &vectorSizeHelper._placeholder.register.byte_0;
		int num = (int)(&vectorSizeHelper._byte - ptr);
		int num2 = -1;
		if (typeof(T) == typeof(byte))
		{
			num2 = 1;
		}
		else if (typeof(T) == typeof(sbyte))
		{
			num2 = 1;
		}
		else if (typeof(T) == typeof(ushort))
		{
			num2 = 2;
		}
		else if (typeof(T) == typeof(short))
		{
			num2 = 2;
		}
		else if (typeof(T) == typeof(uint))
		{
			num2 = 4;
		}
		else if (typeof(T) == typeof(int))
		{
			num2 = 4;
		}
		else if (typeof(T) == typeof(ulong))
		{
			num2 = 8;
		}
		else if (typeof(T) == typeof(long))
		{
			num2 = 8;
		}
		else if (typeof(T) == typeof(float))
		{
			num2 = 4;
		}
		else
		{
			if (!(typeof(T) == typeof(double)))
			{
				throw new NotSupportedException("Specified type is not supported");
			}
			num2 = 8;
		}
		return num / num2;
	}

	[Intrinsic]
	public unsafe Vector(T value)
	{
		this = default(Vector<T>);
		if (Vector.IsHardwareAccelerated)
		{
			if (typeof(T) == typeof(byte))
			{
				fixed (byte* byte_ = &register.byte_0)
				{
					for (int i = 0; i < Count; i++)
					{
						byte_[i] = (byte)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(sbyte))
			{
				fixed (sbyte* sbyte_ = &register.sbyte_0)
				{
					for (int j = 0; j < Count; j++)
					{
						sbyte_[j] = (sbyte)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(ushort))
			{
				fixed (ushort* uint16_ = &register.uint16_0)
				{
					for (int k = 0; k < Count; k++)
					{
						uint16_[k] = (ushort)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(short))
			{
				fixed (short* int16_ = &register.int16_0)
				{
					for (int l = 0; l < Count; l++)
					{
						int16_[l] = (short)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(uint))
			{
				fixed (uint* uint32_ = &register.uint32_0)
				{
					for (int m = 0; m < Count; m++)
					{
						uint32_[m] = (uint)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(int))
			{
				fixed (int* int32_ = &register.int32_0)
				{
					for (int n = 0; n < Count; n++)
					{
						int32_[n] = (int)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(ulong))
			{
				fixed (ulong* uint64_ = &register.uint64_0)
				{
					for (int num = 0; num < Count; num++)
					{
						uint64_[num] = (ulong)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(long))
			{
				fixed (long* int64_ = &register.int64_0)
				{
					for (int num2 = 0; num2 < Count; num2++)
					{
						int64_[num2] = (long)(object)value;
					}
				}
			}
			else if (typeof(T) == typeof(float))
			{
				fixed (float* single_ = &register.single_0)
				{
					for (int num3 = 0; num3 < Count; num3++)
					{
						single_[num3] = (float)(object)value;
					}
				}
			}
			else
			{
				if (!(typeof(T) == typeof(double)))
				{
					return;
				}
				fixed (double* double_ = &register.double_0)
				{
					for (int num4 = 0; num4 < Count; num4++)
					{
						double_[num4] = (double)(object)value;
					}
				}
			}
		}
		else if (typeof(T) == typeof(byte))
		{
			register.byte_0 = (byte)(object)value;
			register.byte_1 = (byte)(object)value;
			register.byte_2 = (byte)(object)value;
			register.byte_3 = (byte)(object)value;
			register.byte_4 = (byte)(object)value;
			register.byte_5 = (byte)(object)value;
			register.byte_6 = (byte)(object)value;
			register.byte_7 = (byte)(object)value;
			register.byte_8 = (byte)(object)value;
			register.byte_9 = (byte)(object)value;
			register.byte_10 = (byte)(object)value;
			register.byte_11 = (byte)(object)value;
			register.byte_12 = (byte)(object)value;
			register.byte_13 = (byte)(object)value;
			register.byte_14 = (byte)(object)value;
			register.byte_15 = (byte)(object)value;
		}
		else if (typeof(T) == typeof(sbyte))
		{
			register.sbyte_0 = (sbyte)(object)value;
			register.sbyte_1 = (sbyte)(object)value;
			register.sbyte_2 = (sbyte)(object)value;
			register.sbyte_3 = (sbyte)(object)value;
			register.sbyte_4 = (sbyte)(object)value;
			register.sbyte_5 = (sbyte)(object)value;
			register.sbyte_6 = (sbyte)(object)value;
			register.sbyte_7 = (sbyte)(object)value;
			register.sbyte_8 = (sbyte)(object)value;
			register.sbyte_9 = (sbyte)(object)value;
			register.sbyte_10 = (sbyte)(object)value;
			register.sbyte_11 = (sbyte)(object)value;
			register.sbyte_12 = (sbyte)(object)value;
			register.sbyte_13 = (sbyte)(object)value;
			register.sbyte_14 = (sbyte)(object)value;
			register.sbyte_15 = (sbyte)(object)value;
		}
		else if (typeof(T) == typeof(ushort))
		{
			register.uint16_0 = (ushort)(object)value;
			register.uint16_1 = (ushort)(object)value;
			register.uint16_2 = (ushort)(object)value;
			register.uint16_3 = (ushort)(object)value;
			register.uint16_4 = (ushort)(object)value;
			register.uint16_5 = (ushort)(object)value;
			register.uint16_6 = (ushort)(object)value;
			register.uint16_7 = (ushort)(object)value;
		}
		else if (typeof(T) == typeof(short))
		{
			register.int16_0 = (short)(object)value;
			register.int16_1 = (short)(object)value;
			register.int16_2 = (short)(object)value;
			register.int16_3 = (short)(object)value;
			register.int16_4 = (short)(object)value;
			register.int16_5 = (short)(object)value;
			register.int16_6 = (short)(object)value;
			register.int16_7 = (short)(object)value;
		}
		else if (typeof(T) == typeof(uint))
		{
			register.uint32_0 = (uint)(object)value;
			register.uint32_1 = (uint)(object)value;
			register.uint32_2 = (uint)(object)value;
			register.uint32_3 = (uint)(object)value;
		}
		else if (typeof(T) == typeof(int))
		{
			register.int32_0 = (int)(object)value;
			register.int32_1 = (int)(object)value;
			register.int32_2 = (int)(object)value;
			register.int32_3 = (int)(object)value;
		}
		else if (typeof(T) == typeof(ulong))
		{
			register.uint64_0 = (ulong)(object)value;
			register.uint64_1 = (ulong)(object)value;
		}
		else if (typeof(T) == typeof(long))
		{
			register.int64_0 = (long)(object)value;
			register.int64_1 = (long)(object)value;
		}
		else if (typeof(T) == typeof(float))
		{
			register.single_0 = (float)(object)value;
			register.single_1 = (float)(object)value;
			register.single_2 = (float)(object)value;
			register.single_3 = (float)(object)value;
		}
		else if (typeof(T) == typeof(double))
		{
			register.double_0 = (double)(object)value;
			register.double_1 = (double)(object)value;
		}
	}

	internal unsafe Vector(void* dataPointer)
		: this(dataPointer, 0)
	{
	}

	internal unsafe Vector(void* dataPointer, int offset)
	{
		this = default(Vector<T>);
		if (typeof(T) == typeof(byte))
		{
			byte* ptr = (byte*)dataPointer;
			ptr += offset;
			fixed (byte* byte_ = &register.byte_0)
			{
				for (int i = 0; i < Count; i++)
				{
					byte_[i] = ptr[i];
				}
			}
			return;
		}
		if (typeof(T) == typeof(sbyte))
		{
			sbyte* ptr2 = (sbyte*)dataPointer;
			ptr2 += offset;
			fixed (sbyte* sbyte_ = &register.sbyte_0)
			{
				for (int j = 0; j < Count; j++)
				{
					sbyte_[j] = ptr2[j];
				}
			}
			return;
		}
		if (typeof(T) == typeof(ushort))
		{
			ushort* ptr3 = (ushort*)dataPointer;
			ptr3 += offset;
			fixed (ushort* uint16_ = &register.uint16_0)
			{
				for (int k = 0; k < Count; k++)
				{
					uint16_[k] = ptr3[k];
				}
			}
			return;
		}
		if (typeof(T) == typeof(short))
		{
			short* ptr4 = (short*)dataPointer;
			ptr4 += offset;
			fixed (short* int16_ = &register.int16_0)
			{
				for (int l = 0; l < Count; l++)
				{
					int16_[l] = ptr4[l];
				}
			}
			return;
		}
		if (typeof(T) == typeof(uint))
		{
			uint* ptr5 = (uint*)dataPointer;
			ptr5 += offset;
			fixed (uint* uint32_ = &register.uint32_0)
			{
				for (int m = 0; m < Count; m++)
				{
					uint32_[m] = ptr5[m];
				}
			}
			return;
		}
		if (typeof(T) == typeof(int))
		{
			int* ptr6 = (int*)dataPointer;
			ptr6 += offset;
			fixed (int* int32_ = &register.int32_0)
			{
				for (int n = 0; n < Count; n++)
				{
					int32_[n] = ptr6[n];
				}
			}
			return;
		}
		if (typeof(T) == typeof(ulong))
		{
			ulong* ptr7 = (ulong*)dataPointer;
			ptr7 += offset;
			fixed (ulong* uint64_ = &register.uint64_0)
			{
				for (int num = 0; num < Count; num++)
				{
					uint64_[num] = ptr7[num];
				}
			}
			return;
		}
		if (typeof(T) == typeof(long))
		{
			long* ptr8 = (long*)dataPointer;
			ptr8 += offset;
			fixed (long* int64_ = &register.int64_0)
			{
				for (int num2 = 0; num2 < Count; num2++)
				{
					int64_[num2] = ptr8[num2];
				}
			}
			return;
		}
		if (typeof(T) == typeof(float))
		{
			float* ptr9 = (float*)dataPointer;
			ptr9 += offset;
			fixed (float* single_ = &register.single_0)
			{
				for (int num3 = 0; num3 < Count; num3++)
				{
					single_[num3] = ptr9[num3];
				}
			}
			return;
		}
		if (typeof(T) == typeof(double))
		{
			double* ptr10 = (double*)dataPointer;
			ptr10 += offset;
			fixed (double* double_ = &register.double_0)
			{
				for (int num4 = 0; num4 < Count; num4++)
				{
					double_[num4] = ptr10[num4];
				}
			}
			return;
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	private Vector(ref Register existingRegister)
	{
		register = existingRegister;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object obj)
	{
		if (!(obj is Vector<T>))
		{
			return false;
		}
		return Equals((Vector<T>)obj);
	}

	[Intrinsic]
	public bool Equals(Vector<T> other)
	{
		if (Vector.IsHardwareAccelerated)
		{
			for (int i = 0; i < Count; i++)
			{
				if (!ScalarEquals(this[i], other[i]))
				{
					return false;
				}
			}
			return true;
		}
		if (typeof(T) == typeof(byte))
		{
			if (register.byte_0 == other.register.byte_0 && register.byte_1 == other.register.byte_1 && register.byte_2 == other.register.byte_2 && register.byte_3 == other.register.byte_3 && register.byte_4 == other.register.byte_4 && register.byte_5 == other.register.byte_5 && register.byte_6 == other.register.byte_6 && register.byte_7 == other.register.byte_7 && register.byte_8 == other.register.byte_8 && register.byte_9 == other.register.byte_9 && register.byte_10 == other.register.byte_10 && register.byte_11 == other.register.byte_11 && register.byte_12 == other.register.byte_12 && register.byte_13 == other.register.byte_13 && register.byte_14 == other.register.byte_14)
			{
				return register.byte_15 == other.register.byte_15;
			}
			return false;
		}
		if (typeof(T) == typeof(sbyte))
		{
			if (register.sbyte_0 == other.register.sbyte_0 && register.sbyte_1 == other.register.sbyte_1 && register.sbyte_2 == other.register.sbyte_2 && register.sbyte_3 == other.register.sbyte_3 && register.sbyte_4 == other.register.sbyte_4 && register.sbyte_5 == other.register.sbyte_5 && register.sbyte_6 == other.register.sbyte_6 && register.sbyte_7 == other.register.sbyte_7 && register.sbyte_8 == other.register.sbyte_8 && register.sbyte_9 == other.register.sbyte_9 && register.sbyte_10 == other.register.sbyte_10 && register.sbyte_11 == other.register.sbyte_11 && register.sbyte_12 == other.register.sbyte_12 && register.sbyte_13 == other.register.sbyte_13 && register.sbyte_14 == other.register.sbyte_14)
			{
				return register.sbyte_15 == other.register.sbyte_15;
			}
			return false;
		}
		if (typeof(T) == typeof(ushort))
		{
			if (register.uint16_0 == other.register.uint16_0 && register.uint16_1 == other.register.uint16_1 && register.uint16_2 == other.register.uint16_2 && register.uint16_3 == other.register.uint16_3 && register.uint16_4 == other.register.uint16_4 && register.uint16_5 == other.register.uint16_5 && register.uint16_6 == other.register.uint16_6)
			{
				return register.uint16_7 == other.register.uint16_7;
			}
			return false;
		}
		if (typeof(T) == typeof(short))
		{
			if (register.int16_0 == other.register.int16_0 && register.int16_1 == other.register.int16_1 && register.int16_2 == other.register.int16_2 && register.int16_3 == other.register.int16_3 && register.int16_4 == other.register.int16_4 && register.int16_5 == other.register.int16_5 && register.int16_6 == other.register.int16_6)
			{
				return register.int16_7 == other.register.int16_7;
			}
			return false;
		}
		if (typeof(T) == typeof(uint))
		{
			if (register.uint32_0 == other.register.uint32_0 && register.uint32_1 == other.register.uint32_1 && register.uint32_2 == other.register.uint32_2)
			{
				return register.uint32_3 == other.register.uint32_3;
			}
			return false;
		}
		if (typeof(T) == typeof(int))
		{
			if (register.int32_0 == other.register.int32_0 && register.int32_1 == other.register.int32_1 && register.int32_2 == other.register.int32_2)
			{
				return register.int32_3 == other.register.int32_3;
			}
			return false;
		}
		if (typeof(T) == typeof(ulong))
		{
			if (register.uint64_0 == other.register.uint64_0)
			{
				return register.uint64_1 == other.register.uint64_1;
			}
			return false;
		}
		if (typeof(T) == typeof(long))
		{
			if (register.int64_0 == other.register.int64_0)
			{
				return register.int64_1 == other.register.int64_1;
			}
			return false;
		}
		if (typeof(T) == typeof(float))
		{
			if (register.single_0 == other.register.single_0 && register.single_1 == other.register.single_1 && register.single_2 == other.register.single_2)
			{
				return register.single_3 == other.register.single_3;
			}
			return false;
		}
		if (typeof(T) == typeof(double))
		{
			if (register.double_0 == other.register.double_0)
			{
				return register.double_1 == other.register.double_1;
			}
			return false;
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	public override int GetHashCode()
	{
		int num = 0;
		if (Vector.IsHardwareAccelerated)
		{
			if (typeof(T) == typeof(byte))
			{
				for (int i = 0; i < Count; i++)
				{
					num = HashHelpers.Combine(num, ((byte)(object)this[i]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(sbyte))
			{
				for (int j = 0; j < Count; j++)
				{
					num = HashHelpers.Combine(num, ((sbyte)(object)this[j]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(ushort))
			{
				for (int k = 0; k < Count; k++)
				{
					num = HashHelpers.Combine(num, ((ushort)(object)this[k]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(short))
			{
				for (int l = 0; l < Count; l++)
				{
					num = HashHelpers.Combine(num, ((short)(object)this[l]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(uint))
			{
				for (int m = 0; m < Count; m++)
				{
					num = HashHelpers.Combine(num, ((uint)(object)this[m]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(int))
			{
				for (int n = 0; n < Count; n++)
				{
					num = HashHelpers.Combine(num, ((int)(object)this[n]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(ulong))
			{
				for (int num2 = 0; num2 < Count; num2++)
				{
					num = HashHelpers.Combine(num, ((ulong)(object)this[num2]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(long))
			{
				for (int num3 = 0; num3 < Count; num3++)
				{
					num = HashHelpers.Combine(num, ((long)(object)this[num3]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(float))
			{
				for (int num4 = 0; num4 < Count; num4++)
				{
					num = HashHelpers.Combine(num, ((float)(object)this[num4]).GetHashCode());
				}
				return num;
			}
			if (typeof(T) == typeof(double))
			{
				for (int num5 = 0; num5 < Count; num5++)
				{
					num = HashHelpers.Combine(num, ((double)(object)this[num5]).GetHashCode());
				}
				return num;
			}
			throw new NotSupportedException("Specified type is not supported");
		}
		if (typeof(T) == typeof(byte))
		{
			num = HashHelpers.Combine(num, register.byte_0.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_1.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_2.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_3.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_4.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_5.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_6.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_7.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_8.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_9.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_10.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_11.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_12.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_13.GetHashCode());
			num = HashHelpers.Combine(num, register.byte_14.GetHashCode());
			return HashHelpers.Combine(num, register.byte_15.GetHashCode());
		}
		if (typeof(T) == typeof(sbyte))
		{
			num = HashHelpers.Combine(num, register.sbyte_0.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_1.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_2.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_3.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_4.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_5.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_6.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_7.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_8.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_9.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_10.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_11.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_12.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_13.GetHashCode());
			num = HashHelpers.Combine(num, register.sbyte_14.GetHashCode());
			return HashHelpers.Combine(num, register.sbyte_15.GetHashCode());
		}
		if (typeof(T) == typeof(ushort))
		{
			num = HashHelpers.Combine(num, register.uint16_0.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_1.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_2.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_3.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_4.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_5.GetHashCode());
			num = HashHelpers.Combine(num, register.uint16_6.GetHashCode());
			return HashHelpers.Combine(num, register.uint16_7.GetHashCode());
		}
		if (typeof(T) == typeof(short))
		{
			num = HashHelpers.Combine(num, register.int16_0.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_1.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_2.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_3.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_4.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_5.GetHashCode());
			num = HashHelpers.Combine(num, register.int16_6.GetHashCode());
			return HashHelpers.Combine(num, register.int16_7.GetHashCode());
		}
		if (typeof(T) == typeof(uint))
		{
			num = HashHelpers.Combine(num, register.uint32_0.GetHashCode());
			num = HashHelpers.Combine(num, register.uint32_1.GetHashCode());
			num = HashHelpers.Combine(num, register.uint32_2.GetHashCode());
			return HashHelpers.Combine(num, register.uint32_3.GetHashCode());
		}
		if (typeof(T) == typeof(int))
		{
			num = HashHelpers.Combine(num, register.int32_0.GetHashCode());
			num = HashHelpers.Combine(num, register.int32_1.GetHashCode());
			num = HashHelpers.Combine(num, register.int32_2.GetHashCode());
			return HashHelpers.Combine(num, register.int32_3.GetHashCode());
		}
		if (typeof(T) == typeof(ulong))
		{
			num = HashHelpers.Combine(num, register.uint64_0.GetHashCode());
			return HashHelpers.Combine(num, register.uint64_1.GetHashCode());
		}
		if (typeof(T) == typeof(long))
		{
			num = HashHelpers.Combine(num, register.int64_0.GetHashCode());
			return HashHelpers.Combine(num, register.int64_1.GetHashCode());
		}
		if (typeof(T) == typeof(float))
		{
			num = HashHelpers.Combine(num, register.single_0.GetHashCode());
			num = HashHelpers.Combine(num, register.single_1.GetHashCode());
			num = HashHelpers.Combine(num, register.single_2.GetHashCode());
			return HashHelpers.Combine(num, register.single_3.GetHashCode());
		}
		if (typeof(T) == typeof(double))
		{
			num = HashHelpers.Combine(num, register.double_0.GetHashCode());
			return HashHelpers.Combine(num, register.double_1.GetHashCode());
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	public override string ToString()
	{
		return ToString("G", CultureInfo.CurrentCulture);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		StringBuilder stringBuilder = new StringBuilder();
		string numberGroupSeparator = NumberFormatInfo.GetInstance(formatProvider).NumberGroupSeparator;
		stringBuilder.Append('<');
		for (int i = 0; i < Count - 1; i++)
		{
			stringBuilder.Append(((IFormattable)(object)this[i]).ToString(format, formatProvider));
			stringBuilder.Append(numberGroupSeparator);
			stringBuilder.Append(' ');
		}
		stringBuilder.Append(((IFormattable)(object)this[Count - 1]).ToString(format, formatProvider));
		stringBuilder.Append('>');
		return stringBuilder.ToString();
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector<T> left, Vector<T> right)
	{
		return left.Equals(right);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector<T> left, Vector<T> right)
	{
		return !(left == right);
	}

	[Intrinsic]
	[CLSCompliant(false)]
	public static explicit operator Vector<ulong>(Vector<T> value)
	{
		return new Vector<ulong>(ref value.register);
	}

	[MethodImpl((MethodImplOptions)256)]
	[Intrinsic]
	internal unsafe static Vector<T> Equals(Vector<T> left, Vector<T> right)
	{
		if (Vector.IsHardwareAccelerated)
		{
			if (typeof(T) == typeof(byte))
			{
				byte* ptr = stackalloc byte[(int)(uint)Count];
				for (int i = 0; i < Count; i++)
				{
					ptr[i] = (byte)(ScalarEquals(left[i], right[i]) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr);
			}
			if (typeof(T) == typeof(sbyte))
			{
				sbyte* ptr2 = stackalloc sbyte[(int)(uint)Count];
				for (int j = 0; j < Count; j++)
				{
					ptr2[j] = (sbyte)(ScalarEquals(left[j], right[j]) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr2);
			}
			if (typeof(T) == typeof(ushort))
			{
				ushort* ptr3 = stackalloc ushort[Count];
				for (int k = 0; k < Count; k++)
				{
					ptr3[k] = (ushort)(ScalarEquals(left[k], right[k]) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr3);
			}
			if (typeof(T) == typeof(short))
			{
				short* ptr4 = stackalloc short[Count];
				for (int l = 0; l < Count; l++)
				{
					ptr4[l] = (short)(ScalarEquals(left[l], right[l]) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr4);
			}
			if (typeof(T) == typeof(uint))
			{
				uint* ptr5 = stackalloc uint[Count];
				for (int m = 0; m < Count; m++)
				{
					ptr5[m] = (ScalarEquals(left[m], right[m]) ? ConstantHelper.GetUInt32WithAllBitsSet() : 0u);
				}
				return new Vector<T>(ptr5);
			}
			if (typeof(T) == typeof(int))
			{
				int* ptr6 = stackalloc int[Count];
				for (int n = 0; n < Count; n++)
				{
					ptr6[n] = (ScalarEquals(left[n], right[n]) ? ConstantHelper.GetInt32WithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr6);
			}
			if (typeof(T) == typeof(ulong))
			{
				ulong* ptr7 = stackalloc ulong[Count];
				for (int num = 0; num < Count; num++)
				{
					ptr7[num] = (ScalarEquals(left[num], right[num]) ? ConstantHelper.GetUInt64WithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr7);
			}
			if (typeof(T) == typeof(long))
			{
				long* ptr8 = stackalloc long[Count];
				for (int num2 = 0; num2 < Count; num2++)
				{
					ptr8[num2] = (ScalarEquals(left[num2], right[num2]) ? ConstantHelper.GetInt64WithAllBitsSet() : 0);
				}
				return new Vector<T>(ptr8);
			}
			if (typeof(T) == typeof(float))
			{
				float* ptr9 = stackalloc float[Count];
				for (int num3 = 0; num3 < Count; num3++)
				{
					ptr9[num3] = (ScalarEquals(left[num3], right[num3]) ? ConstantHelper.GetSingleWithAllBitsSet() : 0f);
				}
				return new Vector<T>(ptr9);
			}
			if (typeof(T) == typeof(double))
			{
				double* ptr10 = stackalloc double[Count];
				for (int num4 = 0; num4 < Count; num4++)
				{
					ptr10[num4] = (ScalarEquals(left[num4], right[num4]) ? ConstantHelper.GetDoubleWithAllBitsSet() : 0.0);
				}
				return new Vector<T>(ptr10);
			}
			throw new NotSupportedException("Specified type is not supported");
		}
		Register existingRegister = default(Register);
		if (typeof(T) == typeof(byte))
		{
			existingRegister.byte_0 = (byte)((left.register.byte_0 == right.register.byte_0) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_1 = (byte)((left.register.byte_1 == right.register.byte_1) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_2 = (byte)((left.register.byte_2 == right.register.byte_2) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_3 = (byte)((left.register.byte_3 == right.register.byte_3) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_4 = (byte)((left.register.byte_4 == right.register.byte_4) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_5 = (byte)((left.register.byte_5 == right.register.byte_5) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_6 = (byte)((left.register.byte_6 == right.register.byte_6) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_7 = (byte)((left.register.byte_7 == right.register.byte_7) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_8 = (byte)((left.register.byte_8 == right.register.byte_8) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_9 = (byte)((left.register.byte_9 == right.register.byte_9) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_10 = (byte)((left.register.byte_10 == right.register.byte_10) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_11 = (byte)((left.register.byte_11 == right.register.byte_11) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_12 = (byte)((left.register.byte_12 == right.register.byte_12) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_13 = (byte)((left.register.byte_13 == right.register.byte_13) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_14 = (byte)((left.register.byte_14 == right.register.byte_14) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			existingRegister.byte_15 = (byte)((left.register.byte_15 == right.register.byte_15) ? ConstantHelper.GetByteWithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(sbyte))
		{
			existingRegister.sbyte_0 = (sbyte)((left.register.sbyte_0 == right.register.sbyte_0) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_1 = (sbyte)((left.register.sbyte_1 == right.register.sbyte_1) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_2 = (sbyte)((left.register.sbyte_2 == right.register.sbyte_2) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_3 = (sbyte)((left.register.sbyte_3 == right.register.sbyte_3) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_4 = (sbyte)((left.register.sbyte_4 == right.register.sbyte_4) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_5 = (sbyte)((left.register.sbyte_5 == right.register.sbyte_5) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_6 = (sbyte)((left.register.sbyte_6 == right.register.sbyte_6) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_7 = (sbyte)((left.register.sbyte_7 == right.register.sbyte_7) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_8 = (sbyte)((left.register.sbyte_8 == right.register.sbyte_8) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_9 = (sbyte)((left.register.sbyte_9 == right.register.sbyte_9) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_10 = (sbyte)((left.register.sbyte_10 == right.register.sbyte_10) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_11 = (sbyte)((left.register.sbyte_11 == right.register.sbyte_11) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_12 = (sbyte)((left.register.sbyte_12 == right.register.sbyte_12) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_13 = (sbyte)((left.register.sbyte_13 == right.register.sbyte_13) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_14 = (sbyte)((left.register.sbyte_14 == right.register.sbyte_14) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			existingRegister.sbyte_15 = (sbyte)((left.register.sbyte_15 == right.register.sbyte_15) ? ConstantHelper.GetSByteWithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(ushort))
		{
			existingRegister.uint16_0 = (ushort)((left.register.uint16_0 == right.register.uint16_0) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_1 = (ushort)((left.register.uint16_1 == right.register.uint16_1) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_2 = (ushort)((left.register.uint16_2 == right.register.uint16_2) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_3 = (ushort)((left.register.uint16_3 == right.register.uint16_3) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_4 = (ushort)((left.register.uint16_4 == right.register.uint16_4) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_5 = (ushort)((left.register.uint16_5 == right.register.uint16_5) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_6 = (ushort)((left.register.uint16_6 == right.register.uint16_6) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			existingRegister.uint16_7 = (ushort)((left.register.uint16_7 == right.register.uint16_7) ? ConstantHelper.GetUInt16WithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(short))
		{
			existingRegister.int16_0 = (short)((left.register.int16_0 == right.register.int16_0) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_1 = (short)((left.register.int16_1 == right.register.int16_1) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_2 = (short)((left.register.int16_2 == right.register.int16_2) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_3 = (short)((left.register.int16_3 == right.register.int16_3) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_4 = (short)((left.register.int16_4 == right.register.int16_4) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_5 = (short)((left.register.int16_5 == right.register.int16_5) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_6 = (short)((left.register.int16_6 == right.register.int16_6) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			existingRegister.int16_7 = (short)((left.register.int16_7 == right.register.int16_7) ? ConstantHelper.GetInt16WithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(uint))
		{
			existingRegister.uint32_0 = ((left.register.uint32_0 == right.register.uint32_0) ? ConstantHelper.GetUInt32WithAllBitsSet() : 0u);
			existingRegister.uint32_1 = ((left.register.uint32_1 == right.register.uint32_1) ? ConstantHelper.GetUInt32WithAllBitsSet() : 0u);
			existingRegister.uint32_2 = ((left.register.uint32_2 == right.register.uint32_2) ? ConstantHelper.GetUInt32WithAllBitsSet() : 0u);
			existingRegister.uint32_3 = ((left.register.uint32_3 == right.register.uint32_3) ? ConstantHelper.GetUInt32WithAllBitsSet() : 0u);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(int))
		{
			existingRegister.int32_0 = ((left.register.int32_0 == right.register.int32_0) ? ConstantHelper.GetInt32WithAllBitsSet() : 0);
			existingRegister.int32_1 = ((left.register.int32_1 == right.register.int32_1) ? ConstantHelper.GetInt32WithAllBitsSet() : 0);
			existingRegister.int32_2 = ((left.register.int32_2 == right.register.int32_2) ? ConstantHelper.GetInt32WithAllBitsSet() : 0);
			existingRegister.int32_3 = ((left.register.int32_3 == right.register.int32_3) ? ConstantHelper.GetInt32WithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(ulong))
		{
			existingRegister.uint64_0 = ((left.register.uint64_0 == right.register.uint64_0) ? ConstantHelper.GetUInt64WithAllBitsSet() : 0);
			existingRegister.uint64_1 = ((left.register.uint64_1 == right.register.uint64_1) ? ConstantHelper.GetUInt64WithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(long))
		{
			existingRegister.int64_0 = ((left.register.int64_0 == right.register.int64_0) ? ConstantHelper.GetInt64WithAllBitsSet() : 0);
			existingRegister.int64_1 = ((left.register.int64_1 == right.register.int64_1) ? ConstantHelper.GetInt64WithAllBitsSet() : 0);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(float))
		{
			existingRegister.single_0 = ((left.register.single_0 == right.register.single_0) ? ConstantHelper.GetSingleWithAllBitsSet() : 0f);
			existingRegister.single_1 = ((left.register.single_1 == right.register.single_1) ? ConstantHelper.GetSingleWithAllBitsSet() : 0f);
			existingRegister.single_2 = ((left.register.single_2 == right.register.single_2) ? ConstantHelper.GetSingleWithAllBitsSet() : 0f);
			existingRegister.single_3 = ((left.register.single_3 == right.register.single_3) ? ConstantHelper.GetSingleWithAllBitsSet() : 0f);
			return new Vector<T>(ref existingRegister);
		}
		if (typeof(T) == typeof(double))
		{
			existingRegister.double_0 = ((left.register.double_0 == right.register.double_0) ? ConstantHelper.GetDoubleWithAllBitsSet() : 0.0);
			existingRegister.double_1 = ((left.register.double_1 == right.register.double_1) ? ConstantHelper.GetDoubleWithAllBitsSet() : 0.0);
			return new Vector<T>(ref existingRegister);
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool ScalarEquals(T left, T right)
	{
		if (typeof(T) == typeof(byte))
		{
			return (byte)(object)left == (byte)(object)right;
		}
		if (typeof(T) == typeof(sbyte))
		{
			return (sbyte)(object)left == (sbyte)(object)right;
		}
		if (typeof(T) == typeof(ushort))
		{
			return (ushort)(object)left == (ushort)(object)right;
		}
		if (typeof(T) == typeof(short))
		{
			return (short)(object)left == (short)(object)right;
		}
		if (typeof(T) == typeof(uint))
		{
			return (uint)(object)left == (uint)(object)right;
		}
		if (typeof(T) == typeof(int))
		{
			return (int)(object)left == (int)(object)right;
		}
		if (typeof(T) == typeof(ulong))
		{
			return (ulong)(object)left == (ulong)(object)right;
		}
		if (typeof(T) == typeof(long))
		{
			return (long)(object)left == (long)(object)right;
		}
		if (typeof(T) == typeof(float))
		{
			return (float)(object)left == (float)(object)right;
		}
		if (typeof(T) == typeof(double))
		{
			return (double)(object)left == (double)(object)right;
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	[MethodImpl((MethodImplOptions)256)]
	private static T GetOneValue()
	{
		if (typeof(T) == typeof(byte))
		{
			return (T)(object)(byte)1;
		}
		if (typeof(T) == typeof(sbyte))
		{
			return (T)(object)(sbyte)1;
		}
		if (typeof(T) == typeof(ushort))
		{
			return (T)(object)(ushort)1;
		}
		if (typeof(T) == typeof(short))
		{
			return (T)(object)(short)1;
		}
		if (typeof(T) == typeof(uint))
		{
			return (T)(object)1u;
		}
		if (typeof(T) == typeof(int))
		{
			return (T)(object)1;
		}
		if (typeof(T) == typeof(ulong))
		{
			return (T)(object)1uL;
		}
		if (typeof(T) == typeof(long))
		{
			return (T)(object)1L;
		}
		if (typeof(T) == typeof(float))
		{
			return (T)(object)1f;
		}
		if (typeof(T) == typeof(double))
		{
			return (T)(object)1.0;
		}
		throw new NotSupportedException("Specified type is not supported");
	}

	[MethodImpl((MethodImplOptions)256)]
	private static T GetAllBitsSetValue()
	{
		if (typeof(T) == typeof(byte))
		{
			return (T)(object)ConstantHelper.GetByteWithAllBitsSet();
		}
		if (typeof(T) == typeof(sbyte))
		{
			return (T)(object)ConstantHelper.GetSByteWithAllBitsSet();
		}
		if (typeof(T) == typeof(ushort))
		{
			return (T)(object)ConstantHelper.GetUInt16WithAllBitsSet();
		}
		if (typeof(T) == typeof(short))
		{
			return (T)(object)ConstantHelper.GetInt16WithAllBitsSet();
		}
		if (typeof(T) == typeof(uint))
		{
			return (T)(object)ConstantHelper.GetUInt32WithAllBitsSet();
		}
		if (typeof(T) == typeof(int))
		{
			return (T)(object)ConstantHelper.GetInt32WithAllBitsSet();
		}
		if (typeof(T) == typeof(ulong))
		{
			return (T)(object)ConstantHelper.GetUInt64WithAllBitsSet();
		}
		if (typeof(T) == typeof(long))
		{
			return (T)(object)ConstantHelper.GetInt64WithAllBitsSet();
		}
		if (typeof(T) == typeof(float))
		{
			return (T)(object)ConstantHelper.GetSingleWithAllBitsSet();
		}
		if (typeof(T) == typeof(double))
		{
			return (T)(object)ConstantHelper.GetDoubleWithAllBitsSet();
		}
		throw new NotSupportedException("Specified type is not supported");
	}
}
[Intrinsic]
public static class Vector
{
	public static bool IsHardwareAccelerated
	{
		[Intrinsic]
		get
		{
			return false;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector<T> Equals<T>(Vector<T> left, Vector<T> right) where T : struct
	{
		return Vector<T>.Equals(left, right);
	}

	[MethodImpl((MethodImplOptions)256)]
	[CLSCompliant(false)]
	public static Vector<ulong> AsVectorUInt64<T>(Vector<T> value) where T : struct
	{
		return (Vector<ulong>)value;
	}
}
