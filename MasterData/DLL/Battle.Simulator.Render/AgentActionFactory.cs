using System.Collections.Generic;
using UnityEngine;

public static class AgentActionFactory
{
	public enum E_Type
	{
		Idle,
		Move,
		Hurt,
		EquipWeapon,
		AimEnter,
		AimLeave,
		FireEnter,
		FireLeave,
		ReloadEnter,
		ReloadLeave,
		CastSkillEnter,
		CastSkillLeave,
		Dead,
		AbilityEnter,
		AbilityLeave,
		TimeStepChange,
		HitRecoverEnter,
		HitRecoverLeave,
		ActionPause,
		SubJoystickUpdate,
		SubJoystickEnter,
		SubJoystickExit,
		Transfiguration,
		Hide,
		HitAbilityChange,
		Count
	}

	private static Queue<AgentAction>[] m_UnusedActions;

	static AgentActionFactory()
	{
		m_UnusedActions = new Queue<AgentAction>[25];
		for (E_Type e_Type = E_Type.Idle; e_Type < E_Type.Count; e_Type++)
		{
			m_UnusedActions[(int)e_Type] = new Queue<AgentAction>();
		}
	}

	public static AgentAction Create(E_Type type)
	{
		AgentAction agentAction;
		if (m_UnusedActions[(int)type].Count > 0)
		{
			agentAction = m_UnusedActions[(int)type].Dequeue();
		}
		else
		{
			switch (type)
			{
			case E_Type.Hurt:
				agentAction = new AgentActionHurt();
				break;
			case E_Type.EquipWeapon:
				agentAction = new AgentActionEquipWeapon();
				break;
			case E_Type.AimEnter:
				agentAction = new AgentActionAimEnter();
				break;
			case E_Type.AimLeave:
				agentAction = new AgentActionAimLeave();
				break;
			case E_Type.FireEnter:
				agentAction = new AgentActionFireEnter();
				break;
			case E_Type.FireLeave:
				agentAction = new AgentActionFireLeave();
				break;
			case E_Type.ReloadEnter:
				agentAction = new AgentActionReloadEnter();
				break;
			case E_Type.ReloadLeave:
				agentAction = new AgentActionReloadLeave();
				break;
			case E_Type.CastSkillEnter:
				agentAction = new AgentActionCastSkillEnter();
				break;
			case E_Type.CastSkillLeave:
				agentAction = new AgentActionAimLeave();
				break;
			case E_Type.Dead:
				agentAction = new AgentActionDead();
				break;
			case E_Type.AbilityEnter:
				agentAction = new AgentActionAbilityEnter();
				break;
			case E_Type.AbilityLeave:
				agentAction = new AgentActionAbilityLeave();
				break;
			case E_Type.HitRecoverEnter:
				agentAction = new AgentActionHitRecoverEnter();
				break;
			case E_Type.HitRecoverLeave:
				agentAction = new AgentActionHitRecoverLeave();
				break;
			case E_Type.ActionPause:
				agentAction = new AgentActionPause();
				break;
			case E_Type.TimeStepChange:
				agentAction = new AgentActionTimeStepChange();
				break;
			case E_Type.SubJoystickUpdate:
				agentAction = new AgentActionSubJoystickCommandUpdate();
				break;
			case E_Type.SubJoystickEnter:
				agentAction = new AgentActionSubJoystickCommandEnter();
				break;
			case E_Type.SubJoystickExit:
				agentAction = new AgentActionSubJoystickCommandExit();
				break;
			case E_Type.Transfiguration:
				agentAction = new AgentActionTransfiguration();
				break;
			case E_Type.Hide:
				agentAction = new AgentActionHide();
				break;
			case E_Type.HitAbilityChange:
				agentAction = new AgentActionHitAbilityChange();
				break;
			default:
				Debug.LogError("no AgentAction to create");
				return null;
			}
		}
		agentAction.Reset();
		agentAction.SetActive();
		return agentAction;
	}

	public static void Return(AgentAction action)
	{
		action.SetUnused();
		m_UnusedActions[(int)action.Type].Enqueue(action);
	}

	public static void Clear()
	{
		for (E_Type e_Type = E_Type.Idle; e_Type < E_Type.Count; e_Type++)
		{
			m_UnusedActions[(int)e_Type].Clear();
		}
	}
}
