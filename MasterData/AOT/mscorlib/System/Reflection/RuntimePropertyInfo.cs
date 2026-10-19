using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security;
using System.Text;
using Mono;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class RuntimePropertyInfo : PropertyInfo, ISerializable
{
	private delegate object GetterAdapter(object _this);

	private delegate R Getter<T, R>(T _this);

	private delegate R StaticGetter<R>();

	internal IntPtr klass;

	internal IntPtr prop;

	private MonoPropertyInfo info;

	private PInfo cached;

	private GetterAdapter cached_getter;

	internal BindingFlags BindingFlags => BindingFlags.Default;

	public override Module Module => GetRuntimeModule();

	private RuntimeType ReflectedTypeInternal => (RuntimeType)ReflectedType;

	public override PropertyAttributes Attributes
	{
		get
		{
			CachePropertyInfo(PInfo.Attributes);
			return info.attrs;
		}
	}

	public override bool CanRead
	{
		get
		{
			CachePropertyInfo(PInfo.GetMethod);
			return info.get_method != null;
		}
	}

	public override bool CanWrite
	{
		get
		{
			CachePropertyInfo(PInfo.SetMethod);
			return info.set_method != null;
		}
	}

	public override Type PropertyType
	{
		get
		{
			CachePropertyInfo(PInfo.GetMethod | PInfo.SetMethod);
			if (info.get_method != null)
			{
				return info.get_method.ReturnType;
			}
			ParameterInfo[] parametersInternal = info.set_method.GetParametersInternal();
			return parametersInternal[parametersInternal.Length - 1].ParameterType;
		}
	}

	public override Type ReflectedType
	{
		get
		{
			CachePropertyInfo(PInfo.ReflectedType);
			return info.parent;
		}
	}

	public override Type DeclaringType
	{
		get
		{
			CachePropertyInfo(PInfo.DeclaringType);
			return info.declaring_type;
		}
	}

	public override string Name
	{
		get
		{
			CachePropertyInfo(PInfo.Name);
			return info.name;
		}
	}

	public override int MetadataToken => get_metadata_token(this);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void get_property_info(RuntimePropertyInfo prop, ref MonoPropertyInfo info, PInfo req_info);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Type[] GetTypeModifiers(RuntimePropertyInfo prop, bool optional);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern object get_default_value(RuntimePropertyInfo prop);

	internal RuntimeType GetDeclaringTypeInternal()
	{
		return (RuntimeType)DeclaringType;
	}

	internal RuntimeModule GetRuntimeModule()
	{
		return GetDeclaringTypeInternal().GetRuntimeModule();
	}

	public override string ToString()
	{
		return FormatNameAndSig(serialization: false);
	}

	private string FormatNameAndSig(bool serialization)
	{
		StringBuilder stringBuilder = new StringBuilder(PropertyType.FormatTypeName(serialization));
		stringBuilder.Append(" ");
		stringBuilder.Append(Name);
		ParameterInfo[] indexParameters = GetIndexParameters();
		if (indexParameters.Length != 0)
		{
			stringBuilder.Append(" [");
			RuntimeParameterInfo.FormatParameters(stringBuilder, indexParameters, (CallingConventions)0, serialization);
			stringBuilder.Append("]");
		}
		return stringBuilder.ToString();
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		MemberInfoSerializationHolder.GetSerializationInfo(info, Name, ReflectedTypeInternal, ToString(), SerializationToString(), MemberTypes.Property, null);
	}

	internal string SerializationToString()
	{
		return FormatNameAndSig(serialization: true);
	}

	private void CachePropertyInfo(PInfo flags)
	{
		if ((cached & flags) != flags)
		{
			get_property_info(this, ref info, flags);
			cached |= flags;
		}
	}

	public override MethodInfo[] GetAccessors(bool nonPublic)
	{
		int num = 0;
		int num2 = 0;
		CachePropertyInfo(PInfo.GetMethod | PInfo.SetMethod);
		if (info.set_method != null && (nonPublic || info.set_method.IsPublic))
		{
			num2 = 1;
		}
		if (info.get_method != null && (nonPublic || info.get_method.IsPublic))
		{
			num = 1;
		}
		MethodInfo[] array = new MethodInfo[num + num2];
		int num3 = 0;
		if (num2 != 0)
		{
			array[num3++] = info.set_method;
		}
		if (num != 0)
		{
			array[num3++] = info.get_method;
		}
		return array;
	}

	public override MethodInfo GetGetMethod(bool nonPublic)
	{
		CachePropertyInfo(PInfo.GetMethod);
		if (info.get_method != null && (nonPublic || info.get_method.IsPublic))
		{
			return info.get_method;
		}
		return null;
	}

	public override ParameterInfo[] GetIndexParameters()
	{
		CachePropertyInfo(PInfo.GetMethod | PInfo.SetMethod);
		ParameterInfo[] parametersInternal;
		int num;
		if (info.get_method != null)
		{
			parametersInternal = info.get_method.GetParametersInternal();
			num = parametersInternal.Length;
		}
		else
		{
			if (!(info.set_method != null))
			{
				return EmptyArray<ParameterInfo>.Value;
			}
			parametersInternal = info.set_method.GetParametersInternal();
			num = parametersInternal.Length - 1;
		}
		ParameterInfo[] array = new ParameterInfo[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = RuntimeParameterInfo.New(parametersInternal[i], this);
		}
		return array;
	}

	public override MethodInfo GetSetMethod(bool nonPublic)
	{
		CachePropertyInfo(PInfo.SetMethod);
		if (info.set_method != null && (nonPublic || info.set_method.IsPublic))
		{
			return info.set_method;
		}
		return null;
	}

	public override object GetConstantValue()
	{
		return get_default_value(this);
	}

	public override object GetRawConstantValue()
	{
		return get_default_value(this);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(this, attributeType, inherit: false);
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, inherit: false);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, attributeType, inherit: false);
	}

	private static object GetterAdapterFrame<T, R>(Getter<T, R> getter, object obj)
	{
		return getter((T)obj);
	}

	private static object StaticGetterAdapterFrame<R>(StaticGetter<R> getter, object obj)
	{
		return getter();
	}

	public override object GetValue(object obj, object[] index)
	{
		_ = index?.LongLength;
		return GetValue(obj, BindingFlags.Default, null, index, null);
	}

	public override object GetValue(object obj, BindingFlags invokeAttr, Binder binder, object[] index, CultureInfo culture)
	{
		object obj2 = null;
		MethodInfo getMethod = GetGetMethod(nonPublic: true);
		if (getMethod == null)
		{
			throw new ArgumentException("Get Method not found for '" + Name + "'");
		}
		try
		{
			if (index == null || index.Length == 0)
			{
				return getMethod.Invoke(obj, invokeAttr, binder, null, culture);
			}
			return getMethod.Invoke(obj, invokeAttr, binder, index, culture);
		}
		catch (SecurityException inner)
		{
			throw new TargetInvocationException(inner);
		}
	}

	public override void SetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, object[] index, CultureInfo culture)
	{
		MethodInfo setMethod = GetSetMethod(nonPublic: true);
		if (setMethod == null)
		{
			throw new ArgumentException("Set Method not found for '" + Name + "'");
		}
		object[] array;
		if (index == null || index.Length == 0)
		{
			array = new object[1] { value };
		}
		else
		{
			int num = index.Length;
			array = new object[num + 1];
			index.CopyTo(array, 0);
			array[num] = value;
		}
		setMethod.Invoke(obj, invokeAttr, binder, array, culture);
	}

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
		return GetTypeModifiers(this, optional) ?? Type.EmptyTypes;
	}

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributes(this);
	}

	public sealed override bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		return HasSameMetadataDefinitionAsCore<RuntimePropertyInfo>(other);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int get_metadata_token(RuntimePropertyInfo monoProperty);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern PropertyInfo internal_from_handle_type(IntPtr event_handle, IntPtr type_handle);

	internal static PropertyInfo GetPropertyFromHandle(RuntimePropertyHandle handle, RuntimeTypeHandle reflectedType)
	{
		if (handle.Value == IntPtr.Zero)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		PropertyInfo propertyInfo = internal_from_handle_type(handle.Value, reflectedType.Value);
		if (propertyInfo == null)
		{
			throw new ArgumentException("The property handle and the type handle are incompatible.");
		}
		return propertyInfo;
	}
}
