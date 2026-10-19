using System;
using System.Collections.Generic;

namespace Bamboo.Pool;

public sealed class StringPool
{
	private static StringPool _default;

	private static readonly Dictionary<int, string> _blankStringMap = new Dictionary<int, string>();

	private readonly Dictionary<int, Queue<string>> _map = new Dictionary<int, Queue<string>>();

	private static readonly char[] _numberChars = new char[10] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

	private static readonly int[] _digitNumbers = new int[10] { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000 };

	public static StringPool Default
	{
		get
		{
			if (_default == null)
			{
				_default = new StringPool();
			}
			return _default;
		}
	}

	public static string GetBlank(int length)
	{
		if (!_blankStringMap.TryGetValue(length, out var value))
		{
			value = new string('\0', length);
			_blankStringMap[length] = value;
		}
		return value;
	}

	public unsafe string Get(ReadOnlySpan<char> value)
	{
		int length = value.Length;
		if (!_map.TryGetValue(length, out var value2))
		{
			value2 = new Queue<string>();
			_map[length] = value2;
		}
		if (value2.Count > 1)
		{
			string text = value2.Dequeue();
			int num = length * 2;
			fixed (char* source = value)
			{
				fixed (char* destination = text)
				{
					Buffer.MemoryCopy(source, destination, num, num);
				}
			}
			return text;
		}
		return new string(value);
	}

	public unsafe string Get(ReadOnlySpan<char> value1, ReadOnlySpan<char> value2)
	{
		int length = value1.Length;
		int length2 = value2.Length;
		int num = length + length2;
		if (!_map.TryGetValue(num, out var value3))
		{
			value3 = new Queue<string>();
			_map[num] = value3;
		}
		string text = ((value3.Count <= 1) ? new string('\0', num) : value3.Dequeue());
		fixed (char* ptr = text)
		{
			int num2 = length * 2;
			fixed (char* source = value1)
			{
				Buffer.MemoryCopy(source, ptr, num2, num2);
			}
			int num3 = length2 * 2;
			fixed (char* source = value2)
			{
				Buffer.MemoryCopy(source, ptr + length, num3, num3);
			}
		}
		return text;
	}

	public unsafe string Get(ReadOnlySpan<char> value1, ReadOnlySpan<char> value2, ReadOnlySpan<char> value3)
	{
		int length = value1.Length;
		int length2 = value2.Length;
		int length3 = value3.Length;
		int num = length + length2 + length3;
		if (!_map.TryGetValue(num, out var value4))
		{
			value4 = new Queue<string>();
			_map[num] = value4;
		}
		string text = ((value4.Count <= 1) ? new string('\0', num) : value4.Dequeue());
		fixed (char* ptr = text)
		{
			int num2 = length * 2;
			fixed (char* source = value1)
			{
				Buffer.MemoryCopy(source, ptr, num2, num2);
			}
			int num3 = length2 * 2;
			fixed (char* source = value2)
			{
				Buffer.MemoryCopy(source, ptr + length, num3, num3);
			}
			int num4 = length3 * 2;
			fixed (char* source = value3)
			{
				Buffer.MemoryCopy(source, ptr + length + length2, num4, num4);
			}
		}
		return text;
	}

	public unsafe string Get(int value)
	{
		int num;
		char[] array;
		if (value > 0)
		{
			num = (int)Math.Floor(Math.Log10(value) + 1.0);
			array = FastFreeArrayPool<char>.Default.Get(num);
			for (int i = 0; i < num; i++)
			{
				int num2 = num - i - 1;
				int num3 = _digitNumbers[num2];
				int num4 = value / num3;
				value -= num4 * num3;
				array[i] = _numberChars[num4];
			}
		}
		else if (value < 0)
		{
			value = -value;
			num = (int)Math.Floor(Math.Log10(value) + 1.0) + 1;
			array = FastFreeArrayPool<char>.Default.Get(num);
			array[0] = '-';
			for (int j = 1; j < num; j++)
			{
				int num5 = num - j - 1;
				int num6 = _digitNumbers[num5];
				int num7 = value / num6;
				value -= num7 * num6;
				array[j] = _numberChars[num7];
			}
		}
		else
		{
			num = 1;
			array = FastFreeArrayPool<char>.Default.Get(num);
			array[0] = '0';
		}
		if (!_map.TryGetValue(num, out var value2))
		{
			value2 = new Queue<string>();
			_map[num] = value2;
		}
		string text;
		if (value2.Count > 1)
		{
			text = value2.Dequeue();
			int num8 = num * 2;
			fixed (char* source = array)
			{
				fixed (char* destination = text)
				{
					Buffer.MemoryCopy(source, destination, num8, num8);
				}
			}
		}
		else
		{
			text = new string(array);
		}
		FastFreeArrayPool<char>.Default.Recycle(array);
		return text;
	}

	public unsafe string Get(float value, int fractionalDigits = 2)
	{
		int num = (int)value;
		int num2 = (int)Math.Round((float)_digitNumbers[fractionalDigits] * (value - (float)num));
		int num3;
		int num4;
		char[] array;
		if (num > 0)
		{
			num3 = (int)Math.Floor(Math.Log10(num) + 1.0);
			num4 = num3 + 1 + fractionalDigits;
			array = FastFreeArrayPool<char>.Default.Get(num4);
			for (int i = 0; i < num3; i++)
			{
				int num5 = num3 - i - 1;
				int num6 = _digitNumbers[num5];
				int num7 = num / num6;
				num -= num7 * num6;
				array[i] = _numberChars[num7];
			}
		}
		else if (num < 0)
		{
			num = -num;
			num3 = (int)Math.Floor(Math.Log10(num) + 1.0) + 1;
			num4 = num3 + 1 + fractionalDigits;
			array = FastFreeArrayPool<char>.Default.Get(num4);
			array[0] = '-';
			for (int j = 1; j < num3; j++)
			{
				int num8 = num3 - j - 1;
				int num9 = _digitNumbers[num8];
				int num10 = num / num9;
				num -= num10 * num9;
				array[j] = _numberChars[num10];
			}
		}
		else
		{
			num3 = 1;
			num4 = num3 + 1 + fractionalDigits;
			array = FastFreeArrayPool<char>.Default.Get(num4);
			array[0] = '0';
		}
		array[num3] = '.';
		for (int k = num3 + 1; k < num4; k++)
		{
			int num11 = num4 - k - 1;
			int num12 = _digitNumbers[num11];
			int num13 = num2 / num12;
			num2 -= num13 * num12;
			array[k] = _numberChars[num13];
		}
		if (!_map.TryGetValue(num4, out var value2))
		{
			value2 = new Queue<string>();
			_map[num4] = value2;
		}
		string text;
		if (value2.Count > 1)
		{
			text = value2.Dequeue();
			int num14 = num4 * 2;
			fixed (char* source = array)
			{
				fixed (char* destination = text)
				{
					Buffer.MemoryCopy(source, destination, num14, num14);
				}
			}
		}
		else
		{
			text = new string(array);
		}
		FastFreeArrayPool<char>.Default.Recycle(array);
		return text;
	}

	public unsafe void Recycle(string value, bool clear = false)
	{
		if (string.IsNullOrEmpty(value))
		{
			return;
		}
		int length = value.Length;
		if (clear)
		{
			string blank = GetBlank(length);
			int num = length * 2;
			fixed (char* source = blank)
			{
				fixed (char* destination = value)
				{
					Buffer.MemoryCopy(source, destination, num, num);
				}
			}
		}
		if (!_map.TryGetValue(length, out var value2))
		{
			value2 = new Queue<string>();
			_map[length] = value2;
		}
		value2.Enqueue(value);
	}
}
