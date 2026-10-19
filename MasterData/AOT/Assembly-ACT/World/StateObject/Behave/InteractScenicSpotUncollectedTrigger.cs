using ACT.Battle;
using ACT.World;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

namespace World.StateObject.Behave;

public class InteractScenicSpotUncollectedTrigger : MonoTriggerEvent, ITrigger
{
	public InteractScenicSpot interactScenicSpot;

	private bool m_Trigger;

	private void OnTriggerEnter(Collider other)
	{
		if (!m_Trigger && other.TryGetComponent<MonoEntity>(out var component) && component.entity.IsCharacter() && MonoECS.instance.localPlayer.IndexOfTeamCharacter(component.entity) == MonoECS.instance.battleEntityIndex && MonoECS.instance.IsMainEntity(component.entity) && !m_Trigger)
		{
			m_Trigger = true;
			interactScenicSpot.OnEnterUnCollectedTrigger();
			OnEnterEvt(component.entity, this);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component != null && component.entity.IsCharacter() && MonoECS.instance.IsMainEntity(component.entity) && m_Trigger)
		{
			m_Trigger = false;
			interactScenicSpot.OnExitUnCollectedTrigger();
			OnExitEvt(component.entity, this);
		}
	}

	public void TriggerExit()
	{
		m_Trigger = false;
		interactScenicSpot.OnExitUnCollectedTrigger();
	}
}
