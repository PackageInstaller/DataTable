using System;
using UnityEngine;

public class TriggerConditionBase : LogicEntity
{
	[HideInInspector]
	public GameObject triggerOwner;

	public Action triggerAction;

	protected bool isTriggered;

	protected int processValue;

	protected TriggerManager.triggerState currentSate = TriggerManager.triggerState.none;

	public int x { get; protected set; } = -1;

	public int y { get; protected set; } = -1;

	public virtual void Initialize(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	public virtual void StateReset()
	{
		isTriggered = false;
		triggerOwner = null;
	}

	public virtual void SyncPosition()
	{
	}

	public bool CanTrigger()
	{
		if (currentSate == TriggerManager.triggerState.active)
		{
			return !isTriggered;
		}
		return false;
	}

	public virtual void OnTrigger()
	{
		if (CanTrigger())
		{
			isTriggered = true;
			triggerAction?.Invoke();
		}
	}

	public virtual void DisableTrigger()
	{
	}

	public virtual void ToActive()
	{
		StateReset();
		currentSate = TriggerManager.triggerState.active;
	}

	public virtual void ToDeActive()
	{
		DisableTrigger();
		currentSate = TriggerManager.triggerState.deActive;
		processValue = 0;
	}

	public virtual void OnPause()
	{
		DisableTrigger();
		currentSate = TriggerManager.triggerState.pause;
	}

	public virtual void ToDestroy()
	{
		DisableTrigger();
		currentSate = TriggerManager.triggerState.destroy;
		triggerOwner = null;
	}
}
