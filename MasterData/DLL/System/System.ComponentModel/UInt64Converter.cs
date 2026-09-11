using System.Globalization;

namespace System.ComponentModel;

public class UInt64Converter : BaseNumberConverter
{
	internal override Type TargetType => typeof(ulong);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToUInt64(value, radix);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return ulong.Parse(value, NumberStyles.Integer, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((ulong)value).ToString("G", formatInfo);
	}
}
