using System;
using System.Collections.Generic;
using UnityEngine.Events;

[Serializable]
public class EventListenerGroup<T>
{
	public UnityEvent<T> Event;

	public string GroupTag;

	public List<UnityAction<T>> Listeners = new List<UnityAction<T>>();

	public UnityEvent<T> GetEvent()
	{
		return Event;
	}

	public void AddListener(UnityAction<T> action)
	{
		if (!Listeners.Contains(action))
		{
			Event.AddListener(action);
			Listeners.Add(action);
		}
	}

	public void RemoveListener(UnityAction<T> action)
	{
		if (Listeners.Contains(action))
		{
			Event.RemoveListener(action);
			Listeners.Remove(action);
		}
	}

	public void RemoveAllListeners()
	{
		foreach (UnityAction<T> listener in Listeners)
		{
			Event.RemoveListener(listener);
		}
		Listeners.Clear();
	}
}
[Serializable]
public class EventListenerGroup<T1, T2>
{
	public UnityEvent<T1, T2> Event;

	public string GroupTag;

	public List<UnityAction<T1, T2>> Listeners = new List<UnityAction<T1, T2>>();

	public void AddListener(UnityAction<T1, T2> action)
	{
		if (!Listeners.Contains(action))
		{
			Event.AddListener(action);
			Listeners.Add(action);
		}
	}

	public void RemoveListener(UnityAction<T1, T2> action)
	{
		if (Listeners.Contains(action))
		{
			Event.RemoveListener(action);
			Listeners.Remove(action);
		}
	}

	public void RemoveAllListeners()
	{
		foreach (UnityAction<T1, T2> listener in Listeners)
		{
			Event.RemoveListener(listener);
		}
		Listeners.Clear();
	}
}
