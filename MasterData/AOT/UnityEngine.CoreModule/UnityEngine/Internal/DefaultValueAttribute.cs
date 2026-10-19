using System;

namespace UnityEngine.Internal;

[Serializable]
[AttributeUsage(AttributeTargets.Parameter | AttributeTargets.GenericParameter)]
public class DefaultValueAttribute : Attribute
{
	private object DefaultValue;

	public object Value => DefaultValue;

	public DefaultValueAttribute(string value)
	{
		DefaultValue = value;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is DefaultValueAttribute defaultValueAttribute))
		{
			return false;
		}
		if (DefaultValue == null)
		{
			return defaultValueAttribute.Value == null;
		}
		return DefaultValue.Equals(defaultValueAttribute.Value);
	}

	public override int GetHashCode()
	{
		if (DefaultValue == null)
		{
			return base.GetHashCode();
		}
		return DefaultValue.GetHashCode();
	}
}
