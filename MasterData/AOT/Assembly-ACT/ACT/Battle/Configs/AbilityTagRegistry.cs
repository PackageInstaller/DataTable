using System;
using System.Collections.Generic;

namespace ACT.Battle.Configs;

public static class AbilityTagRegistry
{
	public const int InvalidTagId = 0;

	public const int CustomTagBase = 1024;

	private static readonly Dictionary<string, int> s_CustomTagToId = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

	private static readonly Dictionary<int, string> s_IdToCustomTag = new Dictionary<int, string>();

	private static int s_NextCustomTagId = 1024;

	private static readonly object s_Lock = new object();

	private static string NormalizeTag(string tag)
	{
		if (!string.IsNullOrWhiteSpace(tag))
		{
			return tag.Trim();
		}
		return null;
	}

	public static bool TryGetCustomTagId(string tag, out int tagId)
	{
		tag = NormalizeTag(tag);
		if (tag == null)
		{
			tagId = 0;
			return false;
		}
		lock (s_Lock)
		{
			return s_CustomTagToId.TryGetValue(tag, out tagId);
		}
	}

	public static int[] CompileCustomTagIds(string[] customTags)
	{
		if (customTags == null || customTags.Length == 0)
		{
			return Array.Empty<int>();
		}
		lock (s_Lock)
		{
			List<int> list = new List<int>(customTags.Length);
			HashSet<int> hashSet = new HashSet<int>();
			for (int i = 0; i < customTags.Length; i++)
			{
				string text = NormalizeTag(customTags[i]);
				if (text != null)
				{
					if (!s_CustomTagToId.TryGetValue(text, out var value))
					{
						value = s_NextCustomTagId++;
						s_CustomTagToId.Add(text, value);
						s_IdToCustomTag.Add(value, text);
					}
					if (hashSet.Add(value))
					{
						list.Add(value);
					}
				}
			}
			return (list.Count == 0) ? Array.Empty<int>() : list.ToArray();
		}
	}

	public static string GetTagDisplayName(int tagId)
	{
		lock (s_Lock)
		{
			if (s_IdToCustomTag.TryGetValue(tagId, out var value))
			{
				return value;
			}
		}
		return $"Tag#{tagId}";
	}
}
