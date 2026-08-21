using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;

namespace Unity.Collections.LowLevel.Unsafe;

[NativeHeader("Runtime/Export/Unsafe/UnsafeUtility.bindings.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
public static class UnsafeUtility
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct IsUnmanagedCache<T>
	{
		internal static int value;
	}

	private struct AlignOfHelper<T> where T : struct
	{
		public byte dummy;

		public T data;
	}

	public static bool IsBlittable<T>() where T : struct
	{
		return IsBlittable(typeof(T));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void* Malloc(long size, int alignment, Allocator allocator);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void Free(void* memory, Allocator allocator);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void MemCpy(void* destination, void* source, long size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void MemCpyStride(void* destination, int destinationStride, void* source, int sourceStride, int elementSize, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void MemMove(void* destination, void* source, long size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void MemSet(void* destination, byte value, long size);

	public unsafe static void MemClear(void* destination, long size)
	{
		MemSet(destination, 0, size);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern int MemCmp(void* ptr1, void* ptr2, long size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int SizeOf(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool IsBlittable(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool IsUnmanaged(Type type);

	private static bool IsBlittableValueType(Type t)
	{
		return t.IsValueType && IsBlittable(t);
	}

	private static string GetReasonForTypeNonBlittableImpl(Type t, string name)
	{
		if (!t.IsValueType)
		{
			return $"{name} is not blittable because it is not of value type ({t})\n";
		}
		if (t.IsPrimitive)
		{
			return $"{name} is not blittable ({t})\n";
		}
		string text = "";
		FieldInfo[] fields = t.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		foreach (FieldInfo fieldInfo in fields)
		{
			if (!IsBlittableValueType(fieldInfo.FieldType))
			{
				text += GetReasonForTypeNonBlittableImpl(fieldInfo.FieldType, $"{name}.{fieldInfo.Name}");
			}
		}
		return text;
	}

	internal static bool IsArrayBlittable(Array arr)
	{
		return IsBlittableValueType(arr.GetType().GetElementType());
	}

	internal static bool IsGenericListBlittable<T>() where T : struct
	{
		return IsBlittable<T>();
	}

	internal static string GetReasonForArrayNonBlittable(Array arr)
	{
		Type elementType = arr.GetType().GetElementType();
		return GetReasonForTypeNonBlittableImpl(elementType, elementType.Name);
	}

	internal static string GetReasonForGenericListNonBlittable<T>() where T : struct
	{
		Type typeFromHandle = typeof(T);
		return GetReasonForTypeNonBlittableImpl(typeFromHandle, typeFromHandle.Name);
	}

	public static bool IsUnmanaged<T>()
	{
		int num = IsUnmanagedCache<T>.value;
		switch (num)
		{
		case 1:
			return true;
		case 0:
			num = (IsUnmanagedCache<T>.value = (IsUnmanaged(typeof(T)) ? 1 : (-1)));
			break;
		}
		return num == 1;
	}

	public static int AlignOf<T>() where T : struct
	{
		return SizeOf<AlignOfHelper<T>>() - SizeOf<T>();
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static void CopyPtrToStructure<T>(void* ptr, out T output) where T : struct
	{
		InternalCopyPtrToStructure<T>(ptr, out output);
	}

	private unsafe static void InternalCopyPtrToStructure<T>(void* ptr, out T output) where T : struct
	{
		output = System.Runtime.CompilerServices.Unsafe.Read<T>(ptr);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static T ReadArrayElement<T>(void* source, int index)
	{
		return ((T*)source)[index];
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static T ReadArrayElementWithStride<T>(void* source, int index, int stride)
	{
		return System.Runtime.CompilerServices.Unsafe.Read<T>((byte*)source + (long)index * (long)stride);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static void WriteArrayElement<T>(void* destination, int index, T value)
	{
		System.Runtime.CompilerServices.Unsafe.Write((byte*)destination + (long)index * (long)System.Runtime.CompilerServices.Unsafe.SizeOf<T>(), value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static void WriteArrayElementWithStride<T>(void* destination, int index, int stride, T value)
	{
		System.Runtime.CompilerServices.Unsafe.Write((byte*)destination + (long)index * (long)stride, value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static void* AddressOf<T>(ref T output) where T : struct
	{
		return System.Runtime.CompilerServices.Unsafe.AsPointer(ref output);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int SizeOf<T>() where T : struct
	{
		return System.Runtime.CompilerServices.Unsafe.SizeOf<T>();
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int EnumToInt<T>(T enumValue) where T : struct, IConvertible
	{
		int intValue = 0;
		InternalEnumToInt(ref enumValue, ref intValue);
		return intValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void InternalEnumToInt<T>(ref T enumValue, ref int intValue)
	{
		intValue = System.Runtime.CompilerServices.Unsafe.As<T, int>(ref enumValue);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool EnumEquals<T>(T lhs, T rhs) where T : struct, IConvertible
	{
		return (long)lhs == (long)rhs;
	}
}
