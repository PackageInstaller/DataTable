using System.Collections.Generic;
using UnityEngine;

namespace ACT.Core;

public static class PropertyDirtyTracker
{
	private const int k_MaxCascadeIterations = 10;

	private static List<Property> s_DirtyList = new List<Property>(128);

	private static List<Property> s_FlushBuffer = new List<Property>(128);

	internal static void MarkDirty(Property p)
	{
		s_DirtyList.Add(p);
	}

	internal static void Remove(Property p)
	{
		for (int num = s_DirtyList.Count - 1; num >= 0; num--)
		{
			if (s_DirtyList[num] == p)
			{
				s_DirtyList[num] = null;
				break;
			}
		}
	}

	public static void FlushAll()
	{
		int num = 0;
		while (s_DirtyList.Count > 0)
		{
			if (num >= 10)
			{
				Debug.LogError("[Property] Cascade flush exceeded " + 10 + " iterations — possible circular dependency! Remaining dirty count: " + s_DirtyList.Count + ". Clearing to prevent infinite loop.");
				s_DirtyList.Clear();
				break;
			}
			List<Property> list = s_FlushBuffer;
			s_FlushBuffer = s_DirtyList;
			s_DirtyList = list;
			s_DirtyList.Clear();
			for (int i = 0; i < s_FlushBuffer.Count; i++)
			{
				if (s_FlushBuffer[i] != null)
				{
					s_FlushBuffer[i].Flush();
				}
			}
			s_FlushBuffer.Clear();
			num++;
		}
	}

	public static void Clear()
	{
		s_DirtyList.Clear();
		s_FlushBuffer.Clear();
	}
}
