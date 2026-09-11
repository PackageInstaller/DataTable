using System.ComponentModel.Design.Serialization;
using System.Globalization;
using System.Reflection;

namespace System.ComponentModel;

public class DateTimeOffsetConverter : TypeConverter
{
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
			string text = ((string)value).Trim();
			if (text.Length == 0)
			{
				return DateTimeOffset.MinValue;
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
					return DateTimeOffset.Parse(text, dateTimeFormatInfo);
				}
				return DateTimeOffset.Parse(text, culture);
			}
			catch (FormatException innerException)
			{
				throw new FormatException(global::SR.GetString("{0} is not a valid value for {1}.", (string)value, "DateTimeOffset"), innerException);
			}
		}
		return base.ConvertFrom(context, culture, value);
	}

	public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
	{
		if (destinationType == typeof(string) && value is DateTimeOffset dateTimeOffset)
		{
			if (dateTimeOffset == DateTimeOffset.MinValue)
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
				if (dateTimeOffset.TimeOfDay.TotalSeconds == 0.0)
				{
					return dateTimeOffset.ToString("yyyy-MM-dd zzz", culture);
				}
				return dateTimeOffset.ToString(culture);
			}
			string text = ((dateTimeOffset.TimeOfDay.TotalSeconds != 0.0) ? (dateTimeFormatInfo.ShortDatePattern + " " + dateTimeFormatInfo.ShortTimePattern + " zzz") : (dateTimeFormatInfo.ShortDatePattern + " zzz"));
			return dateTimeOffset.ToString(text, CultureInfo.CurrentCulture);
		}
		if (destinationType == typeof(InstanceDescriptor) && value is DateTimeOffset dateTimeOffset2)
		{
			if (dateTimeOffset2.Ticks == 0L)
			{
				ConstructorInfo constructor = typeof(DateTimeOffset).GetConstructor(new Type[1] { typeof(long) });
				if (constructor != null)
				{
					return new InstanceDescriptor(constructor, new object[1] { dateTimeOffset2.Ticks });
				}
			}
			ConstructorInfo constructor2 = typeof(DateTimeOffset).GetConstructor(new Type[8]
			{
				typeof(int),
				typeof(int),
				typeof(int),
				typeof(int),
				typeof(int),
				typeof(int),
				typeof(int),
				typeof(TimeSpan)
			});
			if (constructor2 != null)
			{
				return new InstanceDescriptor(constructor2, new object[8] { dateTimeOffset2.Year, dateTimeOffset2.Month, dateTimeOffset2.Day, dateTimeOffset2.Hour, dateTimeOffset2.Minute, dateTimeOffset2.Second, dateTimeOffset2.Millisecond, dateTimeOffset2.Offset });
			}
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}
}
