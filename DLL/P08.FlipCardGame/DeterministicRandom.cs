using System;
using System.Collections.Generic;

public class DeterministicRandom
{
	[Serializable]
	public class RandomState
	{
		public int seed;

		public int callCount;

		public string name;

		public DateTime saveTime;
	}

	private int _seed;

	private Random _random;

	private Dictionary<string, Random> _namedRandoms;

	private Dictionary<string, RandomState> _savedStates;

	public int Seed => _seed;

	public Random RandomInstance => _random;

	public DeterministicRandom(int seed = 12345)
	{
		_seed = seed;
		Initialize(seed);
	}

	public void Initialize(int seed)
	{
		_seed = seed;
		_random = new Random(seed);
		_namedRandoms = new Dictionary<string, Random>();
		_savedStates = new Dictionary<string, RandomState>();
	}

	public void SetSeed(int seed)
	{
		Initialize(seed);
	}

	public void Restart()
	{
		Initialize(_seed);
	}

	public Random GetNamedRandom(string name, int? seed = null)
	{
		if (_namedRandoms.ContainsKey(name))
		{
			return _namedRandoms[name];
		}
		Random random = new Random(seed ?? (_seed + name.GetHashCode()));
		_namedRandoms[name] = random;
		return random;
	}

	public int Range(int min, int max, string randomName = null)
	{
		return GetRandomByName(randomName).Next(min, max);
	}

	public int Range(int max, string randomName = null)
	{
		return Range(0, max, randomName);
	}

	public float Value(string randomName = null)
	{
		return (float)GetRandomByName(randomName).NextDouble();
	}

	public float Range(float min, float max, string randomName = null)
	{
		Random randomByName = GetRandomByName(randomName);
		return min + (float)randomByName.NextDouble() * (max - min);
	}

	public bool Boolean(string randomName = null)
	{
		return GetRandomByName(randomName).Next(0, 2) == 1;
	}

	public bool Chance(float probability, string randomName = null)
	{
		if (probability >= 1f)
		{
			return true;
		}
		if (probability <= 0f)
		{
			return false;
		}
		return GetRandomByName(randomName).NextDouble() < (double)probability;
	}

	public T RandomChoice<T>(T[] array, string randomName = null)
	{
		if (array == null || array.Length == 0)
		{
			return default(T);
		}
		int num = GetRandomByName(randomName).Next(0, array.Length);
		return array[num];
	}

	public T RandomChoice<T>(List<T> list, string randomName = null)
	{
		if (list == null || list.Count == 0)
		{
			return default(T);
		}
		int index = GetRandomByName(randomName).Next(0, list.Count);
		return list[index];
	}

	public void Shuffle<T>(IList<T> list, string randomName = null)
	{
		Random randomByName = GetRandomByName(randomName);
		for (int num = list.Count - 1; num > 0; num--)
		{
			int index = randomByName.Next(0, num + 1);
			T value = list[num];
			list[num] = list[index];
			list[index] = value;
		}
	}

	public T[] Shuffled<T>(T[] array, string randomName = null)
	{
		T[] array2 = new T[array.Length];
		Array.Copy(array, array2, array.Length);
		Shuffle(array2, randomName);
		return array2;
	}

	public List<T> RandomSample<T>(List<T> list, int count, string randomName = null)
	{
		if (count >= list.Count)
		{
			return new List<T>(list);
		}
		List<T> list2 = new List<T>(list);
		Shuffle(list2, randomName);
		return list2.GetRange(0, count);
	}

	public T WeightedRandom<T>(Dictionary<T, float> weightedItems, string randomName = null)
	{
		float num = 0f;
		foreach (KeyValuePair<T, float> weightedItem in weightedItems)
		{
			num += weightedItem.Value;
		}
		float num2 = Range(0f, num, randomName);
		float num3 = 0f;
		foreach (KeyValuePair<T, float> weightedItem2 in weightedItems)
		{
			num3 += weightedItem2.Value;
			if (num2 <= num3)
			{
				return weightedItem2.Key;
			}
		}
		return default(T);
	}

	public void SaveState(string stateName, string randomName = null)
	{
		RandomState value = new RandomState
		{
			seed = _seed,
			callCount = 0,
			name = (randomName ?? "global"),
			saveTime = DateTime.Now
		};
		_savedStates[stateName] = value;
	}

	public void LoadState(string stateName)
	{
		if (_savedStates.ContainsKey(stateName))
		{
			RandomState randomState = _savedStates[stateName];
			Initialize(randomState.seed);
		}
	}

	public string[] GetSavedStateNames()
	{
		string[] array = new string[_savedStates.Count];
		_savedStates.Keys.CopyTo(array, 0);
		return array;
	}

	public void RemoveState(string stateName)
	{
		if (_savedStates.ContainsKey(stateName))
		{
			_savedStates.Remove(stateName);
		}
	}

	private Random GetRandomByName(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return _random;
		}
		return GetNamedRandom(name);
	}
}
