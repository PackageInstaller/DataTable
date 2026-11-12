using System.Collections.Generic;

namespace AIScript;

public class BaseElementTag
{
	protected PlayerAdventureActor _actor;

	protected MonsterAdventureActor _monster;

	public Dictionary<long, int> actorFilterDic = new Dictionary<long, int>();

	public virtual void OnEnable()
	{
		_actor = null;
		_monster = null;
	}

	public virtual void OnDisable()
	{
	}

	public void OnBeHit(AdventureActorReceiveDamageBeforeSettlementEvent evt, PlayerAdventureActor actor, MonsterAdventureActor monster)
	{
		_actor = actor;
		_monster = monster;
		if (_actor != null && _monster != null)
		{
			OnBeHitTrigger(evt);
		}
	}

	public void OnEvent(AdventureElementMarkTriggerEvent evt, PlayerAdventureActor actor, MonsterAdventureActor monster)
	{
		_actor = actor;
		_monster = monster;
		if (_actor != null && _monster != null)
		{
			OnEventTrigger(evt);
		}
	}

	protected virtual void OnBeHitTrigger(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
	}

	protected virtual void OnEventTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}
}
