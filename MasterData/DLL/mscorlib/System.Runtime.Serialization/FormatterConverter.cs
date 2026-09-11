using System.Globalization;
using System.Runtime.CompilerServices;

namespace System.Runtime.Serialization;

public class FormatterConverter : IFormatterConverter
{
	public object Convert(object value, Type type)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ChangeType(value, type, CultureInfo.InvariantCulture);
	}

	public bool ToBoolean(object value)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ToBoolean(value, CultureInfo.InvariantCulture);
	}

	public int ToInt32(object value)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ToInt32(value, CultureInfo.InvariantCulture);
	}

	public long ToInt64(object value)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ToInt64(value, CultureInfo.InvariantCulture);
	}

	public float ToSingle(object value)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ToSingle(value, CultureInfo.InvariantCulture);
	}

	public string ToString(object value)
	{
		if (value == null)
		{
			ThrowValueNullException();
		}
		return System.Convert.ToString(value, CultureInfo.InvariantCulture);
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowValueNullException()
	{
		throw new ArgumentNullException("value");
	}
}
