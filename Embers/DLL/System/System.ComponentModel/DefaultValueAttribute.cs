namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public class DefaultValueAttribute : Attribute
{
	private object _value;

	public virtual object Value => _value;

	public DefaultValueAttribute(int value)
	{
		_value = value;
	}

	public DefaultValueAttribute(long value)
	{
		_value = value;
	}

	public DefaultValueAttribute(bool value)
	{
		_value = value;
	}

	public DefaultValueAttribute(string value)
	{
		_value = value;
	}

	public DefaultValueAttribute(object value)
	{
		_value = value;
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is DefaultValueAttribute defaultValueAttribute)
		{
			if (Value != null)
			{
				return Value.Equals(defaultValueAttribute.Value);
			}
			return defaultValueAttribute.Value == null;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
