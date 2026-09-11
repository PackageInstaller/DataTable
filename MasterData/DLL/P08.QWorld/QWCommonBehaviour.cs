using System;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class QWCommonBehaviour : QWAgentBehaviour
{
	private int waitLookAtEntityId = -1;

	private int ditherTweenId;

	public override void Initialize()
	{
		base.Initialize();
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnCommonAction));
		InitDitherControl();
	}

	public void OnCommonAction(QWAgentAction a)
	{
		switch (a.Type)
		{
		case QWAgentAction.E_Type.PlayAnim:
		{
			QWCharacterPlayAnimAction a2 = a as QWCharacterPlayAnimAction;
			CheckPlayAnimAction(a2);
			break;
		}
		case QWAgentAction.E_Type.Teleport:
		{
			QWTeleportAction qWTeleportAction = a as QWTeleportAction;
			Teleport(qWTeleportAction);
			QWTeleportCameraAction qWTeleportCameraAction = (QWTeleportCameraAction)QWAgentActionFactory.Create(QWAgentAction.E_Type.TeleportCamera);
			qWTeleportCameraAction.pos = qWTeleportAction.pos;
			qWTeleportCameraAction.rotation = qWTeleportAction.rotation;
			base.mAgent.Blackboard.ActionAdd(qWTeleportCameraAction);
			break;
		}
		case QWAgentAction.E_Type.BodyDither:
		{
			QWChangeBodyDitherAction dither = a as QWChangeBodyDitherAction;
			ChangeDither(dither);
			break;
		}
		case QWAgentAction.E_Type.LookAt:
		{
			QWLookAtAction action = a as QWLookAtAction;
			LookAt(action);
			break;
		}
		}
	}

	private void CheckPlayAnimAction(QWCharacterPlayAnimAction a)
	{
		if (a != null)
		{
			if (base.mAgent.AgentAnimator == null)
			{
				Debug.LogError("家具交互: 没有动画的尝试播放动画: " + base.mAgent.name);
			}
			else if (!a.forceReplay)
			{
				base.mAgent.AgentAnimator?.CrossFade(a.animName, a.crossFade);
			}
			else
			{
				base.mAgent.AgentAnimator?.CrossFade(a.animName, a.crossFade, 0, 0f);
			}
		}
	}

	private void Teleport(QWTeleportAction teleport)
	{
		if (teleport != null)
		{
			base.mAgent.transform.position = teleport.pos;
			base.mAgent.transform.rotation = teleport.rotation;
			if (base.mAgent.GetAgentLayer() == QWAgentLayer.Player && QWPerformManager.Instance.GetPlayerInteractTarget != null)
			{
				LuaHelper.CallFunction("ForceStopAllPerformTask");
				QWPerformManager.Instance.EndFurniturInteract(QWPerformManager.Instance.GetPlayerInteractTarget);
			}
		}
	}

	public void ChangeDither(QWChangeBodyDitherAction dither)
	{
		if (base.mAgent.GetAgentLayer() != QWAgentLayer.Player)
		{
			return;
		}
		SDCharacter render = (base.mAgent.Blackboard as QWCharacterBlackboard).renderEffect;
		if (render == null)
		{
			return;
		}
		if (ditherTweenId != -1)
		{
			LeanTween.cancel(ditherTweenId);
			ditherTweenId = -1;
		}
		QWBodyDitherChangeFunc showFunc = dither.showFunc;
		float target = dither.targetDither;
		float startDither = render.ditherAlpha;
		switch (showFunc)
		{
		case QWBodyDitherChangeFunc.AutoHide:
		case QWBodyDitherChangeFunc.AutoShow:
			ditherTweenId = LeanTween.value(0f, 1f, dither.ditherDuration).setOnUpdate(delegate(float f)
			{
				render.ditherAlpha = startDither + (target - startDither) * f;
			}).setOnComplete((Action)delegate
			{
				render.ditherAlpha = target;
				ditherTweenId = -1;
			})
				.uniqueId;
			break;
		case QWBodyDitherChangeFunc.Immediate:
			if (render.ditherAlpha != target)
			{
				render.ditherAlpha = target;
			}
			break;
		}
	}

	public void InitDitherControl()
	{
		switch (base.mAgent.GetAgentLayer())
		{
		case QWAgentLayer.Player:
		{
			QWCharacterBlackboard qWCharacterBlackboard = base.mAgent.Blackboard as QWCharacterBlackboard;
			if ((bool)qWCharacterBlackboard)
			{
				qWCharacterBlackboard.bodyDitherComp.RegisterDitherChange(OnDitherChange);
			}
			break;
		}
		case QWAgentLayer.NPC:
		{
			QWNPCBlackboard qWNPCBlackboard = base.mAgent.Blackboard as QWNPCBlackboard;
			if ((bool)qWNPCBlackboard)
			{
				qWNPCBlackboard.bodyDitherComp.RegisterDitherChange(OnDitherChange);
			}
			break;
		}
		}
	}

	private void OnDitherChange(float ratio)
	{
		switch (base.mAgent.GetAgentLayer())
		{
		case QWAgentLayer.Player:
		{
			SDCharacter renderEffect = (base.mAgent.Blackboard as QWCharacterBlackboard).renderEffect;
			if (!(renderEffect == null) && renderEffect.ditherAlpha != ratio)
			{
				renderEffect.ditherAlpha = ratio;
				_ = 0f;
			}
			break;
		}
		case QWAgentLayer.NPC:
		{
			SDCharacter renderEffect = (base.mAgent.Blackboard as QWNPCBlackboard).renderEffect;
			if (!(renderEffect == null) && renderEffect.ditherAlpha != ratio)
			{
				renderEffect.ditherAlpha = ratio;
			}
			break;
		}
		}
	}

	public void LookAt(QWLookAtAction action)
	{
		if (base.mAgent.GetAgentLayer() != QWAgentLayer.NPC)
		{
			return;
		}
		QWNPCBlackboard qWNPCBlackboard = base.mAgent.Blackboard as QWNPCBlackboard;
		if (base.mAgent.Blackboard.isInStage)
		{
			if (qWNPCBlackboard.lookAtComp == null)
			{
				qWNPCBlackboard.lookAtComp = base.gameObject.AddComponent<QWLookAtComponent>();
				qWNPCBlackboard.lookAtComp.head = qWNPCBlackboard.attachPoint.GetHeadBone();
				qWNPCBlackboard.lookAtComp.TryInit();
				qWNPCBlackboard.lookAtComp.Show();
			}
			qWNPCBlackboard.lookAtComp.headWeight = action.headWeight;
			qWNPCBlackboard.lookAtComp.IKPositionWeight = action.IkBoneWeight;
			qWNPCBlackboard.lookAtComp.lerpDuration = action.duration;
			if (qWNPCBlackboard.lookAtType != QworldEntityLookAtType.NotLookAt)
			{
				if (qWNPCBlackboard.lookAtType == QworldEntityLookAtType.EntityId)
				{
					waitLookAtEntityId = qWNPCBlackboard.lookAtEntityId;
				}
				else if (qWNPCBlackboard.lookAtType == QworldEntityLookAtType.Point)
				{
					qWNPCBlackboard.lookAtComp.SetDefaultLookAtPoint(qWNPCBlackboard.lookAtPos);
				}
			}
			else
			{
				qWNPCBlackboard.lookAtComp.SetTarget(action.lookAtTarget);
			}
		}
		else if (qWNPCBlackboard.lookAtComp != null && qWNPCBlackboard.lookAtType == QworldEntityLookAtType.NotLookAt)
		{
			qWNPCBlackboard.lookAtComp.SetTarget(action.lookAtTarget);
		}
	}

	public override void UpdateBehavior()
	{
		if (waitLookAtEntityId == -1)
		{
			return;
		}
		QWorldMapEntity qWorldMapEntity = QWorldScene.Scene?.GetMapManager().GetMapEntityByEntityId(waitLookAtEntityId);
		QWNPCBlackboard nPCBlackBoard = qWorldMapEntity.NPCBlackBoard;
		QWNPCBlackboard qWNPCBlackboard = base.mAgent.Blackboard as QWNPCBlackboard;
		if (!qWNPCBlackboard || !qWNPCBlackboard.lookAtComp)
		{
			return;
		}
		if (nPCBlackBoard != null)
		{
			if (nPCBlackBoard.isInStage)
			{
				qWNPCBlackboard.lookAtComp.SetTarget(nPCBlackBoard.GetHead());
				waitLookAtEntityId = -1;
			}
		}
		else
		{
			qWNPCBlackboard.lookAtComp.SetTarget(qWorldMapEntity.transform);
			waitLookAtEntityId = -1;
		}
	}
}
