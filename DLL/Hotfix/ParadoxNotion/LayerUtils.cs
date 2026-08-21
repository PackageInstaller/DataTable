using System.Collections.Generic;
using UnityEngine;

namespace ParadoxNotion;

public static class LayerUtils
{
	public static LayerMask CreateFromNames(params string[] layerNames)
	{
		return LayerNamesToMask(layerNames);
	}

	public static LayerMask CreateFromNumbers(params int[] layerNumbers)
	{
		return LayerNumbersToMask(layerNumbers);
	}

	public static LayerMask LayerNamesToMask(params string[] layerNames)
	{
		LayerMask layerMask = 0;
		foreach (string layerName in layerNames)
		{
			layerMask = (int)layerMask | (1 << LayerMask.NameToLayer(layerName));
		}
		return layerMask;
	}

	public static LayerMask LayerNumbersToMask(params int[] layerNumbers)
	{
		LayerMask layerMask = 0;
		foreach (int num in layerNumbers)
		{
			layerMask = (int)layerMask | (1 << num);
		}
		return layerMask;
	}

	public static LayerMask Inverse(this LayerMask mask)
	{
		return ~(int)mask;
	}

	public static LayerMask AddToMask(this LayerMask mask, params string[] layerNames)
	{
		return (int)mask | (int)LayerNamesToMask(layerNames);
	}

	public static LayerMask RemoveFromMask(this LayerMask mask, params string[] layerNames)
	{
		return ~((int)(LayerMask)(~(int)mask) | (int)LayerNamesToMask(layerNames));
	}

	public static bool ContainsAnyLayer(this LayerMask mask, params string[] layerNames)
	{
		if (layerNames == null)
		{
			return false;
		}
		for (int i = 0; i < layerNames.Length; i++)
		{
			if ((int)mask == ((int)mask | (1 << LayerMask.NameToLayer(layerNames[i]))))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsAllLayers(this LayerMask mask, params string[] layerNames)
	{
		if (layerNames == null)
		{
			return false;
		}
		for (int i = 0; i < layerNames.Length; i++)
		{
			if ((int)mask != ((int)mask | (1 << LayerMask.NameToLayer(layerNames[i]))))
			{
				return false;
			}
		}
		return true;
	}

	public static string[] MaskToNames(this LayerMask mask)
	{
		List<string> list = new List<string>();
		for (int i = 0; i < 32; i++)
		{
			int num = 1 << i;
			if (((int)mask & num) == num)
			{
				string text = LayerMask.LayerToName(i);
				if (!string.IsNullOrEmpty(text))
				{
					list.Add(text);
				}
			}
		}
		return list.ToArray();
	}

	public static string MaskToString(this LayerMask mask)
	{
		return mask.MaskToString(", ");
	}

	public static string MaskToString(this LayerMask mask, string delimiter)
	{
		return string.Join(delimiter, mask.MaskToNames());
	}
}
