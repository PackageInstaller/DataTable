using System;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace MemoryPack.Internal;

internal static class TypeHelpers
{
	private static class Cache<T>
	{
		public static bool IsReferenceOrNullable;

		public static bool IsUnmanagedSZArray;

		public static int UnmanagedSZArrayElementSize;

		public static bool IsFixedSizeMemoryPackable;

		public static int MemoryPackableFixedSize;

		static Cache()
		{
			try
			{
				Type typeFromHandle = typeof(T);
				IsReferenceOrNullable = !typeFromHandle.IsValueType || Nullable.GetUnderlyingType(typeFromHandle) != null;
				if (typeFromHandle.IsSZArray)
				{
					Type elementType = typeFromHandle.GetElementType();
					if (!(bool)isReferenceOrContainsReferences.MakeGenericMethod(elementType).Invoke(null, null))
					{
						IsUnmanagedSZArray = true;
						UnmanagedSZArrayElementSize = Marshal.SizeOf(elementType);
					}
				}
			}
			catch
			{
				IsUnmanagedSZArray = false;
				IsFixedSizeMemoryPackable = false;
			}
		}
	}

	internal enum TypeKind : byte
	{
		None,
		UnmanagedSZArray,
		FixedSizeMemoryPackable
	}

	private static readonly MethodInfo isReferenceOrContainsReferences = typeof(RuntimeHelpers).GetMethod("IsReferenceOrContainsReferences");

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static bool IsReferenceOrNullable<T>()
	{
		return Cache<T>.IsReferenceOrNullable;
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static TypeKind TryGetUnmanagedSZArrayElementSizeOrMemoryPackableFixedSize<T>(out int size)
	{
		if (Cache<T>.IsUnmanagedSZArray)
		{
			size = Cache<T>.UnmanagedSZArrayElementSize;
			return TypeKind.UnmanagedSZArray;
		}
		if (Cache<T>.IsFixedSizeMemoryPackable)
		{
			size = Cache<T>.MemoryPackableFixedSize;
			return TypeKind.FixedSizeMemoryPackable;
		}
		size = 0;
		return TypeKind.None;
	}

	public static bool IsAnonymous(Type type)
	{
		if (type.Namespace == null && type.IsSealed && (type.Name.StartsWith("<>f__AnonymousType", StringComparison.Ordinal) || type.Name.StartsWith("<>__AnonType", StringComparison.Ordinal) || type.Name.StartsWith("VB$AnonymousType_", StringComparison.Ordinal)))
		{
			return type.IsDefined(typeof(CompilerGeneratedAttribute), inherit: false);
		}
		return false;
	}
}
