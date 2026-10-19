using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using Cinemachine;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MotionPath : LuminSerializedMonoBehaviour, ITrigger
{
	public CinemachinePathBase pathBase;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if ((bool)component && component.entity.TryGetCompPhysics(out CompPhysics component2))
		{
			component2.AddPath(this);
			TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
			evt.enter = true;
			evt.trigger = this;
			evt.entity = component.entity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if ((bool)component && component.entity.TryGetCompPhysics(out CompPhysics component2))
		{
			component2.RemovePath(this);
			TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
			evt.enter = false;
			evt.trigger = this;
			evt.entity = component.entity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void TriggerExit()
	{
		MonoECS.instance.mainEntity.GetCompPhysics()?.RemovePath(this);
	}
}
