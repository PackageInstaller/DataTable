using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

[Serializable]
public class BattleMessage : MessageBase, IReference
{
	protected IDictionary<string, object> data = new Dictionary<string, object>();

	protected BaseEntity senderEntity;

	protected BaseEntity triggerEntity;

	protected BattleEventType eventType;

	public BattleEventType EventType => eventType;

	public new BaseEntity Sender => senderEntity;

	public BaseEntity Trigger => triggerEntity;

	public IDictionary<string, object> Data => data;

	public static BattleMessage Create(BaseEntity senderEntity, BaseEntity triggerEntity, BattleEventType eventType, Dictionary<string, object> msgData)
	{
		BattleMessage battleMessage = ReferencePool.Acquire<BattleMessage>();
		battleMessage.senderEntity = senderEntity;
		battleMessage.triggerEntity = triggerEntity;
		battleMessage.eventType = eventType;
		battleMessage.SetData(msgData);
		return battleMessage;
	}

	public BattleMessage()
		: base(null)
	{
	}

	public bool ContainsKey(string key)
	{
		return data.ContainsKey(key);
	}

	public bool Remove(string key)
	{
		return data.Remove(key);
	}

	public T Get<T>(string key)
	{
		return Get(key, default(T));
	}

	public T Get<T>(string key, T defaultValue)
	{
		if (data.TryGetValue(key, out var value))
		{
			return (T)value;
		}
		return defaultValue;
	}

	public void Put<T>(string key, T value)
	{
		if (!IsValidType(value))
		{
			throw new ArgumentException("Value must be serializable!");
		}
		data[key] = value;
	}

	public void SetData(Dictionary<string, object> msgData)
	{
		if (msgData == null)
		{
			return;
		}
		data.Clear();
		foreach (KeyValuePair<string, object> msgDatum in msgData)
		{
			data.Add(msgDatum.Key, msgDatum.Value);
		}
	}

	private bool IsValidType(object value)
	{
		return true;
	}

	public void Clear()
	{
		data.Clear();
	}
}
