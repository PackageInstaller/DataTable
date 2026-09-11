using System.Globalization;

namespace System.ComponentModel;

public class Int64Converter : BaseNumberConverter
{
	internal override Type TargetType => typeof(long);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToInt64(value, radix);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return long.Parse(value, NumberStyles.Integer, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((long)value).ToString("G", formatInfo);
	}
}
