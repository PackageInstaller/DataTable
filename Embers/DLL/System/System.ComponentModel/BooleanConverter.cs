using System.Globalization;

namespace System.ComponentModel;

public class BooleanConverter : TypeConverter
{
	private static volatile StandardValuesCollection s_values;

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
		if (value is string text)
		{
			string value2 = text.Trim();
			try
			{
				return bool.Parse(value2);
			}
			catch (FormatException innerException)
			{
				throw new FormatException(global::SR.Format("{0} is not a valid value for {1}.", (string)value, "Boolean"), innerException);
			}
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
	{
		return s_values ?? (s_values = new StandardValuesCollection(new object[2] { true, false }));
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
