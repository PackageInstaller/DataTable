using System.ComponentModel;
using System.Globalization;

namespace System;

public class UriTypeConverter : TypeConverter
{
	private bool CanConvert(Type type)
	{
		if (type == typeof(string))
		{
			return true;
		}
		if (type == typeof(Uri))
		{
			return true;
		}
		return false;
	}

	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (sourceType == null)
		{
			throw new ArgumentNullException("sourceType");
		}
		return CanConvert(sourceType);
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (destinationType == null)
		{
			return false;
		}
		return CanConvert(destinationType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value == null)
		{
			throw new NotSupportedException(Locale.GetText("Cannot convert from value."));
		}
		if (!CanConvertFrom(context, value.GetType()))
		{
			throw new NotSupportedException(Locale.GetText("Cannot convert from value."));
		}
		if (value is Uri)
		{
			return value;
		}
		if (value is string text)
		{
			if (text == "")
			{
				return null;
			}
			return new Uri(text, UriKind.RelativeOrAbsolute);
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (!CanConvertTo(context, destinationType))
		{
			throw new NotSupportedException(Locale.GetText("Cannot convert to destination type."));
		}
		Uri uri = value as Uri;
		if (uri != null)
		{
			if (destinationType == typeof(string))
			{
				return uri.ToString();
			}
			if (destinationType == typeof(Uri))
			{
				return uri;
			}
			throw new NotSupportedException(Locale.GetText("Cannot convert to destination type."));
		}
		throw new NotSupportedException(Locale.GetText("Cannot convert to destination type."));
	}
}
