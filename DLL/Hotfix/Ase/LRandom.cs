using System;
using UnityEngine;

namespace Ase;

public class LRandom
{
	private const int N = 624;

	private const int M = 397;

	private const uint MATRIX_A = 2567483615u;

	private const uint UPPER_MASK = 2147483648u;

	private const uint LOWER_MASK = 2147483647u;

	private const int MAX_RAND_INT = int.MaxValue;

	private uint[] mag01 = new uint[2] { 0u, 2567483615u };

	private uint[] mt = new uint[624];

	private int mti = 625;

	public static int MaxRandomInt => int.MaxValue;

	public float value => NextF();

	public Vector3 insideUnitSphere => new Vector3(value, value, value);

	public Vector3 onsideUnitSphere => insideUnitSphere.normalized;

	public static LRandom New(int seed)
	{
		return new LRandom(seed);
	}

	private LRandom()
	{
		init_genrand((uint)DateTime.Now.Millisecond);
	}

	private LRandom(int seed)
	{
		init_genrand((uint)seed);
	}

	private LRandom(int[] init)
	{
		uint[] array = new uint[init.Length];
		for (int i = 0; i < init.Length; i++)
		{
			array[i] = (uint)init[i];
		}
		init_by_array(array, (uint)array.Length);
	}

	public int Next()
	{
		return genrand_int31();
	}

	public int CallNext()
	{
		return Next();
	}

	public int Next(int minValue, int maxValue)
	{
		if (minValue > maxValue)
		{
			int num = maxValue;
			maxValue = minValue;
			minValue = num;
		}
		int num2 = maxValue - minValue;
		return minValue + Next() % num2;
	}

	public float Next(float minValue, float maxValue)
	{
		int num = (int)(minValue * 1000f);
		int num2 = (int)(maxValue * 1000f);
		if (num > num2)
		{
			int num3 = num2;
			num2 = num;
			num = num3;
		}
		return Mathf.Floor((float)(num2 - num + 1) * NextF() + (float)num) / 1000f;
	}

	public float NextFloat(float minValue, float maxValue)
	{
		float num = minValue * 1000f;
		float num2 = maxValue * 1000f;
		if (num > num2)
		{
			float num3 = num2;
			num2 = num;
			num = num3;
		}
		return Mathf.Floor((num2 - num + 1f) * NextF() + num) / 1000f;
	}

	public int Range(int minValue, int maxValue)
	{
		return Next(minValue, maxValue);
	}

	public float Range(float minValue, float maxValue)
	{
		return Next(minValue, maxValue);
	}

	public float NextF()
	{
		return (float)Next() / (float)MaxRandomInt;
	}

	private float NextFloat()
	{
		return (float)genrand_real2();
	}

	private float NextFloat(bool includeOne)
	{
		if (includeOne)
		{
			return (float)genrand_real1();
		}
		return (float)genrand_real2();
	}

	private float NextFloatPositive()
	{
		return (float)genrand_real3();
	}

	private double NextDouble()
	{
		return genrand_real2();
	}

	private double NextDouble(bool includeOne)
	{
		if (includeOne)
		{
			return genrand_real1();
		}
		return genrand_real2();
	}

	private double NextDoublePositive()
	{
		return genrand_real3();
	}

	private double Next53BitRes()
	{
		return genrand_res53();
	}

	public void Initialize()
	{
		init_genrand((uint)DateTime.Now.Millisecond);
	}

	public void Initialize(int seed)
	{
		init_genrand((uint)seed);
	}

	public void Initialize(int[] init)
	{
		uint[] array = new uint[init.Length];
		for (int i = 0; i < init.Length; i++)
		{
			array[i] = (uint)init[i];
		}
		init_by_array(array, (uint)array.Length);
	}

	private void init_genrand(uint s)
	{
		mt[0] = s & 0xFFFFFFFFu;
		for (mti = 1; mti < 624; mti++)
		{
			mt[mti] = (uint)(1812433253 * (mt[mti - 1] ^ (mt[mti - 1] >> 30)) + mti);
			mt[mti] &= uint.MaxValue;
		}
	}

	private void init_by_array(uint[] init_key, uint key_length)
	{
		init_genrand(19650218u);
		int num = 1;
		int num2 = 0;
		for (int num3 = (int)((624 > key_length) ? 624 : key_length); num3 > 0; num3--)
		{
			mt[num] = (uint)((mt[num] ^ ((mt[num - 1] ^ (mt[num - 1] >> 30)) * 1664525)) + init_key[num2] + num2);
			mt[num] &= uint.MaxValue;
			num++;
			num2++;
			if (num >= 624)
			{
				mt[0] = mt[623];
				num = 1;
			}
			if (num2 >= key_length)
			{
				num2 = 0;
			}
		}
		for (int num3 = 623; num3 > 0; num3--)
		{
			mt[num] = (uint)((mt[num] ^ ((mt[num - 1] ^ (mt[num - 1] >> 30)) * 1566083941)) - num);
			mt[num] &= uint.MaxValue;
			num++;
			if (num >= 624)
			{
				mt[0] = mt[623];
				num = 1;
			}
		}
		mt[0] = 2147483648u;
	}

	private uint genrand_int32()
	{
		uint num;
		if (mti >= 624)
		{
			if (mti == 625)
			{
				init_genrand(5489u);
			}
			int i;
			for (i = 0; i < 227; i++)
			{
				num = (mt[i] & 0x80000000u) | (mt[i + 1] & 0x7FFFFFFF);
				mt[i] = mt[i + 397] ^ (num >> 1) ^ mag01[num & 1];
			}
			for (; i < 623; i++)
			{
				num = (mt[i] & 0x80000000u) | (mt[i + 1] & 0x7FFFFFFF);
				mt[i] = mt[i + -227] ^ (num >> 1) ^ mag01[num & 1];
			}
			num = (mt[623] & 0x80000000u) | (mt[0] & 0x7FFFFFFF);
			mt[623] = mt[396] ^ (num >> 1) ^ mag01[num & 1];
			mti = 0;
		}
		num = mt[mti++];
		num ^= num >> 11;
		num ^= (num << 7) & 0x9D2C5680u;
		num ^= (num << 15) & 0xEFC60000u;
		return num ^ (num >> 18);
	}

	private int genrand_int31()
	{
		return (int)(genrand_int32() >> 1);
	}

	private double genrand_real1()
	{
		return (double)genrand_int32() * 2.3283064370807974E-10;
	}

	private double genrand_real2()
	{
		return (double)genrand_int32() * 2.3283064365386963E-10;
	}

	private double genrand_real3()
	{
		return ((double)genrand_int32() + 0.5) * 2.3283064365386963E-10;
	}

	private double genrand_res53()
	{
		uint num = genrand_int32() >> 5;
		uint num2 = genrand_int32() >> 6;
		return ((double)num * 67108864.0 + (double)num2) * 1.1102230246251565E-16;
	}
}
