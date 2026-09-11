using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class FieldInfo : MemberInfo, _FieldInfo
{
	public override MemberTypes MemberType => MemberTypes.Field;

	public abstract FieldAttributes Attributes { get; }

	public abstract Type FieldType { get; }

	public bool IsInitOnly => (Attributes & FieldAttributes.InitOnly) != 0;

	public bool IsLiteral => (Attributes & FieldAttributes.Literal) != 0;

	public bool IsNotSerialized => (Attributes & FieldAttributes.NotSerialized) != 0;

	public bool IsPinvokeImpl => (Attributes & FieldAttributes.PinvokeImpl) != 0;

	public bool IsSpecialName => (Attributes & FieldAttributes.SpecialName) != 0;

	public bool IsStatic => (Attributes & FieldAttributes.Static) != 0;

	public bool IsAssembly => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.Assembly;

	public bool IsFamily => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.Family;

	public bool IsFamilyAndAssembly => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.FamANDAssem;

	public bool IsFamilyOrAssembly => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.FamORAssem;

	public bool IsPrivate => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.Private;

	public bool IsPublic => (Attributes & FieldAttributes.FieldAccessMask) == FieldAttributes.Public;

	public virtual bool IsSecurityCritical => true;

	public virtual bool IsSecuritySafeCritical => false;

	public virtual bool IsSecurityTransparent => false;

	public abstract RuntimeFieldHandle FieldHandle { get; }

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(FieldInfo left, FieldInfo right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if ((object)left == null || (object)right == null)
		{
			return false;
		}
		return left.Equals(right);
	}

	public static bool operator !=(FieldInfo left, FieldInfo right)
	{
		return !(left == right);
	}

	public abstract object GetValue(object obj);

	[DebuggerHidden]
	[DebuggerStepThrough]
	public void SetValue(object obj, object value)
	{
		SetValue(obj, value, BindingFlags.Default, Type.DefaultBinder, null);
	}

	public abstract void SetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture);

	[CLSCompliant(false)]
	public virtual void SetValueDirect(TypedReference obj, object value)
	{
		throw new NotSupportedException("This non-CLS method is not implemented.");
	}

	[CLSCompliant(false)]
	public virtual object GetValueDirect(TypedReference obj)
	{
		throw new NotSupportedException("This non-CLS method is not implemented.");
	}

	public virtual object GetRawConstantValue()
	{
		throw new NotSupportedException("This non-CLS method is not implemented.");
	}

	public virtual Type[] GetOptionalCustomModifiers()
	{
		throw NotImplemented.ByDesign;
	}

	public virtual Type[] GetRequiredCustomModifiers()
	{
		throw NotImplemented.ByDesign;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern FieldInfo internal_from_handle_type(IntPtr field_handle, IntPtr type_handle);

	public static FieldInfo GetFieldFromHandle(RuntimeFieldHandle handle)
	{
		if (handle.Value == IntPtr.Zero)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		return internal_from_handle_type(handle.Value, IntPtr.Zero);
	}

	[ComVisible(false)]
	public static FieldInfo GetFieldFromHandle(RuntimeFieldHandle handle, RuntimeTypeHandle declaringType)
	{
		if (handle.Value == IntPtr.Zero)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		FieldInfo fieldInfo = internal_from_handle_type(handle.Value, declaringType.Value);
		if (fieldInfo == null)
		{
			throw new ArgumentException("The field handle and the type handle are incompatible.");
		}
		return fieldInfo;
	}

	internal virtual int GetFieldOffset()
	{
		throw new SystemException("This method should not be called");
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern MarshalAsAttribute get_marshal_info();

	internal object[] GetPseudoCustomAttributes()
	{
		int num = 0;
		if (IsNotSerialized)
		{
			num++;
		}
		if (DeclaringType.IsExplicitLayout)
		{
			num++;
		}
		MarshalAsAttribute marshal_info = get_marshal_info();
		if (marshal_info != null)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		object[] array = new object[num];
		num = 0;
		if (IsNotSerialized)
		{
			array[num++] = new NonSerializedAttribute();
		}
		if (DeclaringType.IsExplicitLayout)
		{
			array[num++] = new FieldOffsetAttribute(GetFieldOffset());
		}
		if (marshal_info != null)
		{
			array[num++] = marshal_info;
		}
		return array;
	}

	internal CustomAttributeData[] GetPseudoCustomAttributesData()
	{
		int num = 0;
		if (IsNotSerialized)
		{
			num++;
		}
		if (DeclaringType.IsExplicitLayout)
		{
			num++;
		}
		MarshalAsAttribute marshal_info = get_marshal_info();
		if (marshal_info != null)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		CustomAttributeData[] array = new CustomAttributeData[num];
		num = 0;
		if (IsNotSerialized)
		{
			array[num++] = new CustomAttributeData(typeof(NonSerializedAttribute).GetConstructor(Type.EmptyTypes));
		}
		if (DeclaringType.IsExplicitLayout)
		{
			CustomAttributeTypedArgument[] ctorArgs = new CustomAttributeTypedArgument[1]
			{
				new CustomAttributeTypedArgument(typeof(int), GetFieldOffset())
			};
			array[num++] = new CustomAttributeData(typeof(FieldOffsetAttribute).GetConstructor(new Type[1] { typeof(int) }), ctorArgs, EmptyArray<CustomAttributeNamedArgument>.Value);
		}
		if (marshal_info != null)
		{
			CustomAttributeTypedArgument[] ctorArgs2 = new CustomAttributeTypedArgument[1]
			{
				new CustomAttributeTypedArgument(typeof(UnmanagedType), marshal_info.Value)
			};
			array[num++] = new CustomAttributeData(typeof(MarshalAsAttribute).GetConstructor(new Type[1] { typeof(UnmanagedType) }), ctorArgs2, EmptyArray<CustomAttributeNamedArgument>.Value);
		}
		return array;
	}

	void _FieldInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _FieldInfo.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _FieldInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _FieldInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _FieldInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
