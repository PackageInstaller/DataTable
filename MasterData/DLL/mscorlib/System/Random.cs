namespace System;

public class Random
{
	private const int MBIG = int.MaxValue;

	private const int MSEED = 161803398;

	private const int MZ = 0;

	private int _inext;

	private int _inextp;

	private int[] _seedArray = new int[56];

	[ThreadStatic]
	private static Random t_threadRandom;

	private static readonly Random s_globalRandom = new Random(GenerateGlobalSeed());

	public Random()
		: this(GenerateSeed())
	{
	}

	public Random(int Seed)
	{
		int num = 0;
		int num2 = 161803398 - ((Seed == int.MinValue) ? int.MaxValue : Math.Abs(Seed));
		_seedArray[55] = num2;
		int num3 = 1;
		for (int i = 1; i < 55; i++)
		{
			if ((num += 21) >= 55)
			{
				num -= 55;
			}
			_seedArray[num] = num3;
			num3 = num2 - num3;
			if (num3 < 0)
			{
				num3 += int.MaxValue;
			}
			num2 = _seedArray[num];
		}
		for (int j = 1; j < 5; j++)
		{
			for (int k = 1; k < 56; k++)
			{
				int num4 = k + 30;
				if (num4 >= 55)
				{
					num4 -= 55;
				}
				_seedArray[k] -= _seedArray[1 + num4];
				if (_seedArray[k] < 0)
				{
					_seedArray[k] += int.MaxValue;
				}
			}
		}
		_inext = 0;
		_inextp = 21;
		Seed = 1;
	}

	protected virtual double Sample()
	{
		return (double)InternalSample() * 4.656612875245797E-10;
	}

	private int InternalSample()
	{
		int inext = _inext;
		int inextp = _inextp;
		if (++inext >= 56)
		{
			inext = 1;
		}
		if (++inextp >= 56)
		{
			inextp = 1;
		}
		int num = _seedArray[inext] - _seedArray[inextp];
		if (num == int.MaxValue)
		{
			num--;
		}
		if (num < 0)
		{
			num += int.MaxValue;
		}
		_seedArray[inext] = num;
		_inext = inext;
		_inextp = inextp;
		return num;
	}

	private static int GenerateSeed()
	{
		Random random = t_threadRandom;
		if (random == null)
		{
			int seed;
			lock (s_globalRandom)
			{
				seed = s_globalRandom.Next();
			}
			random = (t_threadRandom = new Random(seed));
		}
		return random.Next();
	}

	private unsafe static int GenerateGlobalSeed()
	{
		int result = default(int);
		Interop.GetRandomBytes((byte*)(&result), 4);
		return result;
	}

	public virtual int Next()
	{
		return InternalSample();
	}

	private double GetSampleForLargeRange()
	{
		int num = InternalSample();
		if (InternalSample() % 2 == 0)
		{
			num = -num;
		}
		return ((double)num + 2147483646.0) / 4294967293.0;
	}

	public virtual int Next(int minValue, int maxValue)
	{
		if (minValue > maxValue)
		{
			throw new ArgumentOutOfRangeException("minValue", SR.Format("'{0}' cannot be greater than {1}.", "minValue", "maxValue"));
		}
		long num = (long)maxValue - (long)minValue;
		if (num <= int.MaxValue)
		{
			return (int)(Sample() * (double)num) + minValue;
		}
		return (int)((long)(GetSampleForLargeRange() * (double)num) + minValue);
	}

	public virtual int Next(int maxValue)
	{
		if (maxValue < 0)
		{
			throw new ArgumentOutOfRangeException("maxValue", SR.Format("'{0}' must be greater than zero.", "maxValue"));
		}
		return (int)(Sample() * (double)maxValue);
	}

	public virtual double NextDouble()
	{
		return Sample();
	}

	public virtual void NextBytes(byte[] buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		for (int i = 0; i < buffer.Length; i++)
		{
			buffer[i] = (byte)InternalSample();
		}
	}

	public virtual void NextBytes(Span<byte> buffer)
	{
		for (int i = 0; i < buffer.Length; i++)
		{
			buffer[i] = (byte)Next();
		}
	}
}
