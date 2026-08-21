using System.Globalization;

namespace System.ComponentModel;

public class UInt16Converter : BaseNumberConverter
{
	internal override Type TargetType => typeof(ushort);

	internal override object FromString(string value, int radix)
	{
		return Convert.ToUInt16(value, radix);
	}

	internal override object FromString(string value, NumberFormatInfo formatInfo)
	{
		return ushort.Parse(value, NumberStyles.Integer, formatInfo);
	}

	internal override string ToString(object value, NumberFormatInfo formatInfo)
	{
		return ((ushort)value).ToString("G", formatInfo);
	}
}
