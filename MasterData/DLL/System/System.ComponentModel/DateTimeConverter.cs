using System.ComponentModel.Design.Serialization;
using System.Globalization;

namespace System.ComponentModel;

public class DateTimeConverter : TypeConverter
{
	public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType)
	{
		if (!(sourceType == typeof(string)))
		{
			return base.CanConvertFrom(context, sourceType);
		}
		return true;
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
		if (value is string text)
		{
			string text2 = text.Trim();
			if (text2.Length == 0)
			{
				return DateTime.MinValue;
			}
			try
			{
				DateTimeFormatInfo dateTimeFormatInfo = null;
				if (culture != null)
				{
					dateTimeFormatInfo = (DateTimeFormatInfo)culture.GetFormat(typeof(DateTimeFormatInfo));
				}
				if (dateTimeFormatInfo != null)
				{
					return DateTime.Parse(text2, dateTimeFormatInfo);
				}
				return DateTime.Parse(text2, culture);
			}
			catch (FormatException innerException)
			{
				throw new FormatException(global::SR.Format("{0} is not a valid value for {1}.", (string)value, "DateTime"), innerException);
			}
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == typeof(string) && value is DateTime dateTime)
		{
			if (dateTime == DateTime.MinValue)
			{
				return string.Empty;
			}
			if (culture == null)
			{
				culture = CultureInfo.CurrentCulture;
			}
			DateTimeFormatInfo dateTimeFormatInfo = null;
			dateTimeFormatInfo = (DateTimeFormatInfo)culture.GetFormat(typeof(DateTimeFormatInfo));
			if (culture == CultureInfo.InvariantCulture)
			{
				if (dateTime.TimeOfDay.TotalSeconds == 0.0)
				{
					return dateTime.ToString("yyyy-MM-dd", culture);
				}
				return dateTime.ToString(culture);
			}
			string text = ((dateTime.TimeOfDay.TotalSeconds != 0.0) ? (dateTimeFormatInfo.ShortDatePattern + " " + dateTimeFormatInfo.ShortTimePattern) : dateTimeFormatInfo.ShortDatePattern);
			return dateTime.ToString(text, CultureInfo.CurrentCulture);
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}
}
