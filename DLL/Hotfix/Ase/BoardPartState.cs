using System;
using System.Collections.Generic;

namespace Ase;

public class BoardPartState
{
	public string PartId { get; private set; }

	public List<string> PlayedActionHistory { get; } = new List<string>();

	public List<string> ActionPoolCache { get; } = new List<string>();

	public BoardPartActionEntry LastResolvedEntry { get; private set; }

	public BoardPartActionEntry LastCachedEntry { get; private set; }

	public BoardPartState(string partId)
	{
		PartId = partId;
	}

	public void SetLastResolvedEntry(BoardPartActionEntry entry)
	{
		LastResolvedEntry = entry;
	}

	public void AppendResolvedActions(string action)
	{
		if (!string.IsNullOrEmpty(action))
		{
			PlayedActionHistory.Add(action);
		}
	}

	public void ClearPlayedHistory()
	{
		PlayedActionHistory.Clear();
	}

	public void UpdateActionPoolCache(BoardPartActionEntry currentEntry)
	{
		if (!ShouldRefillActionPoolCache(currentEntry))
		{
			return;
		}
		LastCachedEntry = currentEntry;
		ActionPoolCache.Clear();
		if (currentEntry == null || currentEntry.Actions == null)
		{
			return;
		}
		for (int i = 0; i < currentEntry.Actions.Count; i++)
		{
			string text = currentEntry.Actions[i];
			if (!string.IsNullOrEmpty(text))
			{
				ActionPoolCache.Add(text);
			}
		}
	}

	private bool ShouldRefillActionPoolCache(BoardPartActionEntry currentEntry)
	{
		if (currentEntry == null)
		{
			return false;
		}
		if (IsEntryNotMatch(LastCachedEntry, currentEntry))
		{
			return true;
		}
		if (ActionPoolCache != null)
		{
			return ActionPoolCache.Count == 0;
		}
		return true;
	}

	private bool IsEntryNotMatch(BoardPartActionEntry entry1, BoardPartActionEntry entry2)
	{
		if (entry1 == null && entry2 == null)
		{
			return false;
		}
		if (entry1 == null || entry2 == null)
		{
			return true;
		}
		if (entry1.PlayMode != entry2.PlayMode)
		{
			return true;
		}
		if (entry1.Actions.Count != entry2.Actions.Count)
		{
			return true;
		}
		if (entry1.Conditions.Count != entry2.Conditions.Count)
		{
			return true;
		}
		if (!IsListMatch(entry1.Actions, entry2.Actions))
		{
			return true;
		}
		if (!IsConditionListMatch(entry1.Conditions, entry2.Conditions))
		{
			return true;
		}
		return false;
	}

	private bool IsListMatch(List<string> list1, List<string> list2)
	{
		if (list1 == null && list2 == null)
		{
			return true;
		}
		if (list1 == null || list2 == null)
		{
			return false;
		}
		if (list1.Count != list2.Count)
		{
			return false;
		}
		for (int i = 0; i < list1.Count; i++)
		{
			string s = list1[i];
			if (!list2.Contains(s) || list1.FindAll((string x) => x == s).Count != list2.FindAll((string x) => x == s).Count)
			{
				return false;
			}
		}
		return true;
	}

	private bool IsConditionListMatch(List<BoardPartCondition> list1, List<BoardPartCondition> list2)
	{
		if (list1 == null && list2 == null)
		{
			return true;
		}
		if (list1 == null || list2 == null)
		{
			return false;
		}
		if (list1.Count != list2.Count)
		{
			return false;
		}
		for (int i = 0; i < list1.Count; i++)
		{
			BoardPartCondition s = list1[i];
			if (list1.FindAll((BoardPartCondition x) => x.Type == s.Type && x.RequiredCount == s.RequiredCount && IsListMatch(x.Sequence, s.Sequence)).Count != list2.FindAll((BoardPartCondition x) => x.Type == s.Type && x.RequiredCount == s.RequiredCount && IsListMatch(x.Sequence, s.Sequence)).Count)
			{
				return false;
			}
		}
		return true;
	}

	public string GetAndRemoveRandomFromActionPoolCache(Random random)
	{
		if (random == null || ActionPoolCache.Count == 0)
		{
			return string.Empty;
		}
		int index = random.Next(ActionPoolCache.Count);
		string result = ActionPoolCache[index];
		ActionPoolCache.RemoveAt(index);
		return result;
	}

	public void RemoveActionFromActionPoolCache(string actionName)
	{
		if (!string.IsNullOrEmpty(actionName) && ActionPoolCache.Count != 0)
		{
			ActionPoolCache.Remove(actionName);
		}
	}

	public void ResetProgress()
	{
		PlayedActionHistory.Clear();
		ActionPoolCache.Clear();
		LastResolvedEntry = null;
		LastCachedEntry = null;
	}
}
