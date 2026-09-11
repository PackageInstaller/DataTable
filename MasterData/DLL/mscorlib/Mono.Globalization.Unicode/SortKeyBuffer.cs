using System;
using System.Globalization;

namespace Mono.Globalization.Unicode;

internal class SortKeyBuffer
{
	private byte[] l1b;

	private byte[] l2b;

	private byte[] l3b;

	private byte[] l4sb;

	private byte[] l4tb;

	private byte[] l4kb;

	private byte[] l4wb;

	private byte[] l5b;

	private string source;

	private int l1;

	private int l2;

	private int l3;

	private int l4s;

	private int l4t;

	private int l4k;

	private int l4w;

	private int l5;

	private int lcid;

	private CompareOptions options;

	private bool processLevel2;

	private bool frenchSort;

	private bool frenchSorted;

	public SortKeyBuffer(int lcid)
	{
	}

	public void Reset()
	{
		l1 = (l2 = (l3 = (l4s = (l4t = (l4k = (l4w = (l5 = 0)))))));
		frenchSorted = false;
	}

	internal void Initialize(CompareOptions options, int lcid, string s, bool frenchSort)
	{
		source = s;
		this.lcid = lcid;
		this.options = options;
		int length = s.Length;
		processLevel2 = (options & CompareOptions.IgnoreNonSpace) == 0;
		this.frenchSort = frenchSort;
		if (l1b == null || l1b.Length < length)
		{
			l1b = new byte[length * 2 + 10];
		}
		if (processLevel2 && (l2b == null || l2b.Length < length))
		{
			l2b = new byte[length + 10];
		}
		if (l3b == null || l3b.Length < length)
		{
			l3b = new byte[length + 10];
		}
		if (l4sb == null)
		{
			l4sb = new byte[10];
		}
		if (l4tb == null)
		{
			l4tb = new byte[10];
		}
		if (l4kb == null)
		{
			l4kb = new byte[10];
		}
		if (l4wb == null)
		{
			l4wb = new byte[10];
		}
		if (l5b == null)
		{
			l5b = new byte[10];
		}
	}

	internal void AppendCJKExtension(byte lv1msb, byte lv1lsb)
	{
		AppendBufferPrimitive(254, ref l1b, ref l1);
		AppendBufferPrimitive(byte.MaxValue, ref l1b, ref l1);
		AppendBufferPrimitive(lv1msb, ref l1b, ref l1);
		AppendBufferPrimitive(lv1lsb, ref l1b, ref l1);
		if (processLevel2)
		{
			AppendBufferPrimitive(2, ref l2b, ref l2);
		}
		AppendBufferPrimitive(2, ref l3b, ref l3);
	}

	internal void AppendKana(byte category, byte lv1, byte lv2, byte lv3, bool isSmallKana, byte markType, bool isKatakana, bool isHalfWidth)
	{
		AppendNormal(category, lv1, lv2, lv3);
		AppendBufferPrimitive((byte)(isSmallKana ? 196u : 228u), ref l4sb, ref l4s);
		AppendBufferPrimitive(markType, ref l4tb, ref l4t);
		AppendBufferPrimitive((byte)(isKatakana ? 196u : 228u), ref l4kb, ref l4k);
		AppendBufferPrimitive((byte)(isHalfWidth ? 196u : 228u), ref l4wb, ref l4w);
	}

	internal void AppendNormal(byte category, byte lv1, byte lv2, byte lv3)
	{
		if (lv2 == 0)
		{
			lv2 = 2;
		}
		if (lv3 == 0)
		{
			lv3 = 2;
		}
		if (category == 6 && (options & CompareOptions.StringSort) == 0)
		{
			AppendLevel5(category, lv1);
			return;
		}
		if (processLevel2 && category == 1 && l1 > 0)
		{
			lv2 += l2b[--l2];
			lv3 = l3b[--l3];
		}
		if (category != 1)
		{
			AppendBufferPrimitive(category, ref l1b, ref l1);
			AppendBufferPrimitive(lv1, ref l1b, ref l1);
		}
		if (processLevel2)
		{
			AppendBufferPrimitive(lv2, ref l2b, ref l2);
		}
		AppendBufferPrimitive(lv3, ref l3b, ref l3);
	}

	private void AppendLevel5(byte category, byte lv1)
	{
		int num = (l2 + 1) % 8192;
		AppendBufferPrimitive((byte)(num / 64 + 128), ref l5b, ref l5);
		AppendBufferPrimitive((byte)(num % 64 * 4 + 3), ref l5b, ref l5);
		AppendBufferPrimitive(category, ref l5b, ref l5);
		AppendBufferPrimitive(lv1, ref l5b, ref l5);
	}

	private void AppendBufferPrimitive(byte value, ref byte[] buf, ref int bidx)
	{
		buf[bidx++] = value;
		if (bidx == buf.Length)
		{
			byte[] array = new byte[bidx * 2];
			Array.Copy(buf, array, buf.Length);
			buf = array;
		}
	}

	public SortKey GetResultAndReset()
	{
		SortKey result = GetResult();
		Reset();
		return result;
	}

	private int GetOptimizedLength(byte[] data, int len, byte defaultValue)
	{
		int num = -1;
		for (int i = 0; i < len; i++)
		{
			if (data[i] != defaultValue)
			{
				num = i;
			}
		}
		return num + 1;
	}

	public SortKey GetResult()
	{
		if (source.Length == 0)
		{
			return new SortKey(lcid, source, new byte[0], options, 0, 0, 0, 0, 0, 0, 0, 0);
		}
		if (frenchSort && !frenchSorted && l2b != null)
		{
			int i;
			for (i = 0; i < l2b.Length && l2b[i] != 0; i++)
			{
			}
			Array.Reverse(l2b, 0, i);
			frenchSorted = true;
		}
		l2 = GetOptimizedLength(l2b, l2, 2);
		l3 = GetOptimizedLength(l3b, l3, 2);
		bool num = l4s > 0;
		l4s = GetOptimizedLength(l4sb, l4s, 228);
		l4t = GetOptimizedLength(l4tb, l4t, 3);
		l4k = GetOptimizedLength(l4kb, l4k, 228);
		l4w = GetOptimizedLength(l4wb, l4w, 228);
		l5 = GetOptimizedLength(l5b, l5, 2);
		int num2 = l1 + l2 + l3 + l5 + 5;
		int num3 = l4s + l4t + l4k + l4w;
		if (num)
		{
			num2 += num3 + 4;
		}
		byte[] array = new byte[num2];
		Array.Copy(l1b, array, l1);
		array[l1] = 1;
		int num4 = l1 + 1;
		if (l2 > 0)
		{
			Array.Copy(l2b, 0, array, num4, l2);
		}
		num4 += l2;
		array[num4++] = 1;
		if (l3 > 0)
		{
			Array.Copy(l3b, 0, array, num4, l3);
		}
		num4 += l3;
		array[num4++] = 1;
		if (num)
		{
			Array.Copy(l4sb, 0, array, num4, l4s);
			num4 += l4s;
			array[num4++] = byte.MaxValue;
			Array.Copy(l4tb, 0, array, num4, l4t);
			num4 += l4t;
			array[num4++] = 2;
			Array.Copy(l4kb, 0, array, num4, l4k);
			num4 += l4k;
			array[num4++] = byte.MaxValue;
			Array.Copy(l4wb, 0, array, num4, l4w);
			num4 += l4w;
			array[num4++] = byte.MaxValue;
		}
		array[num4++] = 1;
		if (l5 > 0)
		{
			Array.Copy(l5b, 0, array, num4, l5);
		}
		num4 += l5;
		array[num4++] = 0;
		return new SortKey(lcid, source, array, options, l1, l2, l3, l4s, l4t, l4k, l4w, l5);
	}
}
