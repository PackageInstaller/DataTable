using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI.AOT;

public static class AnnouncementRedDot
{
	private const string REDDOT_KEY = "ANN_READ";

	private const string TIMELINE_KEY = "ANN_TIMELINE_READ";

	private const string KNOWN_ANN_GAME_HCLR_KEY = "ANN_KNOWN_GAME_HCLR";

	private const string KNOWN_ANN_GAME_AOT_KEY = "ANN_KNOWN_GAME_AOT";

	private const string KNOWN_ANN_ACT_KEY = "ANN_KNOWN_ACT";

	private const string KNOWN_ANN_TIMELINE_KEY = "ANN_KNOWN_TIMELINE";

	public static Action OnRedDotChanged;

	private static HashSet<string> ReadIds { get; set; } = new HashSet<string>();

	private static HashSet<string> KnownGameIdsHCLR { get; set; } = new HashSet<string>();

	private static HashSet<string> KnownGameIdsAOT { get; set; } = new HashSet<string>();

	private static HashSet<string> KnownActivityIds { get; set; } = new HashSet<string>();

	private static string CurrentTimelineId { get; set; } = "";

	private static string KnownTimelineId { get; set; } = "";

	public static bool IsAllRead(bool includeGame, bool includeActivity, bool includeTimeline, AnnouncementPlace? gamePlace = null)
	{
		if (includeGame)
		{
			bool flag = !gamePlace.HasValue || gamePlace == AnnouncementPlace.HCLR;
			bool flag2 = !gamePlace.HasValue || gamePlace == AnnouncementPlace.AOT;
			if (flag)
			{
				foreach (string item in KnownGameIdsHCLR)
				{
					if (!ReadIds.Contains(item))
					{
						return false;
					}
				}
			}
			if (flag2)
			{
				foreach (string item2 in KnownGameIdsAOT)
				{
					if (!ReadIds.Contains(item2))
					{
						return false;
					}
				}
			}
		}
		if (includeActivity)
		{
			foreach (string knownActivityId in KnownActivityIds)
			{
				if (!ReadIds.Contains(knownActivityId))
				{
					return false;
				}
			}
		}
		if (includeTimeline && !string.IsNullOrWhiteSpace(KnownTimelineId) && CurrentTimelineId != KnownTimelineId)
		{
			return false;
		}
		return true;
	}

	public static void RecordRedDot(string key)
	{
		if (ReadIds.Add(key))
		{
			OnRedDotChanged?.Invoke();
		}
		Save();
	}

	public static void RecordKnownIds(bool isGameAnnouncement, List<string> keys, AnnouncementPlace place = AnnouncementPlace.HCLR)
	{
		if (isGameAnnouncement)
		{
			HashSet<string> hashSet = ((place == AnnouncementPlace.AOT) ? KnownGameIdsAOT : KnownGameIdsHCLR);
			hashSet.Clear();
			hashSet.UnionWith(keys);
		}
		else
		{
			KnownActivityIds.Clear();
			KnownActivityIds.UnionWith(keys);
		}
		Save();
	}

	public static void RecordTimelineId(string id)
	{
		CurrentTimelineId = id;
		PlayerPrefs.SetString("ANN_TIMELINE_READ", id);
		PlayerPrefs.Save();
		OnRedDotChanged?.Invoke();
	}

	public static void SetKnownTimelineId(string id)
	{
		KnownTimelineId = id;
		PlayerPrefs.SetString("ANN_KNOWN_TIMELINE", id);
		PlayerPrefs.Save();
		OnRedDotChanged?.Invoke();
	}

	public static void AddKnownId(bool isGameAnnouncement, string key, AnnouncementPlace place = AnnouncementPlace.HCLR)
	{
		HashSet<string> hashSet;
		if (isGameAnnouncement)
		{
			hashSet = ((place == AnnouncementPlace.AOT) ? KnownGameIdsAOT : KnownGameIdsHCLR);
		}
		else
		{
			hashSet = KnownActivityIds;
		}
		hashSet.Add(key);
		Save();
	}

	public static bool IsRecorded(string key)
	{
		return ReadIds.Contains(key);
	}

	public static void Save()
	{
		Clean();
		Save("ANN_READ", ReadIds);
		Save("ANN_KNOWN_GAME_HCLR", KnownGameIdsHCLR);
		Save("ANN_KNOWN_GAME_AOT", KnownGameIdsAOT);
		Save("ANN_KNOWN_ACT", KnownActivityIds);
	}

	private static void Save(string key, IEnumerable<string> val)
	{
		PlayerPrefs.SetString(key, string.Join(',', val));
	}

	public static void Clean()
	{
		ReadIds.RemoveWhere((string kk) => !KnownGameIdsHCLR.Contains(kk) && !KnownGameIdsAOT.Contains(kk) && !KnownActivityIds.Contains(kk));
	}

	public static void Clear()
	{
		PlayerPrefs.DeleteKey("ANN_READ");
		PlayerPrefs.DeleteKey("ANN_KNOWN_GAME_HCLR");
		PlayerPrefs.DeleteKey("ANN_KNOWN_GAME_AOT");
		PlayerPrefs.DeleteKey("ANN_KNOWN_ACT");
		PlayerPrefs.DeleteKey("ANN_TIMELINE_READ");
		PlayerPrefs.DeleteKey("ANN_KNOWN_TIMELINE");
	}

	public static void Load()
	{
		ReadIds = Load("ANN_READ");
		KnownGameIdsHCLR = Load("ANN_KNOWN_GAME_HCLR");
		KnownGameIdsAOT = Load("ANN_KNOWN_GAME_AOT");
		KnownActivityIds = Load("ANN_KNOWN_ACT");
		CurrentTimelineId = PlayerPrefs.GetString("ANN_TIMELINE_READ", "");
		KnownTimelineId = PlayerPrefs.GetString("ANN_KNOWN_TIMELINE", "");
	}

	private static HashSet<string> Load(string key)
	{
		HashSet<string> hashSet = new HashSet<string>();
		string text = PlayerPrefs.GetString(key, "");
		if (!string.IsNullOrWhiteSpace(text))
		{
			string[] array = text.Split(',');
			foreach (string text2 in array)
			{
				if (!string.IsNullOrWhiteSpace(text2))
				{
					hashSet.Add(text2.Trim());
				}
			}
		}
		return hashSet;
	}
}
