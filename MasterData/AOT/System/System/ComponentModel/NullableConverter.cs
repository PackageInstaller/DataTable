using System.Collections;
using System.Globalization;

namespace System.ComponentModel;

public class NullableConverter : TypeConverter
{
	public Type NullableType { get; }

	public Type UnderlyingType { get; }

	public TypeConverter UnderlyingTypeConverter { get; }

	public NullableConverter(Type type)
	{
		NullableType = type;
		UnderlyingType = Nullable.GetUnderlyingType(type);
		if (UnderlyingType == null)
		{
			throw new ArgumentException("The specified type is not a nullable type.", "type");
		}
		UnderlyingTypeConverter = TypeDescriptor.GetConverter(UnderlyingType);
	}

	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == UnderlyingType)
		{
			return true;
		}
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.CanConvertFrom(context, sourceType);
		}
		return base.CanConvertFrom(context, sourceType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value == null || value.GetType() == UnderlyingType)
		{
			return value;
		}
		if (value is string && string.IsNullOrEmpty(value as string))
		{
			return null;
		}
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.ConvertFrom(context, culture, value);
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == UnderlyingType)
		{
			return true;
		}
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.CanConvertTo(context, destinationType);
		}
		return base.CanConvertTo(context, destinationType);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == null)
		{
			throw new ArgumentNullException("destinationType");
		}
		if (destinationType == UnderlyingType && value != null && NullableType.IsInstanceOfType(value))
		{
			return value;
		}
		if (value == null)
		{
			if (destinationType == typeof(string))
			{
				return string.Empty;
			}
		}
		else if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.ConvertTo(context, culture, value, destinationType);
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override object CreateInstance(ITypeDescriptorContext context, IDictionary propertyValues)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.CreateInstance(context, propertyValues);
		}
		return base.CreateInstance(context, propertyValues);
	}

	public override bool GetCreateInstanceSupported(ITypeDescriptorContext context)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.GetCreateInstanceSupported(context);
		}
		return base.GetCreateInstanceSupported(context);
	}

	public override PropertyDescriptorCollection GetProperties(ITypeDescriptorContext context, object value, Attribute[] attributes)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.GetProperties(context, value, attributes);
		}
		return base.GetProperties(context, value, attributes);
	}

	public override bool GetPropertiesSupported(ITypeDescriptorContext context)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.GetPropertiesSupported(context);
		}
		return base.GetPropertiesSupported(context);
	}

	public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		if (UnderlyingTypeConverter != null)
		{
			StandardValuesCollection standardValues = UnderlyingTypeConverter.GetStandardValues(context);
			if (GetStandardValuesSupported(context) && standardValues != null)
			{
				object[] array = new object[standardValues.Count + 1];
				int num = 0;
				array[num++] = null;
				foreach (object item in standardValues)
				{
					array[num++] = item;
				}
				return new StandardValuesCollection(array);
			}
		}
		return base.GetStandardValues(context);
	}

	public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.GetStandardValuesExclusive(context);
		}
		return base.GetStandardValuesExclusive(context);
	}

	public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
	{
		if (UnderlyingTypeConverter != null)
		{
			return UnderlyingTypeConverter.GetStandardValuesSupported(context);
		}
		return base.GetStandardValuesSupported(context);
	}

	public override bool IsValid(ITypeDescriptorContext context, object value)
	{
		if (UnderlyingTypeConverter != null)
		{
			if (value == null)
			{
				return true;
			}
			return UnderlyingTypeConverter.IsValid(context, value);
		}
		return base.IsValid(context, value);
	}
}
