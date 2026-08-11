using System.ComponentModel.Design.Serialization;
using System.Globalization;

namespace System.ComponentModel;

public abstract class TypeListConverter : TypeConverter
{
	private readonly Type[] _types;

	private StandardValuesCollection _values;

	protected TypeListConverter(Type[] types)
	{
		_types = types;
	}

	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == typeof(string))
		{
			return true;
		}
		return base.CanConvertFrom(context, sourceType);
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == typeof(InstanceDescriptor))
		{
			return true;
		}
		return base.CanConvertTo(context, destinationType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is string)
		{
			Type[] types = _types;
			foreach (Type type in types)
			{
				if (value.Equals(type.FullName))
				{
					return type;
				}
			}
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == typeof(string))
		{
			if (value == null)
			{
				return "(none)";
			}
			return ((Type)value).FullName;
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		if (_values == null)
		{
			object[] array;
			if (_types != null)
			{
				array = new object[_types.Length];
				Array.Copy(_types, array, _types.Length);
			}
			else
			{
				array = null;
			}
			_values = new StandardValuesCollection(array);
		}
		return _values;
	}

	public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
	{
		return true;
	}

	public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		return true;
	}
}
