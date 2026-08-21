using System.Globalization;
using System.Reflection;

namespace System.Runtime.Serialization;

internal sealed class SerializationFieldInfo : FieldInfo
{
	private RuntimeFieldInfo m_field;

	private string m_serializationName;

	public override Module Module => m_field.Module;

	public override int MetadataToken => m_field.MetadataToken;

	public override string Name => m_serializationName;

	public override Type DeclaringType => m_field.DeclaringType;

	public override Type ReflectedType => m_field.ReflectedType;

	public override Type FieldType => m_field.FieldType;

	internal RuntimeFieldInfo FieldInfo => m_field;

	public override RuntimeFieldHandle FieldHandle => m_field.FieldHandle;

	public override FieldAttributes Attributes => m_field.Attributes;

	internal SerializationFieldInfo(RuntimeFieldInfo field, string namePrefix)
	{
		m_field = field;
		m_serializationName = namePrefix + "+" + m_field.Name;
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return m_field.GetCustomAttributes(inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return m_field.GetCustomAttributes(attributeType, inherit);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return m_field.IsDefined(attributeType, inherit);
	}

	public override object GetValue(object obj)
	{
		return m_field.GetValue(obj);
	}

	internal object InternalGetValue(object obj)
	{
		RtFieldInfo field = m_field;
		if (field != null)
		{
			field.CheckConsistency(obj);
			return field.UnsafeGetValue(obj);
		}
		return m_field.GetValue(obj);
	}

	public override void SetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		m_field.SetValue(obj, value, invokeAttr, binder, culture);
	}

	internal void InternalSetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		RtFieldInfo field = m_field;
		if (field != null)
		{
			field.CheckConsistency(obj);
			field.UnsafeSetValue(obj, value, invokeAttr, binder, culture);
		}
		else
		{
			m_field.SetValue(obj, value, invokeAttr, binder, culture);
		}
	}
}
