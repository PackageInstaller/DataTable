using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BoardPartController : IBoardPartSystem
{
	private readonly Dictionary<string, IBoardPartActionEntryProvider> actionEntryProviders = new Dictionary<string, IBoardPartActionEntryProvider>();

	private readonly Dictionary<string, BoardPartState> partStates = new Dictionary<string, BoardPartState>();

	private readonly List<string> globalBehaviorHistory = new List<string>();

	private readonly List<string> globalAnimationHistory = new List<string>();

	private BoardPartClickContext lastClickContext;

	private BoardPartActionEntry lastSelectedEntry;

	public IReadOnlyDictionary<string, BoardPartState> PartStates => partStates;

	public IReadOnlyList<string> GlobalBehaviorHistory => globalBehaviorHistory;

	public BoardPartClickContext LastClickContext => lastClickContext;

	public BoardPartActionEntry LastSelectedEntry => lastSelectedEntry;

	public void Init(GameObject root)
	{
		InitializeParts(root);
	}

	public BoardPartState HandlePartClick(BoardPartClickContext ctx)
	{
		lastClickContext = ctx;
		lastSelectedEntry = null;
		if (string.IsNullOrEmpty(ctx.PartId))
		{
			return null;
		}
		BoardPartState boardPartState = EnsurePartState(ctx.PartId);
		List<BoardPartActionEntry> matchedEntries = ResolveMatchedEntries(ctx.PartId, boardPartState);
		BoardPartActionEntry boardPartActionEntry = (lastSelectedEntry = SelectWinningEntry(matchedEntries));
		boardPartState.SetLastResolvedEntry(boardPartActionEntry);
		globalBehaviorHistory.Add(ctx.PartId);
		UpdateGlobalBehaviorHistory(boardPartActionEntry);
		UpdateAnimationHistoryHistory(boardPartActionEntry);
		boardPartState.UpdateActionPoolCache(boardPartActionEntry);
		if (boardPartActionEntry.HasConditions && boardPartActionEntry.Conditions.FindIndex((BoardPartCondition c) => c.Type == BoardPartConditionType.LocalAnimationSequence) != -1)
		{
			boardPartState.ClearPlayedHistory();
		}
		return boardPartState;
	}

	public void HandlePartDrag(BoardPartDragContext ctx)
	{
	}

	public void ResetAllStates()
	{
		globalBehaviorHistory.Clear();
		globalAnimationHistory.Clear();
		lastSelectedEntry = null;
		lastClickContext = default(BoardPartClickContext);
		foreach (KeyValuePair<string, BoardPartState> partState in partStates)
		{
			partState.Value?.ResetProgress();
		}
	}

	public void ResetPartState(string partId)
	{
		if (!string.IsNullOrEmpty(partId) && partStates.TryGetValue(partId, out var value) && value != null)
		{
			partStates[partId] = new BoardPartState(partId);
		}
	}

	public void RecordAnimationPlayed(string animationName)
	{
		if (!string.IsNullOrEmpty(animationName))
		{
			globalAnimationHistory.Add(animationName);
		}
	}

	private void InitializeParts(GameObject root)
	{
		actionEntryProviders.Clear();
		if (root == null)
		{
			return;
		}
		MonoBehaviour[] componentsInChildren = root.GetComponentsInChildren<MonoBehaviour>(includeInactive: true);
		foreach (MonoBehaviour monoBehaviour in componentsInChildren)
		{
			if (!(monoBehaviour == null))
			{
				if (monoBehaviour is IBoardPart boardPart)
				{
					boardPart.Init();
				}
				if (monoBehaviour is IBoardPartActionEntryProvider boardPartActionEntryProvider && !string.IsNullOrEmpty(boardPartActionEntryProvider.PartId))
				{
					actionEntryProviders[boardPartActionEntryProvider.PartId] = boardPartActionEntryProvider;
					EnsurePartState(boardPartActionEntryProvider.PartId);
				}
			}
		}
	}

	private List<BoardPartActionEntry> ResolveMatchedEntries(string partId, BoardPartState state)
	{
		List<BoardPartActionEntry> list = new List<BoardPartActionEntry>();
		if (!actionEntryProviders.TryGetValue(partId, out var value) || value == null)
		{
			return list;
		}
		IReadOnlyList<BoardPartActionEntry> actionEntries = value.ActionEntries;
		if (actionEntries == null || actionEntries.Count == 0)
		{
			return list;
		}
		for (int i = 0; i < actionEntries.Count; i++)
		{
			BoardPartActionEntry boardPartActionEntry = actionEntries[i];
			if (boardPartActionEntry != null && boardPartActionEntry.HasActions && IsEntryMatched(boardPartActionEntry, state))
			{
				list.Add(boardPartActionEntry);
			}
		}
		return list;
	}

	private bool IsEntryMatched(BoardPartActionEntry entry, BoardPartState state)
	{
		if (entry == null)
		{
			return false;
		}
		if (!entry.HasConditions)
		{
			return true;
		}
		for (int i = 0; i < entry.Conditions.Count; i++)
		{
			BoardPartCondition condition = entry.Conditions[i];
			if (!IsConditionMatched(condition, state))
			{
				return false;
			}
		}
		return true;
	}

	private bool IsConditionMatched(BoardPartCondition condition, BoardPartState state)
	{
		if (condition == null || state == null)
		{
			return false;
		}
		return condition.Type switch
		{
			BoardPartConditionType.ClickCount => IsSuffixCountMatched(globalBehaviorHistory, (condition.Sequence == null || condition.Sequence.Count == 0) ? state.PartId : condition.Sequence[0], condition.RequiredCount), 
			BoardPartConditionType.ClickSequence => IsSuffixMatched(globalBehaviorHistory, condition.Sequence), 
			BoardPartConditionType.AnimationSequence => IsSuffixMatched(globalAnimationHistory, condition.Sequence), 
			BoardPartConditionType.LocalAnimationSequence => IsSuffixMatched(state.PlayedActionHistory, condition.Sequence), 
			_ => false, 
		};
	}

	private BoardPartActionEntry SelectWinningEntry(List<BoardPartActionEntry> matchedEntries)
	{
		if (matchedEntries == null || matchedEntries.Count == 0)
		{
			return null;
		}
		BoardPartActionEntry boardPartActionEntry = matchedEntries[0];
		int num = GetEntryScore(boardPartActionEntry);
		for (int i = 1; i < matchedEntries.Count; i++)
		{
			BoardPartActionEntry boardPartActionEntry2 = matchedEntries[i];
			int entryScore = GetEntryScore(boardPartActionEntry2);
			if (entryScore > num)
			{
				boardPartActionEntry = boardPartActionEntry2;
				num = entryScore;
			}
		}
		return boardPartActionEntry;
	}

	private int GetEntryScore(BoardPartActionEntry entry)
	{
		if (entry == null || !entry.HasConditions)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < entry.Conditions.Count; i++)
		{
			BoardPartCondition boardPartCondition = entry.Conditions[i];
			if (boardPartCondition == null)
			{
				continue;
			}
			switch (boardPartCondition.Type)
			{
			case BoardPartConditionType.ClickSequence:
				if (boardPartCondition.Sequence != null)
				{
					num += boardPartCondition.Sequence.Count * 100;
				}
				break;
			case BoardPartConditionType.ClickCount:
				num += boardPartCondition.RequiredCount;
				break;
			case BoardPartConditionType.AnimationSequence:
				if (boardPartCondition.Sequence != null)
				{
					num += boardPartCondition.Sequence.Count * 50;
				}
				break;
			case BoardPartConditionType.LocalAnimationSequence:
				if (boardPartCondition.Sequence != null)
				{
					num += boardPartCondition.Sequence.Count * 50;
				}
				break;
			}
		}
		return num;
	}

	private void UpdateGlobalBehaviorHistory(BoardPartActionEntry entry)
	{
		if (entry != null && entry.HasConditions)
		{
			globalBehaviorHistory.Clear();
		}
		else
		{
			TrimGlobalBehaviorHistoryByMaxCount();
		}
	}

	private void TrimGlobalBehaviorHistoryByMaxCount()
	{
		int globalMaxRequiredMatchCount = GetGlobalMaxRequiredMatchCount();
		if (globalMaxRequiredMatchCount <= 0)
		{
			globalBehaviorHistory.Clear();
			return;
		}
		int num = globalBehaviorHistory.Count - globalMaxRequiredMatchCount;
		if (num > 0)
		{
			globalBehaviorHistory.RemoveRange(0, num);
		}
	}

	private void UpdateAnimationHistoryHistory(BoardPartActionEntry entry)
	{
		if (entry != null && entry.HasConditions && entry.Conditions.FindIndex((BoardPartCondition c) => c.Type == BoardPartConditionType.AnimationSequence) != -1)
		{
			globalAnimationHistory.Clear();
		}
		else
		{
			TrimGlobalAnimationHistoryByMaxCount();
		}
	}

	private void TrimGlobalAnimationHistoryByMaxCount()
	{
		int globalMaxAnimationRequiredMatchCount = GetGlobalMaxAnimationRequiredMatchCount();
		if (globalMaxAnimationRequiredMatchCount <= 0)
		{
			globalAnimationHistory.Clear();
			return;
		}
		int num = globalAnimationHistory.Count - globalMaxAnimationRequiredMatchCount;
		if (num > 0)
		{
			globalAnimationHistory.RemoveRange(0, num);
		}
	}

	private int GetGlobalMaxRequiredMatchCount()
	{
		int num = 0;
		foreach (KeyValuePair<string, IBoardPartActionEntryProvider> actionEntryProvider in actionEntryProviders)
		{
			IBoardPartActionEntryProvider value = actionEntryProvider.Value;
			if (value != null && value.ActionEntries != null)
			{
				IReadOnlyList<BoardPartActionEntry> actionEntries = value.ActionEntries;
				for (int i = 0; i < actionEntries.Count; i++)
				{
					num = Mathf.Max(num, GetRequiredMatchCount(actionEntries[i]));
				}
			}
		}
		return num;
	}

	private int GetGlobalMaxAnimationRequiredMatchCount()
	{
		int num = 0;
		foreach (KeyValuePair<string, IBoardPartActionEntryProvider> actionEntryProvider in actionEntryProviders)
		{
			IBoardPartActionEntryProvider value = actionEntryProvider.Value;
			if (value != null && value.ActionEntries != null)
			{
				IReadOnlyList<BoardPartActionEntry> actionEntries = value.ActionEntries;
				for (int i = 0; i < actionEntries.Count; i++)
				{
					num = Mathf.Max(num, GetAnimationRequiredMatchCount(actionEntries[i]));
				}
			}
		}
		return num;
	}

	private int GetRequiredMatchCount(BoardPartActionEntry entry)
	{
		if (entry == null || !entry.HasConditions)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < entry.Conditions.Count; i++)
		{
			BoardPartCondition boardPartCondition = entry.Conditions[i];
			if (boardPartCondition == null)
			{
				continue;
			}
			switch (boardPartCondition.Type)
			{
			case BoardPartConditionType.ClickCount:
				num = Mathf.Max(num, boardPartCondition.RequiredCount);
				break;
			case BoardPartConditionType.ClickSequence:
				if (boardPartCondition.Sequence != null)
				{
					num = Mathf.Max(num, boardPartCondition.Sequence.Count);
				}
				break;
			}
		}
		return num;
	}

	private int GetAnimationRequiredMatchCount(BoardPartActionEntry entry)
	{
		if (entry == null || !entry.HasConditions)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < entry.Conditions.Count; i++)
		{
			BoardPartCondition boardPartCondition = entry.Conditions[i];
			if (boardPartCondition != null && boardPartCondition.Type == BoardPartConditionType.AnimationSequence && boardPartCondition.Sequence != null)
			{
				num = Mathf.Max(num, boardPartCondition.Sequence.Count);
			}
		}
		return num;
	}

	private bool IsSuffixMatched(List<string> history, List<string> sequence)
	{
		if (history == null || sequence == null)
		{
			return false;
		}
		if (sequence.Count == 0 || history.Count < sequence.Count)
		{
			return false;
		}
		int num = history.Count - sequence.Count;
		for (int i = 0; i < sequence.Count; i++)
		{
			if (!string.Equals(history[num + i], sequence[i], StringComparison.Ordinal))
			{
				return false;
			}
		}
		return true;
	}

	private bool IsSuffixCountMatched(List<string> history, string partId, int count)
	{
		if (history == null || partId == null)
		{
			return false;
		}
		if (history.Count == 0 || history.Count < count)
		{
			return false;
		}
		int num = history.Count - count;
		for (int i = 0; i < count; i++)
		{
			if (!string.Equals(history[num + i], partId, StringComparison.Ordinal))
			{
				return false;
			}
		}
		return true;
	}

	private BoardPartState EnsurePartState(string partId)
	{
		if (!partStates.TryGetValue(partId, out var value) || value == null)
		{
			value = new BoardPartState(partId);
			partStates[partId] = value;
		}
		return value;
	}
}
