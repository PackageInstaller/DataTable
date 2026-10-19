using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.World;

public class TriggerManager
{
	private Dictionary<Entity, List<ITrigger>> m_DictionaryTriggers;

	private Dictionary<ITrigger, HashSet<Entity>> m_TriggeredReference;

	public TriggerManager()
	{
		m_DictionaryTriggers = new Dictionary<Entity, List<ITrigger>>();
		m_TriggeredReference = new Dictionary<ITrigger, HashSet<Entity>>();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TriggerStateChange, OnTriggerStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DetectCollisionsChange, OnDetectCollisionsChange);
	}

	~TriggerManager()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TriggerStateChange, OnTriggerStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DetectCollisionsChange, OnDetectCollisionsChange);
	}

	public void ClearWorldTriggers()
	{
		foreach (List<ITrigger> value in m_DictionaryTriggers.Values)
		{
			value.Clear();
		}
		m_DictionaryTriggers.Clear();
		foreach (HashSet<Entity> value2 in m_TriggeredReference.Values)
		{
			value2.Clear();
		}
		m_TriggeredReference.Clear();
	}

	public void UnregisterTrigger(ITrigger trigger)
	{
		if (trigger == null || !m_TriggeredReference.Remove(trigger, out var value))
		{
			return;
		}
		foreach (Entity item in value)
		{
			if (!m_DictionaryTriggers.TryGetValue(item, out var value2))
			{
				continue;
			}
			for (int num = value2.Count - 1; num >= 0; num--)
			{
				if (value2[num] == trigger)
				{
					value2.RemoveAt(num);
				}
			}
			if (value2.Count == 0)
			{
				m_DictionaryTriggers.Remove(item);
			}
		}
		value.Clear();
	}

	private void OnDetectCollisionsChange(BaseEventContent obj)
	{
		DetectCollisionsChange detectCollisionsChange = (DetectCollisionsChange)obj;
		if (detectCollisionsChange.enable || !m_DictionaryTriggers.TryGetValue(detectCollisionsChange.entity, out var value))
		{
			return;
		}
		if (MonoECS.instance != null && MonoECS.instance.localPlayer.battleEntity.IsValid)
		{
			foreach (ITrigger item in value)
			{
				try
				{
					if (m_TriggeredReference.TryGetValue(item, out var value2))
					{
						value2.Remove(detectCollisionsChange.entity);
						if (value2.Count == 0)
						{
							item.TriggerExit();
							m_TriggeredReference.Remove(item);
						}
					}
				}
				catch (Exception)
				{
					_ = LuminApplication.LogEnabled;
				}
			}
			value.Clear();
		}
		m_DictionaryTriggers.Remove(detectCollisionsChange.entity);
	}

	private void OnTriggerStateChange(BaseEventContent obj)
	{
		TriggerStateChange triggerStateChange = (TriggerStateChange)obj;
		if (triggerStateChange.enter)
		{
			if (!m_DictionaryTriggers.ContainsKey(triggerStateChange.entity))
			{
				m_DictionaryTriggers.Add(triggerStateChange.entity, new List<ITrigger>());
			}
			if (!m_DictionaryTriggers[triggerStateChange.entity].Contains(triggerStateChange.trigger))
			{
				m_DictionaryTriggers[triggerStateChange.entity].Add(triggerStateChange.trigger);
			}
			if (!m_TriggeredReference.ContainsKey(triggerStateChange.trigger))
			{
				m_TriggeredReference.Add(triggerStateChange.trigger, new HashSet<Entity>());
			}
			m_TriggeredReference[triggerStateChange.trigger].Add(triggerStateChange.entity);
			return;
		}
		if (m_DictionaryTriggers.TryGetValue(triggerStateChange.entity, out var value))
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num] == triggerStateChange.trigger)
				{
					value.RemoveAt(num);
				}
			}
			if (value.Count == 0)
			{
				m_DictionaryTriggers.Remove(triggerStateChange.entity);
			}
		}
		if (m_TriggeredReference.TryGetValue(triggerStateChange.trigger, out var value2))
		{
			value2.Remove(triggerStateChange.entity);
			if (value2.Count == 0)
			{
				m_TriggeredReference.Remove(triggerStateChange.trigger);
			}
		}
	}
}
