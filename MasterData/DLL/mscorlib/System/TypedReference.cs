using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Versioning;

namespace System;

[ComVisible(true)]
[NonVersionable]
[CLSCompliant(false)]
public ref struct TypedReference
{
	private RuntimeTypeHandle type;

	private IntPtr Value;

	private IntPtr Type;

	internal bool IsNull
	{
		get
		{
			if (Value == IntPtr.Zero)
			{
				return Type == IntPtr.Zero;
			}
			return false;
		}
	}

	[CLSCompliant(false)]
	public unsafe static TypedReference MakeTypedReference(object target, FieldInfo[] flds)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		if (flds == null)
		{
			throw new ArgumentNullException("flds");
		}
		if (flds.Length == 0)
		{
			throw new ArgumentException(Environment.GetResourceString("Array must not be of length zero."), "flds");
		}
		IntPtr[] array = new IntPtr[flds.Length];
		RuntimeType runtimeType = (RuntimeType)target.GetType();
		for (int i = 0; i < flds.Length; i++)
		{
			RuntimeFieldInfo runtimeFieldInfo = flds[i] as RuntimeFieldInfo;
			if (runtimeFieldInfo == null)
			{
				throw new ArgumentException(Environment.GetResourceString("FieldInfo must be a runtime FieldInfo object."));
			}
			if (runtimeFieldInfo.IsStatic)
			{
				throw new ArgumentException(Environment.GetResourceString("Field in TypedReferences cannot be static or init only."));
			}
			if (runtimeType != runtimeFieldInfo.GetDeclaringTypeInternal() && !runtimeType.IsSubclassOf(runtimeFieldInfo.GetDeclaringTypeInternal()))
			{
				throw new MissingMemberException(Environment.GetResourceString("FieldInfo does not match the target Type."));
			}
			RuntimeType runtimeType2 = (RuntimeType)runtimeFieldInfo.FieldType;
			if (runtimeType2.IsPrimitive)
			{
				throw new ArgumentException(Environment.GetResourceString("TypedReferences cannot be redefined as primitives."));
			}
			if (i < flds.Length - 1 && !runtimeType2.IsValueType)
			{
				throw new MissingMemberException(Environment.GetResourceString("TypedReference can only be made on nested value Types."));
			}
			array[i] = runtimeFieldInfo.FieldHandle.Value;
			runtimeType = runtimeType2;
		}
		TypedReference result = default(TypedReference);
		InternalMakeTypedReference(&result, target, array, runtimeType);
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void InternalMakeTypedReference(void* result, object target, IntPtr[] flds, RuntimeType lastFieldType);

	public override int GetHashCode()
	{
		if (Type == IntPtr.Zero)
		{
			return 0;
		}
		return __reftype(this).GetHashCode();
	}

	public override bool Equals(object o)
	{
		throw new NotSupportedException(Environment.GetResourceString("This feature is not currently implemented."));
	}

	public unsafe static object ToObject(TypedReference value)
	{
		return InternalToObject(&value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern object InternalToObject(void* value);

	[CLSCompliant(false)]
	public static void SetTypedReference(TypedReference target, object value)
	{
		throw new NotImplementedException("SetTypedReference");
	}
}
