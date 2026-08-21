using System;
using System.Globalization;
using System.Reflection;

namespace Sirenix.Utilities;

public sealed class MemberAliasFieldInfo : FieldInfo
{
	private const string FAKE_NAME_SEPARATOR_STRING = "+";

	private FieldInfo aliasedField;

	private string mangledName;

	public FieldInfo AliasedField => aliasedField;

	public override Module Module => aliasedField.Module;

	public override int MetadataToken => aliasedField.MetadataToken;

	public override string Name => mangledName;

	public override Type DeclaringType => aliasedField.DeclaringType;

	public override Type ReflectedType => aliasedField.ReflectedType;

	public override Type FieldType => aliasedField.FieldType;

	public override RuntimeFieldHandle FieldHandle => aliasedField.FieldHandle;

	public override FieldAttributes Attributes => aliasedField.Attributes;

	public MemberAliasFieldInfo(FieldInfo field, string namePrefix)
	{
		aliasedField = field;
		mangledName = namePrefix + "+" + aliasedField.Name;
	}

	public MemberAliasFieldInfo(FieldInfo field, string namePrefix, string separatorString)
	{
		aliasedField = field;
		mangledName = namePrefix + separatorString + aliasedField.Name;
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return aliasedField.GetCustomAttributes(inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return aliasedField.GetCustomAttributes(attributeType, inherit);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return aliasedField.IsDefined(attributeType, inherit);
	}

	public override object GetValue(object obj)
	{
		return aliasedField.GetValue(obj);
	}

	public override void SetValue(object obj, object value, BindingFlags invokeAttr, Binder binder, CultureInfo culture)
	{
		aliasedField.SetValue(obj, value, invokeAttr, binder, culture);
	}
}
