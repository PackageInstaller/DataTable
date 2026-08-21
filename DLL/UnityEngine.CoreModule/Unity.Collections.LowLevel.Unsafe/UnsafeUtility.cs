using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Burst;
using UnityEngine.Bindings;

namespace Unity.Collections.LowLevel.Unsafe;

[NativeHeader("Runtime/Export/Unsafe/UnsafeUtility.bindings.h")]
[StaticAccessor("UnsafeUtility", StaticAccessorType.DoubleColon)]
public static class UnsafeUtility
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct TypeFlagsCache<T>
	{
		internal static readonly int flags;

		static TypeFlagsCache()
		{
			Init(ref flags);
		}

		[BurstDiscard]
		private static void Init(ref int flags)
		{
			flags = GetScriptingTypeFlags(typeof(T));
		}
	}

	private struct AlignOfHelper<T> where T : struct
	{
		public byte dummy;

		public T data;
	}

	public unsafe static void* PinGCArrayAndGetDataAddress(Array target, out ulong gcHandle)
	{
		return PinSystemArrayAndGetAddress(target, out gcHandle);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private unsafe static extern void* PinSystemArrayAndGetAddress(object target, out ulong gcHandle);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void ReleaseGCObject(ulong gcHandle);

	public static bool IsBlittable<T>() where T : struct
	{
		return IsBlittable(typeof(T));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[BurstAuthorizedExternalMethod]
	[ThreadSafe(ThrowsException = false)]
	internal static extern int LeakRecord(IntPtr handle, LeakCategory category, int callstacksToSkip);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = false)]
	[BurstAuthorizedExternalMethod]
	internal static extern int LeakErase(IntPtr handle, LeakCategory category);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void* MallocTracked(long size, int alignment, Allocator allocator, int callstacksToSkip);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void FreeTracked(void* memory, Allocator allocator);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void* Malloc(long size, int alignment, Allocator allocator);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe(ThrowsException = true)]
	public unsafe static extern void Free(void* memory, Allocator allocator);

	public static bool IsValidAllocator(Allocator allocator)
	{
		return allocator > Allocator.None;
	}

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
	internal static extern int GetScriptingTypeFlags(Type type);

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
		return (TypeFlagsCache<T>.flags & 1) == 0;
	}

	public static bool IsValidNativeContainerElementType<T>()
	{
		return TypeFlagsCache<T>.flags == 0;
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
	public unsafe static void CopyStructureToPtr<T>(ref T input, void* ptr) where T : struct
	{
		InternalCopyStructureToPtr(ref input, ptr);
	}

	private unsafe static void InternalCopyStructureToPtr<T>(ref T input, void* ptr) where T : struct
	{
		System.Runtime.CompilerServices.Unsafe.Write(ptr, input);
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

	public static ref T As<U, T>(ref U from)
	{
		return ref System.Runtime.CompilerServices.Unsafe.As<U, T>(ref from);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static ref T AsRef<T>(void* ptr) where T : struct
	{
		return ref *(T*)ptr;
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static ref T ArrayElementAsRef<T>(void* ptr, int index) where T : struct
	{
		return ref *(T*)((byte*)ptr + (long)index * (long)System.Runtime.CompilerServices.Unsafe.SizeOf<T>());
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
