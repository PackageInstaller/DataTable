using System.Globalization;
using Internal.Runtime.Augments;

namespace System.Reflection;

public struct CustomAttributeNamedArgument
{
	private readonly Type _attributeType;

	private volatile MemberInfo _lazyMemberInfo;

	public CustomAttributeTypedArgument TypedValue { get; }

	public bool IsField { get; }

	public string MemberName { get; }

	public MemberInfo MemberInfo
	{
		get
		{
			MemberInfo memberInfo = _lazyMemberInfo;
			if (memberInfo == null)
			{
				memberInfo = ((!IsField) ? ((MemberInfo)_attributeType.GetProperty(MemberName, BindingFlags.Instance | BindingFlags.Public)) : ((MemberInfo)_attributeType.GetField(MemberName, BindingFlags.Instance | BindingFlags.Public)));
				if (memberInfo == null)
				{
					throw RuntimeAugments.Callbacks.CreateMissingMetadataException(_attributeType);
				}
				_lazyMemberInfo = memberInfo;
			}
			return memberInfo;
		}
	}

	internal CustomAttributeNamedArgument(Type attributeType, string memberName, bool isField, CustomAttributeTypedArgument typedValue)
	{
		IsField = isField;
		MemberName = memberName;
		TypedValue = typedValue;
		_attributeType = attributeType;
		_lazyMemberInfo = null;
	}

	public CustomAttributeNamedArgument(MemberInfo memberInfo, object value)
	{
		if (memberInfo == null)
		{
			throw new ArgumentNullException("memberInfo");
		}
		Type type = null;
		FieldInfo fieldInfo = memberInfo as FieldInfo;
		PropertyInfo propertyInfo = memberInfo as PropertyInfo;
		if (fieldInfo != null)
		{
			type = fieldInfo.FieldType;
		}
		else
		{
			if (!(propertyInfo != null))
			{
				throw new ArgumentException("The member must be either a field or a property.");
			}
			type = propertyInfo.PropertyType;
		}
		_lazyMemberInfo = memberInfo;
		_attributeType = memberInfo.DeclaringType;
		if (value is CustomAttributeTypedArgument customAttributeTypedArgument)
		{
			TypedValue = customAttributeTypedArgument;
		}
		else
		{
			TypedValue = new CustomAttributeTypedArgument(type, value);
		}
		IsField = fieldInfo != null;
		MemberName = memberInfo.Name;
	}

	public CustomAttributeNamedArgument(MemberInfo memberInfo, CustomAttributeTypedArgument typedArgument)
	{
		if (memberInfo == null)
		{
			throw new ArgumentNullException("memberInfo");
		}
		_lazyMemberInfo = memberInfo;
		_attributeType = memberInfo.DeclaringType;
		TypedValue = typedArgument;
		IsField = memberInfo is FieldInfo;
		MemberName = memberInfo.Name;
	}

	public override bool Equals(object obj)
	{
		return obj == (object)this;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(CustomAttributeNamedArgument left, CustomAttributeNamedArgument right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CustomAttributeNamedArgument left, CustomAttributeNamedArgument right)
	{
		return !left.Equals(right);
	}

	public override string ToString()
	{
		if (_attributeType == null)
		{
			return base.ToString();
		}
		try
		{
			bool flag = _lazyMemberInfo == null || (IsField ? ((FieldInfo)_lazyMemberInfo).FieldType : ((PropertyInfo)_lazyMemberInfo).PropertyType) != typeof(object);
			return string.Format(CultureInfo.CurrentCulture, "{0} = {1}", MemberName, TypedValue.ToString(flag));
		}
		catch (MissingMetadataException)
		{
			return base.ToString();
		}
	}
}
