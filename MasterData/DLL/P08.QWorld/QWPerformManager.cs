using System;
using LuaInterface;
using UnityEngine;

public class QWPerformManager
{
	private QWFurnitureEffectController effectController;

	private QWFurnitureBlackboard PlayerInteractTarget;

	public static QWPerformManager Instance;

	public QWFurnitureBlackboard GetPlayerInteractTarget => PlayerInteractTarget;

	public QWPerformManager()
	{
		Instance = this;
	}

	[NoToLua]
	public void Init()
	{
		effectController = new QWFurnitureEffectController();
	}

	[NoToLua]
	public void Tick()
	{
		if (PlayerInteractTarget != null && PlayerInteractTarget.waitInteractExit)
		{
			QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
			if (qWorldScene != null && qWorldScene.Agent.Blackboard.hasMoveInput)
			{
				PlayerInteractTarget.waitInteractExit = false;
				PlayerInteractTarget.interactExitDirty = true;
			}
		}
	}

	[NoToLua]
	public void Dispose()
	{
		effectController?.Dispose();
		effectController = null;
	}

	public void PlayAnimeDuringInteract(QWorldMapEntity furniture, string animName, float crossFade, int target)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null)
		{
			if (target == 0)
			{
				QWCharacterPlayAnimAction qWCharacterPlayAnimAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.PlayAnim) as QWCharacterPlayAnimAction;
				qWCharacterPlayAnimAction.animName = animName;
				qWCharacterPlayAnimAction.crossFade = crossFade;
				qWCharacterPlayAnimAction.forceReplay = true;
				qWorldScene.Agent.Blackboard.ActionAdd(qWCharacterPlayAnimAction);
			}
			else if (furniture != null)
			{
				QWCharacterPlayAnimAction qWCharacterPlayAnimAction2 = QWAgentActionFactory.Create(QWAgentAction.E_Type.PlayAnim) as QWCharacterPlayAnimAction;
				qWCharacterPlayAnimAction2.animName = animName;
				qWCharacterPlayAnimAction2.crossFade = crossFade;
				qWCharacterPlayAnimAction2.forceReplay = true;
				furniture.BlackBoard.ActionAdd(qWCharacterPlayAnimAction2);
			}
		}
	}

	public void PutAt(QWorldMapEntity furniture, string pointName)
	{
		Transform furnitureAttachPoint = (furniture.BlackBoard as QWFurnitureBlackboard).GetFurnitureAttachPoint(pointName);
		if (furnitureAttachPoint != null)
		{
			QWorldScene obj = NScene.GetCurrentScene() as QWorldScene;
			obj.Agent.transform.position = furnitureAttachPoint.position;
			obj.Agent.transform.rotation = furnitureAttachPoint.rotation;
		}
	}

	public void PlayEffect(QWorldMapEntity furniture, string attachPoint, string efxPath, Vector3 pos, Quaternion rot, Vector3 scale, float duration, int target)
	{
		QWFurnitureBlackboard obj = furniture.BlackBoard as QWFurnitureBlackboard;
		QWFurniturePlayEffectAction qWFurniturePlayEffectAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_PlayEffect) as QWFurniturePlayEffectAction;
		qWFurniturePlayEffectAction.playEffect = true;
		qWFurniturePlayEffectAction.offset = pos;
		qWFurniturePlayEffectAction.rotation = rot;
		qWFurniturePlayEffectAction.scale = scale;
		qWFurniturePlayEffectAction.attachPoint = attachPoint;
		qWFurniturePlayEffectAction.efxPath = efxPath;
		qWFurniturePlayEffectAction.duration = duration;
		qWFurniturePlayEffectAction.target = target;
		obj.ActionAdd(qWFurniturePlayEffectAction);
	}

	public void ClearEffect(QWorldMapEntity furniture, string attachPoint, int target)
	{
		QWFurnitureBlackboard obj = furniture.BlackBoard as QWFurnitureBlackboard;
		QWFurniturePlayEffectAction qWFurniturePlayEffectAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_PlayEffect) as QWFurniturePlayEffectAction;
		qWFurniturePlayEffectAction.playEffect = false;
		qWFurniturePlayEffectAction.target = target;
		qWFurniturePlayEffectAction.attachPoint = attachPoint;
		obj.ActionAdd(qWFurniturePlayEffectAction);
	}

	public void StartFurniturInteract(QWorldMapEntity furniture, Action complete)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = (PlayerInteractTarget = furniture.BlackBoard as QWFurnitureBlackboard);
		if (!(qWFurnitureBlackboard == null))
		{
			QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
			QWorldLuaBridge.HideBubble();
			QWorldLuaBridge.StopControl();
			QWEnterInteractiveStateAction qWEnterInteractiveStateAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.EnterInteractiveState) as QWEnterInteractiveStateAction;
			qWEnterInteractiveStateAction.isEnter = true;
			qWorldScene.Agent.Blackboard.ActionAdd(qWEnterInteractiveStateAction);
			qWEnterInteractiveStateAction.isEnter = true;
			qWorldScene.Agent.Blackboard.ActionAdd(qWEnterInteractiveStateAction);
			if (qWFurnitureBlackboard.dormTag.focusPoint != null)
			{
				QWSetCameraLookAtTarget qWSetCameraLookAtTarget = QWAgentActionFactory.Create(QWAgentAction.E_Type.Camera_LookAtTarget) as QWSetCameraLookAtTarget;
				qWSetCameraLookAtTarget.cameraFlag = QWCameraFlag.Furniture;
				qWSetCameraLookAtTarget.lookAt = qWFurnitureBlackboard.dormTag.focusPoint;
				qWorldScene.Agent.Blackboard.ActionAdd(qWSetCameraLookAtTarget);
			}
			complete();
			qWFurnitureBlackboard.inInteract = true;
			qWFurnitureBlackboard.waitInteractExit = false;
			qWFurnitureBlackboard.interactExitDirty = false;
		}
	}

	public void EndFurniturInteract(QWorldMapEntity furniture, bool resetStatus = true)
	{
		if (furniture.BlackBoard is QWFurnitureBlackboard)
		{
			EndFurniturInteract(furniture.BlackBoard as QWFurnitureBlackboard, resetStatus);
		}
	}

	public void EndFurniturInteract(QWFurnitureBlackboard bb, bool resetStatus = true)
	{
		if (resetStatus)
		{
			QWorldLuaBridge.HideBubble(active: false);
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		QWEnterInteractiveStateAction qWEnterInteractiveStateAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.EnterInteractiveState) as QWEnterInteractiveStateAction;
		qWEnterInteractiveStateAction.isEnter = false;
		qWorldScene.Agent.Blackboard.ActionAdd(qWEnterInteractiveStateAction);
		QWFurnitureEnterAction qWFurnitureEnterAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_Enter) as QWFurnitureEnterAction;
		qWFurnitureEnterAction.target = qWorldScene.Agent;
		qWFurnitureEnterAction.isEnter = false;
		bb.ActionAdd(qWFurnitureEnterAction);
		QWSetCameraLookAtTarget qWSetCameraLookAtTarget = QWAgentActionFactory.Create(QWAgentAction.E_Type.Camera_LookAtTarget) as QWSetCameraLookAtTarget;
		qWSetCameraLookAtTarget.cameraFlag = QWCameraFlag.Furniture;
		qWSetCameraLookAtTarget.lookAt = null;
		qWorldScene.Agent.Blackboard.ActionAdd(qWSetCameraLookAtTarget);
		if (bb.dormTag.needForceExit && bb.dormTag.forceExitPoint != null)
		{
			qWorldScene.Agent.transform.position = bb.dormTag.forceExitPoint.position;
			qWorldScene.Agent.transform.rotation = bb.dormTag.forceExitPoint.rotation;
		}
		if (bb.dormTag.needForceExit && bb.dormTag.idleAnim.IsNotNullOrEmpty() && bb.dormTag.idleAnim != "")
		{
			QWCharacterPlayAnimAction qWCharacterPlayAnimAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.PlayAnim) as QWCharacterPlayAnimAction;
			qWCharacterPlayAnimAction.animName = bb.dormTag.idleAnim;
			qWCharacterPlayAnimAction.crossFade = 0f;
			bb.ActionAdd(qWCharacterPlayAnimAction);
		}
		if (resetStatus)
		{
			QWorldLuaBridge.StopControl(active: false);
		}
		if (bb != null)
		{
			bb.inInteract = false;
			bb.waitInteractExit = false;
			bb.interactExitDirty = false;
		}
		PlayerInteractTarget = null;
	}

	public bool CheckFuniturePerformInterrupt(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (qWFurnitureBlackboard == null)
		{
			return false;
		}
		if (!qWFurnitureBlackboard.dormTag.dontNeedMoveExit)
		{
			return qWFurnitureBlackboard.interactExitDirty;
		}
		return false;
	}

	public void MarkFuniturePerformWaitInterrupt(QWorldMapEntity furniture)
	{
		QWFurnitureBlackboard qWFurnitureBlackboard = furniture.BlackBoard as QWFurnitureBlackboard;
		if (!(qWFurnitureBlackboard == null))
		{
			qWFurnitureBlackboard.waitInteractExit = true;
		}
	}

	[NoToLua]
	public QWFurnitureEffectController GetEffectController()
	{
		return effectController;
	}

	public static void AttachToEntity(QWorldMapEntity furniture, int parent, string attachPoint, bool setAsChild = false)
	{
		QWFurnitureAttachToAction qWFurnitureAttachToAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_AttachTo) as QWFurnitureAttachToAction;
		qWFurnitureAttachToAction.acquireAgent = QWorldScene.Scene.Agent;
		qWFurnitureAttachToAction.attachPoint = attachPoint;
		qWFurnitureAttachToAction.setAsChild = setAsChild;
		qWFurnitureAttachToAction.isAttach = true;
		furniture.BlackBoard.ActionAdd(qWFurnitureAttachToAction);
	}

	public static void DeAttachFromEntity(QWorldMapEntity furniture, int item, bool resetFaceDir = true)
	{
		QWFurnitureAttachToAction qWFurnitureAttachToAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_AttachTo) as QWFurnitureAttachToAction;
		qWFurnitureAttachToAction.acquireAgent = QWorldScene.Scene.Agent;
		qWFurnitureAttachToAction.isAttach = false;
		qWFurnitureAttachToAction.deAttachItem = item;
		qWFurnitureAttachToAction.resetFaceDir = resetFaceDir;
		furniture.BlackBoard.ActionAdd(qWFurnitureAttachToAction);
	}

	public static void GrabItemPart(QWorldMapEntity furniture, int target, string itemPart, string attachPoint)
	{
		QWFurnitureGrabItemAction qWFurnitureGrabItemAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_GrabItem) as QWFurnitureGrabItemAction;
		qWFurnitureGrabItemAction.target = QWorldScene.Scene.Agent;
		qWFurnitureGrabItemAction.attachPoint = attachPoint;
		qWFurnitureGrabItemAction.itemPart = itemPart;
		qWFurnitureGrabItemAction.isGrab = true;
		furniture.BlackBoard.ActionAdd(qWFurnitureGrabItemAction);
	}

	public static void SetVisible(QWorldMapEntity furniture, int target, bool visible)
	{
		QWFurnitureVisibleAction qWFurnitureVisibleAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Furniture_Visible) as QWFurnitureVisibleAction;
		qWFurnitureVisibleAction.target = target;
		qWFurnitureVisibleAction.visible = visible;
		furniture.BlackBoard.ActionAdd(qWFurnitureVisibleAction);
	}
}
