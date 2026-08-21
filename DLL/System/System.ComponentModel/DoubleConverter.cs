using System.Globalization;

namespace System.ComponentModel;

public class DoubleConverter : BaseNumberConverter
{
	internal override bool AllowHex => false;

	internal override Type TargetType => typeof(double);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToDouble(value, CultureInfo.CurrentCulture);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return double.Parse(value, NumberStyles.Float, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((double)value).ToString("R", formatInfo);
	}
}
