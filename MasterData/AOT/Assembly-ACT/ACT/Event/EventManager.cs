using System;
using System.Collections.Generic;
using Fundamental;

namespace ACT.Event;

public class EventManager : Singleton<EventManager>
{
	protected Dictionary<ClientEvent, ActionList<BaseEventContent>> m_dictEvent;

	private Dictionary<Type, ObjectPool> m_EvtsPool;

	public override ContextType ContextType => ContextType.GLOBAL;

	public override void Init()
	{
		m_EvtsPool = new Dictionary<Type, ObjectPool>();
		m_dictEvent = new Dictionary<ClientEvent, ActionList<BaseEventContent>>();
		Type typeFromHandle = typeof(BaseEventContent);
		Type[] types = typeFromHandle.Assembly.GetTypes();
		Type typeFromHandle2 = typeof(ObjectPool<>);
		Type[] array = types;
		foreach (Type type in array)
		{
			if (type.IsSubclassOf(typeFromHandle))
			{
				object obj = Activator.CreateInstance(typeFromHandle2.MakeGenericType(type));
				m_EvtsPool.Add(type, (ObjectPool)obj);
			}
		}
	}

	public void AddEventListener(ClientEvent eventId, Action<BaseEventContent> handle)
	{
		if (handle != null)
		{
			if (!m_dictEvent.TryGetValue(eventId, out var value))
			{
				ActionList<BaseEventContent> actionList = new ActionList<BaseEventContent>();
				actionList.Add(handle);
				m_dictEvent.Add(eventId, actionList);
			}
			else
			{
				value.Add(handle);
			}
		}
	}

	public void RemoveEventListener(ClientEvent eventId, Action<BaseEventContent> handle)
	{
		if (m_dictEvent.TryGetValue(eventId, out var value))
		{
			value.Remove(handle);
			if (value.GetLength() == 0)
			{
				m_dictEvent.Remove(eventId);
			}
		}
	}

	public void EventDispatch(ClientEvent eventId, BaseEventContent o)
	{
		if (m_dictEvent.TryGetValue(eventId, out var value))
		{
			value.Invoke(o);
		}
	}

	public int GetEventCount(ClientEvent eventId)
	{
		if (m_dictEvent.TryGetValue(eventId, out var value))
		{
			return value.GetLength();
		}
		return 0;
	}

	public T GetEvt<T>() where T : BaseEventContent, new()
	{
		T val = ((ObjectPool<T>)m_EvtsPool[typeof(T)]).Get();
		val.OnGet();
		return val;
	}

	public void ReleaseEvt<T>(T ret) where T : BaseEventContent, new()
	{
		ObjectPool<T> objectPool = (ObjectPool<T>)m_EvtsPool[typeof(T)];
		ret.ReleaseEvt();
		objectPool.Release(ret);
	}
}
