using System;
using System.Runtime.CompilerServices;

public class I18NTranslateFileIdMap
{
	public struct Entry
	{
		public ulong hash1;

		public ulong hash2;

		public string translateFileName;

		public int translateIndex;
	}

	public Entry[] buckets;

	private int count;

	public I18NTranslateFileIdMap(int expectedEntries)
	{
		buckets = new Entry[expectedEntries];
	}

	private int GetOptimalPrime(int min)
	{
		//IL_000d: Field data (rva=0x6f0) could not be found in any section!
		//IL_000d: Field data (rva=0x6f0) could not be found in any section!
		int[] array = new int[21];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		int[] array2 = array;
		foreach (int num in array2)
		{
			if ((float)num > (float)min * 1.3f)
			{
				return num;
			}
		}
		return min * 2;
	}

	public void Add(ulong hash1, ulong hash2, string translateFileName, int translateIndex)
	{
		int num = (int)(hash1 % (ulong)buckets.Length);
		while (buckets[num].hash1 != 0L)
		{
			num = (num + 1) % buckets.Length;
		}
		buckets[num] = new Entry
		{
			hash1 = hash1,
			hash2 = hash2,
			translateFileName = translateFileName,
			translateIndex = translateIndex
		};
		count++;
		CheckCapacity();
	}

	public bool TryGetValue(ulong hash1, ulong hash2, out string translateFileName, out int translateIndex)
	{
		int num = (int)(hash1 % (ulong)buckets.Length);
		while (buckets[num].hash1 != 0L)
		{
			if (buckets[num].hash1 == hash1 && buckets[num].hash2 == hash2)
			{
				translateFileName = buckets[num].translateFileName;
				translateIndex = buckets[num].translateIndex;
				return true;
			}
			num = (num + 1) % buckets.Length;
		}
		translateFileName = string.Empty;
		translateIndex = -1;
		return false;
	}

	private void CheckCapacity()
	{
		if ((float)count > (float)buckets.Length * 0.75f)
		{
			int optimalPrime = GetOptimalPrime(buckets.Length * 2);
			Rehash(optimalPrime);
		}
	}

	private void Rehash(int newSize)
	{
		Entry[] array = buckets;
		buckets = new Entry[newSize];
		Entry[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			Entry entry = array2[i];
			if (entry.hash1 != 0L)
			{
				Add(entry.hash1, entry.hash2, entry.translateFileName, entry.translateIndex);
			}
		}
	}

	public void Clear()
	{
		buckets = Array.Empty<Entry>();
		count = 0;
	}
}
