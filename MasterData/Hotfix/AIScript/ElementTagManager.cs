using System.Collections.Generic;
using AIScript.ElementTag;

namespace AIScript;

public class ElementTagManager
{
	private readonly Dictionary<HotfixEnum.elementType, BaseElementTag> elementTagDic = new Dictionary<HotfixEnum.elementType, BaseElementTag>();

	public virtual void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		EnableElementTagData();
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveHit);
		elementTagDic.Clear();
	}

	private void EnableElementTagData()
	{
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			HotfixEnum.elementType elementType = list.get_Item(i).actorElementInfo.elementType;
			if (!elementTagDic.ContainsKey(elementType))
			{
				BaseElementTag baseElementTag = CreateInstance(elementType);
				if (baseElementTag != null)
				{
					elementTagDic.Add(elementType, baseElementTag);
					baseElementTag.OnEnable();
					baseElementTag.actorFilterDic.Add(list.get_Item(i).Id, list.get_Item(i).dataID);
				}
			}
			else
			{
				elementTagDic.get_Item(elementType).actorFilterDic.Add(list.get_Item(i).Id, list.get_Item(i).dataID);
			}
		}
	}

	private BaseElementTag CreateInstance(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.AE => (BaseElementTag)new ElementTag_Wind(), 
			HotfixEnum.elementType.DE => new ElementTag_Dark(), 
			HotfixEnum.elementType.FE => new ElementTag_Fire(), 
			HotfixEnum.elementType.LE => new ElementTag_Light(), 
			HotfixEnum.elementType.SE => new ElementTag_Land(), 
			HotfixEnum.elementType.WE => new ElementTag_Water(), 
			_ => null, 
		};
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		MonsterAdventureActor monster = adventureElementMarkTriggerEvent.markActor as MonsterAdventureActor;
		PlayerAdventureActor playerAdventureActor = adventureElementMarkTriggerEvent.triggerActor as PlayerAdventureActor;
		if (playerAdventureActor != null && elementTagDic.TryGetValue(playerAdventureActor.actorElementInfo.elementType, out var value))
		{
			value.OnEvent(adventureElementMarkTriggerEvent, playerAdventureActor, monster);
		}
	}

	private void OnReceiveHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.to as MonsterAdventureActor;
		PlayerAdventureActor playerAdventureActor = adventureActorReceiveDamageBeforeSettlementEvent.from as PlayerAdventureActor;
		if (playerAdventureActor != null && adventureActorReceiveDamageBeforeSettlementEvent.hitDamageTag != null && monsterAdventureActor != null && elementTagDic.TryGetValue(playerAdventureActor.actorElementInfo.elementType, out var value))
		{
			value.OnBeHit(adventureActorReceiveDamageBeforeSettlementEvent, playerAdventureActor, monsterAdventureActor);
		}
	}
}
