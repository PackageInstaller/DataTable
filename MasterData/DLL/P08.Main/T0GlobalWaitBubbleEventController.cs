using System;
using System.Collections.Generic;
using LuaInterface;
using Sirenix.OdinInspector;
using T0World;
using UnityEngine.Events;

public class T0GlobalWaitBubbleEventController : SerializedMonoBehaviour
{
	[Serializable]
	public class BubbleStateChangeEvents
	{
		internal bool lastEnableState;

		public UnityEvent<bool> onValueChange;

		public UnityEvent onDisable;

		public UnityEvent onEnable;
	}

	[NoToLua]
	public Dictionary<string, BubbleStateChangeEvents> onEventsStateChange = new Dictionary<string, BubbleStateChangeEvents>();

	private static Dictionary<string, T0InterationBubbleData> focusEvents => T0InterationBubbleData.globalWaitEvent;

	[NoToLua]
	public void RegisterEvent(string key, T0InterationBubbleData @event)
	{
		focusEvents[key] = @event;
	}

	private bool CheckEventCanInteract(T0InterationBubbleData @event)
	{
		if (@event.IsEntityVisible)
		{
			return T0WorldScene.Scene.interactionManager.InteractContext.CheckIsCanProcess(@event);
		}
		return false;
	}

	[NoToLua]
	public void RemoveEvent(string key)
	{
		focusEvents.Remove(key);
	}

	public void TriggerInteract(string key)
	{
		TriggerInteract(key, check: true);
	}

	public void TriggerInteract(string key, bool check)
	{
		if (focusEvents.TryGetValue(key, out var value) && (!check || CheckEventCanInteract(value)))
		{
			value.IsFinish = true;
		}
	}

	private void Update()
	{
		foreach (var (key, bubbleStateChangeEvents2) in onEventsStateChange)
		{
			if (bubbleStateChangeEvents2 == null)
			{
				continue;
			}
			if (focusEvents.TryGetValue(key, out var value))
			{
				bool lastEnableState = bubbleStateChangeEvents2.lastEnableState;
				bool flag = CheckEventCanInteract(value);
				if (lastEnableState != flag)
				{
					bubbleStateChangeEvents2.onValueChange?.Invoke(flag);
					if (flag)
					{
						bubbleStateChangeEvents2.onEnable?.Invoke();
					}
					else
					{
						bubbleStateChangeEvents2.onDisable?.Invoke();
					}
				}
				bubbleStateChangeEvents2.lastEnableState = flag;
			}
			else
			{
				if (bubbleStateChangeEvents2.lastEnableState)
				{
					bubbleStateChangeEvents2.onValueChange?.Invoke(arg0: false);
					bubbleStateChangeEvents2.onDisable?.Invoke();
				}
				bubbleStateChangeEvents2.lastEnableState = false;
			}
		}
	}
}
