using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World;

public class MonoTriggerEvent : MonoBehaviour
{
	internal void OnEnterEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = true;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	internal void OnExitEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = false;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
