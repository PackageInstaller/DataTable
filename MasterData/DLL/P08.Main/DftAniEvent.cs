using System;
using UnityEngine;

public class DftAniEvent : MonoBehaviour
{
	private Action<UnityEngine.Object> startEvent;

	private Action<UnityEngine.Object> triggerEvent;

	private Action<UnityEngine.Object> endEvent;

	private void OnAniStart()
	{
		if (startEvent != null)
		{
			startEvent(base.gameObject);
		}
	}

	private void OnTrigger()
	{
		if (triggerEvent != null)
		{
			triggerEvent(base.gameObject);
		}
	}

	private void OnAniEnd()
	{
		if (endEvent != null)
		{
			endEvent(base.gameObject);
		}
	}

	public void AddStartEvent(Action<UnityEngine.Object> func)
	{
		startEvent = (Action<UnityEngine.Object>)Delegate.Combine(startEvent, func);
	}

	public void AddTriggerEvent(Action<UnityEngine.Object> func)
	{
		triggerEvent = (Action<UnityEngine.Object>)Delegate.Combine(triggerEvent, func);
	}

	public void AddEndEvent(Action<UnityEngine.Object> func)
	{
		endEvent = (Action<UnityEngine.Object>)Delegate.Combine(endEvent, func);
	}
}
