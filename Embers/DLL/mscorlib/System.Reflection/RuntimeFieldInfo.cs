using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class RuntimeFieldInfo : RtFieldInfo, ISerializable
{
	internal IntPtr klass;

	internal RuntimeFieldHandle fhandle;

	private string name;

	private Type type;

	private FieldAttributes attrs;

	internal BindingFlags BindingFlags => BindingFlags.Default;

	public override Module Module => GetRuntimeModule();

	private RuntimeType ReflectedTypeInternal => (RuntimeType)ReflectedType;

	public override FieldAttributes Attributes => attrs;

	public override RuntimeFieldHandle FieldHandle => fhandle;

	public override Type FieldType
	{
		get
		{
			if (type == null)
			{
				type = ResolveType();
			}
			return type;
		}
	}

	public override Type ReflectedType => GetParentType(declaring: false);

	public override Type DeclaringType => GetParentType(declaring: true);

	public override string Name => name;

	public override int MetadataToken => get_metadata_token(this);

	internal RuntimeType GetDeclaringTypeInternal()
	{
		return (RuntimeType)DeclaringType;
	}

	internal RuntimeModule GetRuntimeModule()
	{
		return GetDeclaringTypeInternal().GetRuntimeModule();
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		MemberInfoSerializationHolder.GetSerializationInfo(info, Name, ReflectedTypeInternal, ToString(), MemberTypes.Field);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal override extern object UnsafeGetValue(object obj);

	internal override void CheckConsistency(object target)
	{
		if ((Attributes & FieldAttributes.Static) != FieldAttributes.Static && !DeclaringType.IsInstanceOfType(target))
		{
			if (target == null)
			{
				throw new TargetException(Environment.GetResourceString("Non-static field requires a target."));
			}
			throw new ArgumentException(string.Format(CultureInfo.CurrentUICulture, Environment.GetResourceString("Field '{0}' defined on type '{1}' is not a field on the target object which is of type '{2}'."), Name, DeclaringType, target.GetType()));
		}
	}

	[DebuggerHidden]
	[DebuggerStepThrough]
	internal override void UnsafeSetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		bool domainInitialized = false;
		RuntimeFieldHandle.SetValue(this, obj, value, null, Attributes, null, ref domainInitialized);
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	public unsafe override void SetValueDirect(TypedReference obj, object value)
	{
		if (obj.IsNull)
		{
			throw new ArgumentException(Environment.GetResourceString("The TypedReference must be initialized."));
		}
		RuntimeFieldHandle.SetValueDirect(this, (RuntimeType)FieldType, &obj, value, (RuntimeType)DeclaringType);
	}

	[DebuggerHidden]
	[DebuggerStepThrough]
	public unsafe override object GetValueDirect(TypedReference obj)
	{
		if (obj.IsNull)
		{
			throw new ArgumentException(Environment.GetResourceString("The TypedReference must be initialized."));
		}
		return RuntimeFieldHandle.GetValueDirect(this, (RuntimeType)FieldType, &obj, (RuntimeType)DeclaringType);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type ResolveType();

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type GetParentType(bool declaring);

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(this, attributeType, inherit);
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, attributeType, inherit);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal override extern int GetFieldOffset();

	[MethodImpl((MethodImplOptions)4096)]
	private extern object GetValueInternal(object obj);

	public override object GetValue(object obj)
	{
		if (!base.IsStatic)
		{
			if (obj == null)
			{
				throw new TargetException("Non-static field requires a target");
			}
			if (!DeclaringType.IsAssignableFrom(obj.GetType()))
			{
				throw new ArgumentException($"Field {Name} defined on type {DeclaringType} is not a field on the target object which is of type {obj.GetType()}.", "obj");
			}
		}
		if (!base.IsLiteral)
		{
			CheckGeneric();
		}
		return GetValueInternal(obj);
	}

	public override string ToString()
	{
		return $"{FieldType} {name}";
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetValueInternal(FieldInfo fi, object obj, object value);

	public override void SetValue(object obj, object val, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		if (!base.IsStatic)
		{
			if (obj == null)
			{
				throw new TargetException("Non-static field requires a target");
			}
			if (!DeclaringType.IsAssignableFrom(obj.GetType()))
			{
				throw new ArgumentException($"Field {Name} defined on type {DeclaringType} is not a field on the target object which is of type {obj.GetType()}.", "obj");
			}
		}
		if (base.IsLiteral)
		{
			throw new FieldAccessException("Cannot set a constant field");
		}
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		CheckGeneric();
		if (val != null)
		{
			val = ((RuntimeType)FieldType).CheckValue(val, binder, culture, invokeAttr);
		}
		SetValueInternal(this, obj, val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public override extern object GetRawConstantValue();

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributes(this);
	}

	private void CheckGeneric()
	{
		if (DeclaringType.ContainsGenericParameters)
		{
			throw new InvalidOperationException("Late bound operations cannot be performed on fields with types for which Type.ContainsGenericParameters is true.");
		}
	}

	public sealed override bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		return HasSameMetadataDefinitionAsCore<RuntimeFieldInfo>(other);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int get_metadata_token(RuntimeFieldInfo monoField);

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type[] GetTypeModifiers(bool optional);

	public override Type[] GetOptionalCustomModifiers()
	{
		return GetCustomModifiers(optional: true);
	}

	public override Type[] GetRequiredCustomModifiers()
	{
		return GetCustomModifiers(optional: false);
	}

	private Type[] GetCustomModifiers(bool optional)
	{
		return GetTypeModifiers(optional) ?? Type.EmptyTypes;
	}
}
