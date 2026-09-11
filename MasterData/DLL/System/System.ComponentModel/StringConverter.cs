using System.Globalization;

namespace System.ComponentModel;

public class StringConverter : TypeConverter
{
	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (!(sourceType == typeof(string)))
		{
			return base.CanConvertFrom(context, sourceType);
		}
		return true;
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		if (value is string)
		{
			return (string)value;
		}
		if (value == null)
		{
			return string.Empty;
		}
		return base.ConvertFrom(context, culture, value);
	}
}
