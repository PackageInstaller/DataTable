using System.Globalization;

namespace System.ComponentModel;

public abstract class BaseNumberConverter : TypeConverter
{
	internal virtual bool AllowHex => true;

	internal abstract Type TargetType { get; }

	internal BaseNumberConverter()
	{
	}

	internal abstract object FromString(string value, int radix);

	internal abstract object FromString(string value, NumberFormatInfo formatInfo);

	internal abstract string ToString(object value, NumberFormatInfo formatInfo);

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
			string text2 = text.Trim();
			try
			{
				if (AllowHex && text2[0] == '#')
				{
					return FromString(text2.Substring(1), 16);
				}
				if ((AllowHex && text2.StartsWith("0x", StringComparison.OrdinalIgnoreCase)) || text2.StartsWith("&h", StringComparison.OrdinalIgnoreCase))
				{
					return FromString(text2.Substring(2), 16);
				}
				if (culture == null)
				{
					culture = CultureInfo.CurrentCulture;
				}
				NumberFormatInfo formatInfo = (NumberFormatInfo)culture.GetFormat(typeof(NumberFormatInfo));
				return FromString(text2, formatInfo);
			}
			catch (Exception innerException)
			{
				throw new ArgumentException(global::SR.Format("{0} is not a valid value for {1}.", text2, TargetType.Name), "value", innerException);
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
		if (destinationType == typeof(string) && value != null && TargetType.IsInstanceOfType(value))
		{
			if (culture == null)
			{
				culture = CultureInfo.CurrentCulture;
			}
			NumberFormatInfo numberFormatInfo = (NumberFormatInfo)culture.GetFormat(typeof(NumberFormatInfo));
			return ToString(value, numberFormatInfo);
		}
		if (destinationType.IsPrimitive)
		{
			return Convert.ChangeType(value, destinationType, culture);
		}
		return base.ConvertTo(context, culture, value, destinationType);
	}

	public override bool CanConvertTo(ITypeDescriptorContext context, Type destinationType)
	{
		if (!base.CanConvertTo(context, destinationType))
		{
			return destinationType.IsPrimitive;
		}
		return true;
	}
}
