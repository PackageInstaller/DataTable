using System.Globalization;

namespace System.ComponentModel;

public class CharConverter : TypeConverter
{
	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (!(sourceType == typeof(string)))
		{
			return base.CanConvertFrom(context, sourceType);
		}
		return true;
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == typeof(string) && value is char && (char)value == '\0')
		{
			return "";
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
	{
		string text = value as string;
		if (text != null)
		{
			if (text.Length > 1)
			{
				text = text.Trim();
			}
			if (text.Length > 0)
			{
				if (text.Length != 1)
				{
					throw new FormatException(global::SR.Format("{0} is not a valid value for {1}.", text, "Char"));
				}
				return text[0];
			}
			return '\0';
		}
		return base.ConvertFrom(context, culture, value);
	}
}
