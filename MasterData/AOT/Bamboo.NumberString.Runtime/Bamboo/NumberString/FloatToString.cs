using System.Collections.Generic;

namespace Bamboo.NumberString;

public static class FloatToString
{
	private const int MAX_CACHE = 1024;

	private const string PERCENT_SIGNAL = "%";

	private static readonly string[] _formats = new string[10] { "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9" };

	private static readonly string[] _percentageFormats = new string[10] { "0%", "0.0%", "0.00%", "0.000%", "0.0000%", "0.00000%", "0.000000%", "0.0000000%", "0.00000000%", "0.000000000%" };

	private static readonly Dictionary<float, string> _leftCacheMap = new Dictionary<float, string>(1024);

	private static readonly Dictionary<float, string> _rightCacheMap = new Dictionary<float, string>(1024);

	private static bool _activeCacheInRight = false;

	public static string FastToString(this float value, int fractionalDigits = -1, bool isPercent = false)
	{
		Dictionary<float, string> dictionary = (_activeCacheInRight ? _rightCacheMap : _leftCacheMap);
		if (dictionary.Count >= 1024)
		{
			_activeCacheInRight = !_activeCacheInRight;
			dictionary = (_activeCacheInRight ? _rightCacheMap : _leftCacheMap);
			dictionary.Clear();
		}
		if (dictionary.TryGetValue(value, out var value2))
		{
			if (isPercent && value2.Contains("%"))
			{
				return value2;
			}
			if (!isPercent && !value2.Contains("%"))
			{
				return value2;
			}
		}
		if ((_activeCacheInRight ? _leftCacheMap : _rightCacheMap).TryGetValue(value, out var value3))
		{
			if (isPercent && value3.Contains("%"))
			{
				return value3;
			}
			if (!isPercent && !value3.Contains("%"))
			{
				return value3;
			}
		}
		string[] array = (isPercent ? _percentageFormats : _formats);
		string text = ((fractionalDigits >= 0) ? value.ToString(array[fractionalDigits]) : value.ToString());
		return dictionary[value] = text;
	}
}
