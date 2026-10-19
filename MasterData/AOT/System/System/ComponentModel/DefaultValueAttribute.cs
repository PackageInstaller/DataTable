using System.Globalization;
using System.Threading;

namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.All)]
public class DefaultValueAttribute : Attribute
{
	private object _value;

	private static object s_convertFromInvariantString;

	public virtual object Value => _value;

	public DefaultValueAttribute(Type type, string value)
	{
		try
		{
			if (TryConvertFromInvariantString(type, value, out var conversionResult))
			{
				_value = conversionResult;
			}
			else if (type.IsSubclassOf(typeof(Enum)))
			{
				_value = Enum.Parse(type, value, ignoreCase: true);
			}
			else if (type == typeof(TimeSpan))
			{
				_value = TimeSpan.Parse(value);
			}
			else
			{
				_value = Convert.ChangeType(value, type, CultureInfo.InvariantCulture);
			}
			static bool TryConvertFromInvariantString(Type typeToConvert, string stringValue, out object reference)
			{
				reference = null;
				if (s_convertFromInvariantString == null)
				{
					Type type2 = Type.GetType("System.ComponentModel.TypeDescriptor, System.ComponentModel.TypeConverter", throwOnError: false);
					Volatile.Write(ref s_convertFromInvariantString, (type2 == null) ? new object() : Delegate.CreateDelegate(typeof(Func<Type, string, object>), type2, "ConvertFromInvariantString", ignoreCase: false));
				}
				if (!(s_convertFromInvariantString is Func<Type, string, object> func))
				{
					return false;
				}
				reference = func(typeToConvert, stringValue);
				return true;
			}
		}
		catch
		{
		}
	}

	public DefaultValueAttribute(char value)
	{
		_value = value;
	}

	public DefaultValueAttribute(byte value)
	{
		_value = value;
	}

	public DefaultValueAttribute(short value)
	{
		_value = value;
	}

	public DefaultValueAttribute(int value)
	{
		_value = value;
	}

	public DefaultValueAttribute(long value)
	{
		_value = value;
	}

	public DefaultValueAttribute(float value)
	{
		_value = value;
	}

	public DefaultValueAttribute(double value)
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

	[CLSCompliant(false)]
	public DefaultValueAttribute(sbyte value)
	{
		_value = value;
	}

	[CLSCompliant(false)]
	public DefaultValueAttribute(ushort value)
	{
		_value = value;
	}

	[CLSCompliant(false)]
	public DefaultValueAttribute(uint value)
	{
		_value = value;
	}

	[CLSCompliant(false)]
	public DefaultValueAttribute(ulong value)
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

	protected void SetValue(object value)
	{
		_value = value;
	}
}
