using System.Globalization;

namespace System.ComponentModel;

public class UInt32Converter : BaseNumberConverter
{
	internal override Type TargetType => typeof(uint);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToUInt32(value, radix);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return uint.Parse(value, NumberStyles.Integer, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((uint)value).ToString("G", formatInfo);
	}
}
