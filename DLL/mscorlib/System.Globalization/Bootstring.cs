using System.Text;

namespace System.Globalization;

internal class Bootstring
{
	private readonly char delimiter;

	private readonly int base_num;

	private readonly int tmin;

	private readonly int tmax;

	private readonly int skew;

	private readonly int damp;

	private readonly int initial_bias;

	private readonly int initial_n;

	public Bootstring(char delimiter, int baseNum, int tmin, int tmax, int skew, int damp, int initialBias, int initialN)
	{
		this.delimiter = delimiter;
		base_num = baseNum;
		this.tmin = tmin;
		this.tmax = tmax;
		this.skew = skew;
		this.damp = damp;
		initial_bias = initialBias;
		initial_n = initialN;
	}

	public string Encode(string s, int offset)
	{
		int num = initial_n;
		int num2 = 0;
		int num3 = initial_bias;
		int num4 = 0;
		int num5 = 0;
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] < '\u0080')
			{
				stringBuilder.Append(s[i]);
			}
		}
		num4 = (num5 = stringBuilder.Length);
		if (num4 > 0)
		{
			stringBuilder.Append(delimiter);
		}
		while (num5 < s.Length)
		{
			int num6 = int.MaxValue;
			for (int j = 0; j < s.Length; j++)
			{
				if (s[j] >= num && s[j] < num6)
				{
					num6 = s[j];
				}
			}
			num2 = checked(num2 + (num6 - num) * (num5 + 1));
			num = num6;
			foreach (char c in s)
			{
				if (c < num || c < '\u0080')
				{
					num2 = checked(num2 + 1);
				}
				if (c != num)
				{
					continue;
				}
				int num7 = num2;
				int num8 = base_num;
				while (true)
				{
					int num9 = ((num8 <= num3 + tmin) ? tmin : ((num8 >= num3 + tmax) ? tmax : (num8 - num3)));
					if (num7 < num9)
					{
						break;
					}
					stringBuilder.Append(EncodeDigit(num9 + (num7 - num9) % (base_num - num9)));
					num7 = (num7 - num9) / (base_num - num9);
					num8 += base_num;
				}
				stringBuilder.Append(EncodeDigit(num7));
				num3 = Adapt(num2, num5 + 1, num5 == num4);
				num2 = 0;
				num5++;
			}
			num2++;
			num++;
		}
		return stringBuilder.ToString();
	}

	private char EncodeDigit(int d)
	{
		return (char)((d < 26) ? (d + 97) : (d - 26 + 48));
	}

	private int DecodeDigit(char c)
	{
		if (c - 48 >= 10)
		{
			if (c - 65 >= 26)
			{
				if (c - 97 >= 26)
				{
					return base_num;
				}
				return c - 97;
			}
			return c - 65;
		}
		return c - 22;
	}

	private int Adapt(int delta, int numPoints, bool firstTime)
	{
		delta = ((!firstTime) ? (delta / 2) : (delta / damp));
		delta += delta / numPoints;
		int num = 0;
		while (delta > (base_num - tmin) * tmax / 2)
		{
			delta /= base_num - tmin;
			num += base_num;
		}
		return num + (base_num - tmin + 1) * delta / (delta + skew);
	}

	public string Decode(string s, int offset)
	{
		int num = initial_n;
		int num2 = 0;
		int num3 = initial_bias;
		int num4 = 0;
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] == delimiter)
			{
				num4 = i;
			}
		}
		if (num4 < 0)
		{
			return s;
		}
		stringBuilder.Append(s, 0, num4);
		int num5 = ((num4 > 0) ? (num4 + 1) : 0);
		while (num5 < s.Length)
		{
			int num6 = num2;
			int num7 = 1;
			int num8 = base_num;
			while (true)
			{
				int num9 = DecodeDigit(s[num5++]);
				num2 += num9 * num7;
				int num10 = ((num8 <= num3 + tmin) ? tmin : ((num8 >= num3 + tmax) ? tmax : (num8 - num3)));
				if (num9 < num10)
				{
					break;
				}
				num7 *= base_num - num10;
				num8 += base_num;
			}
			num3 = Adapt(num2 - num6, stringBuilder.Length + 1, num6 == 0);
			num += num2 / (stringBuilder.Length + 1);
			num2 %= stringBuilder.Length + 1;
			if (num < 128)
			{
				throw new ArgumentException($"Invalid Bootstring decode result, at {offset + num5}");
			}
			stringBuilder.Insert(num2, (char)num);
			num2++;
		}
		return stringBuilder.ToString();
	}
}
