using System;
using ACT.NPC.Conditions;
using UnityEngine;

namespace ACT.NPC;

[Serializable]
public struct NpcConditionWrap
{
	[SerializeField]
	private int activeConditionIndex;

	public MissionDurationCondition missionDuration;

	public MissionReceiveCondition missionReceive;

	public MissionCompleteCondition missionComplete;

	public KeyPointPassCondition keyPointPass;

	public PlayingDialogueCondition playingDialogue;

	public AlwaysFalse alwaysFalse;

	public NpcBehaviorStateCondition behaviorState;

	public NpcReachedPatrolPointCondition reachedPatrolPoint;

	public MissionConditionActiveCondition missionConditionActive;

	public int ActiveConditionIndex => activeConditionIndex;

	public static bool TryCreate(NpcConditionUnit condition, out NpcConditionWrap conditionWrap)
	{
		conditionWrap = default;
		return conditionWrap.TrySetActiveCondition(condition);
	}

	public bool TrySetActiveCondition(Type conditionType, out NpcConditionUnit condition, out bool created)
	{
		condition = GetConditionByType(conditionType);
		created = condition == null;
		if (condition == null)
		{
			condition = Activator.CreateInstance(conditionType) as NpcConditionUnit;
			if (condition == null || !TrySetActiveCondition(condition))
			{
				return false;
			}
		}
		else
		{
			activeConditionIndex = condition.ConditionId;
		}
		return true;
	}

	public bool TrySetActiveCondition(NpcConditionUnit condition)
	{
		if (!(condition is MissionDurationCondition missionDurationCondition))
		{
			if (!(condition is MissionReceiveCondition missionReceiveCondition))
			{
				if (!(condition is MissionCompleteCondition missionCompleteCondition))
				{
					if (!(condition is KeyPointPassCondition keyPointPassCondition))
					{
						if (!(condition is PlayingDialogueCondition playingDialogueCondition))
						{
							if (!(condition is AlwaysFalse alwaysFalse))
							{
								if (!(condition is NpcBehaviorStateCondition npcBehaviorStateCondition))
								{
									if (!(condition is NpcReachedPatrolPointCondition npcReachedPatrolPointCondition))
									{
										if (!(condition is MissionConditionActiveCondition missionConditionActiveCondition))
										{
											return false;
										}
										missionConditionActive = missionConditionActiveCondition;
									}
									else
									{
										reachedPatrolPoint = npcReachedPatrolPointCondition;
									}
								}
								else
								{
									behaviorState = npcBehaviorStateCondition;
								}
							}
							else
							{
								this.alwaysFalse = alwaysFalse;
							}
						}
						else
						{
							playingDialogue = playingDialogueCondition;
						}
					}
					else
					{
						keyPointPass = keyPointPassCondition;
					}
				}
				else
				{
					missionComplete = missionCompleteCondition;
				}
			}
			else
			{
				missionReceive = missionReceiveCondition;
			}
		}
		else
		{
			missionDuration = missionDurationCondition;
		}
		activeConditionIndex = condition.ConditionId;
		return true;
	}

	public NpcConditionUnit GetCondition()
	{
		NpcConditionUnit conditionByIndex = GetConditionByIndex(activeConditionIndex);
		if (conditionByIndex != null)
		{
			return conditionByIndex;
		}
		int[] all = NpcConditionIds.All;
		foreach (int conditionIndex in all)
		{
			conditionByIndex = GetConditionByIndex(conditionIndex);
			if (conditionByIndex != null)
			{
				activeConditionIndex = conditionIndex;
				return conditionByIndex;
			}
		}
		return null;
	}

	private NpcConditionUnit GetConditionByIndex(int conditionIndex)
	{
		return conditionIndex switch
		{
			1 => (NpcConditionUnit)missionDuration, 
			2 => missionReceive, 
			3 => missionComplete, 
			4 => keyPointPass, 
			5 => playingDialogue, 
			6 => alwaysFalse, 
			7 => behaviorState, 
			8 => reachedPatrolPoint, 
			10 => missionConditionActive, 
			_ => null, 
		};
	}

	private NpcConditionUnit GetConditionByType(Type conditionType)
	{
		if (conditionType == typeof(MissionDurationCondition))
		{
			return missionDuration;
		}
		if (conditionType == typeof(MissionReceiveCondition))
		{
			return missionReceive;
		}
		if (conditionType == typeof(MissionCompleteCondition))
		{
			return missionComplete;
		}
		if (conditionType == typeof(KeyPointPassCondition))
		{
			return keyPointPass;
		}
		if (conditionType == typeof(PlayingDialogueCondition))
		{
			return playingDialogue;
		}
		if (conditionType == typeof(AlwaysFalse))
		{
			return alwaysFalse;
		}
		if (conditionType == typeof(NpcBehaviorStateCondition))
		{
			return behaviorState;
		}
		if (conditionType == typeof(NpcReachedPatrolPointCondition))
		{
			return reachedPatrolPoint;
		}
		if (conditionType == typeof(MissionConditionActiveCondition))
		{
			return missionConditionActive;
		}
		return null;
	}
}
