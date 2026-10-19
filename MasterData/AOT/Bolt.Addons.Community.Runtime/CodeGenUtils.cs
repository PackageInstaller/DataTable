using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public static class CodeGenUtils
{
	public static IList MergeLists(params IList[] lists)
	{
		List<object> list = new List<object>();
		foreach (IList item in lists)
		{
			list.Add(item);
		}
		return list;
	}

	public static AotDictionary MergeDictionaries(params IDictionary[] dictionaries)
	{
		AotDictionary aotDictionary = new AotDictionary();
		foreach (IDictionary dictionary in dictionaries)
		{
			for (int j = 0; j < dictionary.Count; j++)
			{
				if (!(aotDictionary.Keys as List<object>).Contains((aotDictionary.Keys as List<object>)[j]))
				{
					aotDictionary.Add((aotDictionary.Keys as List<object>)[j], dictionary[j]);
				}
				else
				{
					Debug.LogError($"Could not add {(aotDictionary.Keys as List<object>)[j]} to merged dictionary the key already exists");
				}
			}
		}
		return aotDictionary;
	}

	public static float CalculateAverage(params float[] values)
	{
		if (values.Length == 0)
		{
			return 0f;
		}
		float num = 0f;
		foreach (float num2 in values)
		{
			num += num2;
		}
		return num / (float)values.Length;
	}

	public static float CalculateMax(params float[] values)
	{
		if (values.Length == 0)
		{
			return 0f;
		}
		return values.Max();
	}

	public static float CalculateMin(params float[] values)
	{
		if (values.Length == 0)
		{
			return 0f;
		}
		return values.Min();
	}

	public static float Normalize(float value)
	{
		if (value == 0f)
		{
			return 0f;
		}
		return value / Mathf.Abs(value);
	}
}
