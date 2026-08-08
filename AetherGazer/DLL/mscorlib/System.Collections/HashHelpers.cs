using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections;

internal static class HashHelpers
{
	public static readonly int[] primes = new int[72]
	{
		1780087873, 1264196073, -498057815, 1267748913, 1524911379, 1271161918, -241344425, 1274641741, 1845803117, 1278205089,
		-456985788, 1281616356, 502509589, 1285088350, -1519346661, 1288641909, -2023333487, 1292071529, -381683211, 1295535875,
		-477104014, 1299079876, 238680903, 1302527419, -775390695, 1305984297, 1178245279, 1309518964, -1411080348, 1312984008,
		-690108611, 1316433594, -1936377588, 1319959145, -136494169, 1323441281, 1976865937, 1326883746, 323598773, 1330400395,
		-334621679, 1333899222, -1492018922, 1337334732, -791281829, 1340842687, -494551143, 1344357815, -618188929, 1347786533,
		1374747487, 1351285999, 0, -1074790400, 0, 0, 0, 1072693248, 0, 1073741824,
		0, 1074266112, 0, 1074790400, 0, 1075052544, 0, 1075314688, 0, 1075576832,
		0, 1075838976
	};

	private static ConditionalWeakTable<object, SerializationInfo> s_serializationInfoTable;

	internal static ConditionalWeakTable<object, SerializationInfo> SerializationInfoTable
	{
		get
		{
			if (s_serializationInfoTable == null)
			{
				Interlocked.CompareExchange(ref s_serializationInfoTable, new ConditionalWeakTable<object, SerializationInfo>(), null);
			}
			return s_serializationInfoTable;
		}
	}

	public static bool IsPrime(int candidate)
	{
		if ((candidate & 1) != 0)
		{
			int num = (int)Math.Sqrt(candidate);
			for (int i = 3; i <= num; i += 2)
			{
				if (candidate % i == 0)
				{
					return false;
				}
			}
			return true;
		}
		return candidate == 2;
	}

	public static int GetPrime(int min)
	{
		if (min < 0)
		{
			throw new ArgumentException("Hashtable's capacity overflowed and went negative. Check load factor, capacity and the current size of the table.");
		}
		for (int i = 0; i < primes.Length; i++)
		{
			int num = primes[i];
			if (num >= min)
			{
				return num;
			}
		}
		for (int j = min | 1; j < int.MaxValue; j += 2)
		{
			if (IsPrime(j) && (j - 1) % 101 != 0)
			{
				return j;
			}
		}
		return min;
	}

	public static int ExpandPrime(int oldSize)
	{
		int num = 2 * oldSize;
		if ((uint)num > 2146435069u && 2146435069 > oldSize)
		{
			return 2146435069;
		}
		return GetPrime(num);
	}
}
