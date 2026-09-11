using System.Globalization;
using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class CultureAwareComparer : StringComparer, ISerializable
{
	private const CompareOptions ValidCompareMaskOffFlags = ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort);

	private readonly CompareInfo _compareInfo;

	private CompareOptions _options;

	internal CultureAwareComparer(CultureInfo culture, CompareOptions options)
		: this(culture.CompareInfo, options)
	{
	}

	internal CultureAwareComparer(CompareInfo compareInfo, CompareOptions options)
	{
		_compareInfo = compareInfo;
		if ((options & ~(CompareOptions.IgnoreCase | CompareOptions.IgnoreNonSpace | CompareOptions.IgnoreSymbols | CompareOptions.IgnoreKanaType | CompareOptions.IgnoreWidth | CompareOptions.StringSort)) != CompareOptions.None)
		{
			throw new ArgumentException("Value of flags is invalid.", "options");
		}
		_options = options;
	}

	private CultureAwareComparer(SerializationInfo info, StreamingContext context)
	{
		_compareInfo = (CompareInfo)info.GetValue("_compareInfo", typeof(CompareInfo));
		bool boolean = info.GetBoolean("_ignoreCase");
		object valueNoThrow = info.GetValueNoThrow("_options", typeof(CompareOptions));
		if (valueNoThrow != null)
		{
			_options = (CompareOptions)valueNoThrow;
		}
		_options |= (CompareOptions)(boolean ? 1 : 0);
	}

	public override int Compare(string x, string y)
	{
		if ((object)x == y)
		{
			return 0;
		}
		if (x == null)
		{
			return -1;
		}
		if (y == null)
		{
			return 1;
		}
		return _compareInfo.Compare(x, y, _options);
	}

	public override bool Equals(string x, string y)
	{
		if ((object)x == y)
		{
			return true;
		}
		if (x == null || y == null)
		{
			return false;
		}
		return _compareInfo.Compare(x, y, _options) == 0;
	}

	public override int GetHashCode(string obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		return _compareInfo.GetHashCodeOfString(obj, _options);
	}

	public override bool Equals(object obj)
	{
		if (obj is CultureAwareComparer cultureAwareComparer && _options == cultureAwareComparer._options)
		{
			return _compareInfo.Equals(cultureAwareComparer._compareInfo);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _compareInfo.GetHashCode() ^ (int)(_options & (CompareOptions)0x7FFFFFFF);
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		info.AddValue("_compareInfo", _compareInfo);
		info.AddValue("_options", _options);
		info.AddValue("_ignoreCase", (_options & CompareOptions.IgnoreCase) != 0);
	}
}
