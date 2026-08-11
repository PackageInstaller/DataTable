using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class ObserverDamageProgressParams : IObserverParams, IReference
{
	protected BattleObserverEventEnum eventEnum;

	protected BaseEntity attacker;

	protected BaseEntity defender;

	protected BaseEntity trigger;

	protected Dictionary<string, object> msgData;

	public BattleObserverEventEnum ObserverEventType => eventEnum;

	public BaseEntity Attacker => attacker;

	public BaseEntity Defender => defender;

	public BaseEntity Trigger
	{
		get
		{
			if (eventEnum == BattleObserverEventEnum.Attack || eventEnum == BattleObserverEventEnum.AttackBefore)
			{
				return attacker;
			}
			if (eventEnum == BattleObserverEventEnum.Damage || eventEnum == BattleObserverEventEnum.DamageBefore)
			{
				return defender;
			}
			return null;
		}
	}

	private static Dictionary<string, object> CreateMsgData(Dictionary<string, object> msgData)
	{
		if (msgData == null)
		{
			return null;
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		foreach (KeyValuePair<string, object> msgDatum in msgData)
		{
			dictionary.Add(msgDatum.Key, msgDatum.Value);
		}
		return dictionary;
	}

	public T Get<T>(string key)
	{
		return Get(key, default(T));
	}

	public object Get(string key)
	{
		object value = null;
		msgData?.TryGetValue(key, out value);
		return value;
	}

	public T Get<T>(string key, T defaultValue)
	{
		object value = null;
		Dictionary<string, object> dictionary = msgData;
		if (dictionary != null && dictionary.TryGetValue(key, out value))
		{
			return (T)value;
		}
		return defaultValue;
	}

	public bool ContainsKey(string key)
	{
		return msgData?.ContainsKey(key) ?? false;
	}

	public void Init(BaseEntity attacker, BaseEntity defender, Dictionary<string, object> msgData, BattleObserverEventEnum eventEnum)
	{
		this.attacker = attacker;
		this.defender = defender;
		this.msgData = CreateMsgData(msgData);
		this.eventEnum = eventEnum;
	}

	public void Clear()
	{
		attacker = null;
		defender = null;
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(msgData);
		eventEnum = BattleObserverEventEnum.None;
	}

	public IObserverParams Copy()
	{
		ObserverDamageProgressParams observerDamageProgressParams = ReferencePool.Acquire<ObserverDamageProgressParams>();
		observerDamageProgressParams.attacker = attacker;
		observerDamageProgressParams.defender = defender;
		observerDamageProgressParams.msgData = CreateMsgData(msgData);
		observerDamageProgressParams.eventEnum = eventEnum;
		return observerDamageProgressParams;
	}
}
