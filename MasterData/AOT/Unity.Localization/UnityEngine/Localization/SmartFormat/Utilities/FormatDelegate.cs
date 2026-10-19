using System;

namespace UnityEngine.Localization.SmartFormat.Utilities;

public class FormatDelegate : IFormattable
{
	private readonly Func<string, string> getFormat1;

	private readonly Func<string, IFormatProvider, string> getFormat2;

	public FormatDelegate(Func<string, string> getFormat)
	{
		getFormat1 = getFormat;
	}

	public FormatDelegate(Func<string, IFormatProvider, string> getFormat)
	{
		getFormat2 = getFormat;
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (getFormat1 == null)
		{
			return getFormat2(format, formatProvider);
		}
		return getFormat1(format);
	}
}
