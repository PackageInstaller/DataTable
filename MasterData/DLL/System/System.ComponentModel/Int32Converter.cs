using System.Globalization;

namespace System.ComponentModel;

public class Int32Converter : BaseNumberConverter
{
	internal override Type TargetType => typeof(int);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToInt32(value, radix);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return int.Parse(value, NumberStyles.Integer, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((int)value).ToString("G", formatInfo);
	}
}
