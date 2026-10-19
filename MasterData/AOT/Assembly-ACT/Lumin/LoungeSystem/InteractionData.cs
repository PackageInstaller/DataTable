using System;
using System.Collections.Generic;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class InteractionData
{
	[SerializeField]
	private string interactionName;

	[SerializeField]
	private LoungeDefine.InteractionType interactionType;

	[SerializeField]
	private int favorValueChange;

	[SerializeField]
	private int requiredFavorLevel;

	[SerializeField]
	private int cooldownMinutes;

	[SerializeField]
	private int priority;

	[SerializeField]
	private int storyGroupId;

	[SerializeField]
	private Dictionary<LoungeDefine.MoodState, float> moodMultipliers;

	public string InteractionName => interactionName;

	public LoungeDefine.InteractionType InteractionType => interactionType;

	public int FavorValueChange => favorValueChange;

	public int RequiredFavorLevel => requiredFavorLevel;

	public int CooldownMinutes => cooldownMinutes;

	public int Priority => priority;

	public int StoryGroupId => storyGroupId;

	public Dictionary<LoungeDefine.MoodState, float> MoodMultipliers => moodMultipliers ?? (moodMultipliers = new Dictionary<LoungeDefine.MoodState, float>());

	public InteractionData(LoungeDefine.InteractionType type, int curStoryGroupId = 0)
	{
		interactionName = LoungeUtility.GetInteractionTypeName(type, curStoryGroupId);
		interactionType = type;
		storyGroupId = curStoryGroupId;
		priority = (int)type;
		moodMultipliers = new Dictionary<LoungeDefine.MoodState, float>
		{
			{
				LoungeDefine.MoodState.VeryHappy,
				1.5f
			},
			{
				LoungeDefine.MoodState.Happy,
				1.2f
			},
			{
				LoungeDefine.MoodState.Normal,
				1f
			},
			{
				LoungeDefine.MoodState.Unhappy,
				0.8f
			},
			{
				LoungeDefine.MoodState.Sad,
				0.5f
			}
		};
	}

	public int CalculateActualFavorChange(LoungeDefine.MoodState mood)
	{
		if (moodMultipliers.TryGetValue(mood, out var value))
		{
			return Mathf.RoundToInt((float)favorValueChange * value);
		}
		return favorValueChange;
	}

	public bool CheckIsGlobalStory()
	{
		if (interactionType == LoungeDefine.InteractionType.TriggerGlobalStory && storyGroupId != 0)
		{
			return true;
		}
		return false;
	}
}
