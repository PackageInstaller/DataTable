using System.Collections.Generic;

namespace Bamboo.NumberString;

public static class IntToString
{
	private const int MAX_CACHE = 1024;

	private static readonly string[] _constPositive;

	private static readonly string[] _constNegative;

	private static readonly Dictionary<long, string> _leftCacheMap;

	private static readonly Dictionary<long, string> _rightCacheMap;

	private static bool _activeCacheInRight;

	static IntToString()
	{
		_constPositive = new string[1024];
		_constNegative = new string[1024];
		_leftCacheMap = new Dictionary<long, string>(1024);
		_rightCacheMap = new Dictionary<long, string>(1024);
		_activeCacheInRight = false;
		for (int i = 0; i < 1024; i++)
		{
			_constPositive[i] = i.ToString();
		}
		for (int j = 0; j < 1024; j++)
		{
			_constNegative[j] = (-j).ToString();
		}
	}

	public static string FastToString(this int value)
	{
		return ((long)value).FastToString();
	}

	public static string FastToString(this long value)
	{
		if (value >= 0 && value < 1024)
		{
			return _constPositive[value];
		}
		if (value <= 0 && value > -1024)
		{
			return _constNegative[-value];
		}
		Dictionary<long, string> dictionary = (_activeCacheInRight ? _rightCacheMap : _leftCacheMap);
		if (dictionary.Count >= 1024)
		{
			_activeCacheInRight = !_activeCacheInRight;
			dictionary = (_activeCacheInRight ? _rightCacheMap : _leftCacheMap);
			dictionary.Clear();
		}
		if (dictionary.TryGetValue(value, out var value2))
		{
			return value2;
		}
		if ((_activeCacheInRight ? _leftCacheMap : _rightCacheMap).TryGetValue(value, out var value3))
		{
			return value3;
		}
		return dictionary[value] = value.ToString();
	}
}
