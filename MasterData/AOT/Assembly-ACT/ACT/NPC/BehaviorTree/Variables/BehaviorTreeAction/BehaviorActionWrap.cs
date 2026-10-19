using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;

[Serializable]
public sealed class BehaviorActionWrap
{
	private static readonly Type[] SupportedActionTypes = new Type[2]
	{
		typeof(ActionSendKeyPoint),
		typeof(ActionTurnTo)
	};

	[SerializeField]
	private int activeActionIndex = -1;

	public ActionSendKeyPoint actionSendKeyPoint;

	public ActionTurnTo actionTurnTo;

	public static IReadOnlyList<Type> ActionTypes => SupportedActionTypes;

	public static BehaviorActionWrap Create(BehaviorActionBase action)
	{
		BehaviorActionWrap behaviorActionWrap = new BehaviorActionWrap();
		if (!behaviorActionWrap.TrySetAction(action))
		{
			return null;
		}
		return behaviorActionWrap;
	}

	public BehaviorActionBase GetAction()
	{
		BehaviorActionBase actionByIndex = GetActionByIndex(activeActionIndex);
		if (actionByIndex != null)
		{
			return actionByIndex;
		}
		for (int i = 0; i < SupportedActionTypes.Length; i++)
		{
			actionByIndex = GetActionByIndex(i);
			if (actionByIndex != null)
			{
				activeActionIndex = i;
				return actionByIndex;
			}
		}
		return null;
	}

	public bool TrySetAction(BehaviorActionBase action)
	{
		this.actionSendKeyPoint = null;
		this.actionTurnTo = null;
		if (!(action is ActionSendKeyPoint actionSendKeyPoint))
		{
			if (action is ActionTurnTo actionTurnTo)
			{
				activeActionIndex = 1;
				this.actionTurnTo = actionTurnTo;
				return true;
			}
			activeActionIndex = -1;
			return false;
		}
		activeActionIndex = 0;
		this.actionSendKeyPoint = actionSendKeyPoint;
		return true;
	}

	private BehaviorActionBase GetActionByIndex(int actionIndex)
	{
		return actionIndex switch
		{
			0 => (BehaviorActionBase)actionSendKeyPoint, 
			1 => actionTurnTo, 
			_ => null, 
		};
	}
}
