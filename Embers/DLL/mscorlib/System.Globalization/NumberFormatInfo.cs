using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public sealed class NumberFormatInfo : ICloneable, IFormatProvider
{
	private static volatile NumberFormatInfo invariantInfo;

	internal int[] numberGroupSizes = new int[1] { 3 };

	internal int[] currencyGroupSizes = new int[1] { 3 };

	internal int[] percentGroupSizes = new int[1] { 3 };

	internal string positiveSign = "+";

	internal string negativeSign = "-";

	internal string numberDecimalSeparator = ".";

	internal string numberGroupSeparator = ",";

	internal string currencyGroupSeparator = ",";

	internal string currencyDecimalSeparator = ".";

	internal string currencySymbol = "¤";

	internal string ansiCurrencySymbol;

	internal string nanSymbol = "NaN";

	internal string positiveInfinitySymbol = "Infinity";

	internal string negativeInfinitySymbol = "-Infinity";

	internal string percentDecimalSeparator = ".";

	internal string percentGroupSeparator = ",";

	internal string percentSymbol = "%";

	internal string perMilleSymbol = "‰";

	[OptionalField(VersionAdded = 2)]
	internal string[] nativeDigits = new string[10] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };

	[OptionalField(VersionAdded = 1)]
	internal int m_dataItem;

	internal int numberDecimalDigits = 2;

	internal int currencyDecimalDigits = 2;

	internal int currencyPositivePattern;

	internal int currencyNegativePattern;

	internal int numberNegativePattern = 1;

	internal int percentPositivePattern;

	internal int percentNegativePattern;

	internal int percentDecimalDigits = 2;

	[OptionalField(VersionAdded = 2)]
	internal int digitSubstitution = 1;

	internal bool isReadOnly;

	[OptionalField(VersionAdded = 1)]
	internal bool m_useUserOverride;

	[OptionalField(VersionAdded = 2)]
	internal bool m_isInvariant;

	[OptionalField(VersionAdded = 1)]
	internal bool validForParseAsNumber = true;

	[OptionalField(VersionAdded = 1)]
	internal bool validForParseAsCurrency = true;

	private const NumberStyles InvalidNumberStyles = ~(NumberStyles.Any | NumberStyles.AllowHexSpecifier);

	public static NumberFormatInfo InvariantInfo
	{
		get
		{
			if (invariantInfo == null)
			{
				invariantInfo = ReadOnly(new NumberFormatInfo
				{
					m_isInvariant = true
				});
			}
			return invariantInfo;
		}
	}

	public int CurrencyDecimalDigits => currencyDecimalDigits;

	public string CurrencyDecimalSeparator => currencyDecimalSeparator;

	public bool IsReadOnly => isReadOnly;

	public int[] CurrencyGroupSizes => (int[])currencyGroupSizes.Clone();

	public int[] NumberGroupSizes => (int[])numberGroupSizes.Clone();

	public int[] PercentGroupSizes => (int[])percentGroupSizes.Clone();

	public string CurrencyGroupSeparator => currencyGroupSeparator;

	public string CurrencySymbol => currencySymbol;

	public static NumberFormatInfo CurrentInfo
	{
		get
		{
			CultureInfo currentCulture = Thread.CurrentThread.CurrentCulture;
			if (!currentCulture.m_isInherited)
			{
				NumberFormatInfo numInfo = currentCulture.numInfo;
				if (numInfo != null)
				{
					return numInfo;
				}
			}
			return (NumberFormatInfo)currentCulture.GetFormat(typeof(NumberFormatInfo));
		}
	}

	public string NaNSymbol
	{
		get
		{
			return nanSymbol;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("NaNSymbol", Environment.GetResourceString("String reference not set to an instance of a String."));
			}
			VerifyWritable();
			nanSymbol = value;
		}
	}

	public int CurrencyNegativePattern => currencyNegativePattern;

	public int NumberNegativePattern => numberNegativePattern;

	public int PercentPositivePattern => percentPositivePattern;

	public int PercentNegativePattern => percentNegativePattern;

	public string NegativeInfinitySymbol => negativeInfinitySymbol;

	public string NegativeSign => negativeSign;

	public int NumberDecimalDigits => numberDecimalDigits;

	public string NumberDecimalSeparator => numberDecimalSeparator;

	public string NumberGroupSeparator => numberGroupSeparator;

	public int CurrencyPositivePattern => currencyPositivePattern;

	public string PositiveInfinitySymbol => positiveInfinitySymbol;

	public string PositiveSign => positiveSign;

	public int PercentDecimalDigits => percentDecimalDigits;

	public string PercentDecimalSeparator => percentDecimalSeparator;

	public string PercentGroupSeparator => percentGroupSeparator;

	public string PercentSymbol => percentSymbol;

	public string PerMilleSymbol => perMilleSymbol;

	public NumberFormatInfo()
		: this(null)
	{
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext ctx)
	{
		if (numberDecimalSeparator != numberGroupSeparator)
		{
			validForParseAsNumber = true;
		}
		else
		{
			validForParseAsNumber = false;
		}
		if (numberDecimalSeparator != numberGroupSeparator && numberDecimalSeparator != currencyGroupSeparator && currencyDecimalSeparator != numberGroupSeparator && currencyDecimalSeparator != currencyGroupSeparator)
		{
			validForParseAsCurrency = true;
		}
		else
		{
			validForParseAsCurrency = false;
		}
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
	}

	internal NumberFormatInfo(CultureData cultureData)
	{
		if (GlobalizationMode.Invariant)
		{
			m_isInvariant = true;
		}
		else if (cultureData != null)
		{
			cultureData.GetNFIValues(this);
			if (cultureData.IsInvariantCulture)
			{
				m_isInvariant = true;
			}
		}
	}

	private void VerifyWritable()
	{
		if (isReadOnly)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Instance is read-only."));
		}
	}

	public static NumberFormatInfo GetInstance(IFormatProvider formatProvider)
	{
		if (formatProvider is CultureInfo { m_isInherited: false } cultureInfo)
		{
			NumberFormatInfo numInfo = cultureInfo.numInfo;
			if (numInfo != null)
			{
				return numInfo;
			}
			return cultureInfo.NumberFormat;
		}
		if (formatProvider is NumberFormatInfo result)
		{
			return result;
		}
		if (formatProvider != null && formatProvider.GetFormat(typeof(NumberFormatInfo)) is NumberFormatInfo result2)
		{
			return result2;
		}
		return CurrentInfo;
	}

	public object Clone()
	{
		NumberFormatInfo obj = (NumberFormatInfo)MemberwiseClone();
		obj.isReadOnly = false;
		return obj;
	}

	public object GetFormat(Type formatType)
	{
		if (!(formatType == typeof(NumberFormatInfo)))
		{
			return null;
		}
		return this;
	}

	public static NumberFormatInfo ReadOnly(NumberFormatInfo nfi)
	{
		if (nfi == null)
		{
			throw new ArgumentNullException("nfi");
		}
		if (nfi.IsReadOnly)
		{
			return nfi;
		}
		NumberFormatInfo obj = (NumberFormatInfo)nfi.MemberwiseClone();
		obj.isReadOnly = true;
		return obj;
	}

	internal static void ValidateParseStyleInteger(NumberStyles style)
	{
		if ((style & ~(NumberStyles.Any | NumberStyles.AllowHexSpecifier)) != NumberStyles.None)
		{
			throw new ArgumentException(Environment.GetResourceString("An undefined NumberStyles value is being used."), "style");
		}
		if ((style & NumberStyles.AllowHexSpecifier) != NumberStyles.None && (style & ~NumberStyles.HexNumber) != NumberStyles.None)
		{
			throw new ArgumentException(Environment.GetResourceString("With the AllowHexSpecifier bit set in the enum bit field, the only other valid bits that can be combined into the enum value must be a subset of those in HexNumber."));
		}
	}

	internal static void ValidateParseStyleFloatingPoint(NumberStyles style)
	{
		if ((style & ~(NumberStyles.Any | NumberStyles.AllowHexSpecifier)) != NumberStyles.None)
		{
			throw new ArgumentException(Environment.GetResourceString("An undefined NumberStyles value is being used."), "style");
		}
		if ((style & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			throw new ArgumentException(Environment.GetResourceString("The number style AllowHexSpecifier is not supported on floating point data types."));
		}
	}
}
