using System.Collections.Generic;
using UnityEngine;

public static class QWAgentActionFactory
{
	private static Dictionary<QWAgentAction.E_Type, Queue<QWAgentAction>> m_UnusedActions = new Dictionary<QWAgentAction.E_Type, Queue<QWAgentAction>>();

	public static QWAgentAction Create(QWAgentAction.E_Type type)
	{
		QWAgentAction qWAgentAction = null;
		if (!m_UnusedActions.ContainsKey(type))
		{
			m_UnusedActions[type] = new Queue<QWAgentAction>();
		}
		if (m_UnusedActions[type].Count > 0)
		{
			qWAgentAction = m_UnusedActions[type].Dequeue();
			if (qWAgentAction == null)
			{
				Debug.LogError("放进来了个什么东西??" + type);
			}
		}
		else
		{
			switch (type)
			{
			case QWAgentAction.E_Type.ChangeName:
				qWAgentAction = new QWChangeNameAction();
				break;
			case QWAgentAction.E_Type.ChangeRush:
				qWAgentAction = new QWCharacterRushAction();
				break;
			case QWAgentAction.E_Type.ChangeFastRush:
				qWAgentAction = new QWCharacterFastRushAction();
				break;
			case QWAgentAction.E_Type.PlayAnim:
				qWAgentAction = new QWCharacterPlayAnimAction();
				break;
			case QWAgentAction.E_Type.MoveToTarget:
				qWAgentAction = new QWMoveToTargetAction();
				break;
			case QWAgentAction.E_Type.ShowQuest:
				qWAgentAction = new QWQuestShowAction();
				break;
			case QWAgentAction.E_Type.Teleport:
				qWAgentAction = new QWTeleportAction();
				break;
			case QWAgentAction.E_Type.TeleportCamera:
				qWAgentAction = new QWTeleportCameraAction();
				break;
			case QWAgentAction.E_Type.BodyDither:
				qWAgentAction = new QWChangeBodyDitherAction();
				break;
			case QWAgentAction.E_Type.RotateToForward:
				qWAgentAction = new QWRotateToForwardAction();
				break;
			case QWAgentAction.E_Type.EnterInteractiveState:
				qWAgentAction = new QWEnterInteractiveStateAction();
				break;
			case QWAgentAction.E_Type.EnterPlayerFocusState:
				qWAgentAction = new QWCharacterEnterPlayerFocusAction();
				break;
			case QWAgentAction.E_Type.LookAt:
				qWAgentAction = new QWLookAtAction();
				break;
			case QWAgentAction.E_Type.AddToStage:
				qWAgentAction = new QWOnAddToSatgeAction();
				break;
			case QWAgentAction.E_Type.RemoveFromStage:
				qWAgentAction = new QWOnRemoveFromSatgeAction();
				break;
			case QWAgentAction.E_Type.Furniture_PlayEffect:
				qWAgentAction = new QWFurniturePlayEffectAction();
				break;
			case QWAgentAction.E_Type.Furniture_AttachTo:
				qWAgentAction = new QWFurnitureAttachToAction();
				break;
			case QWAgentAction.E_Type.Furniture_Enter:
				qWAgentAction = new QWFurnitureEnterAction();
				break;
			case QWAgentAction.E_Type.Furniture_GrabItem:
				qWAgentAction = new QWFurnitureGrabItemAction();
				break;
			case QWAgentAction.E_Type.Furniture_Visible:
				qWAgentAction = new QWFurnitureVisibleAction();
				break;
			case QWAgentAction.E_Type.Camera_LookAtTarget:
				qWAgentAction = new QWSetCameraLookAtTarget();
				break;
			case QWAgentAction.E_Type.Camera_Reset:
				qWAgentAction = new QWResetCamera();
				break;
			case QWAgentAction.E_Type.CommonHudShow:
				qWAgentAction = new QWCommonHudShowAction();
				break;
			case QWAgentAction.E_Type.ChangeCharacter:
				qWAgentAction = new QWChangeCharacterAction();
				break;
			case QWAgentAction.E_Type.PostChangeCharacter:
				qWAgentAction = new QWPostChangeCharacterAction();
				break;
			case QWAgentAction.E_Type.ChangeInteractionMode:
				qWAgentAction = new QWChangeInteractionModeAction();
				break;
			default:
				Debug.LogError("no AgentAction to create");
				return null;
			}
		}
		qWAgentAction.Reset();
		qWAgentAction.SetActive();
		return qWAgentAction;
	}

	public static void Return(QWAgentAction action)
	{
		if (action != null)
		{
			action.SetUnused();
			m_UnusedActions[action.Type].Enqueue(action);
		}
	}

	public static void Clear()
	{
		m_UnusedActions.Clear();
	}
}
