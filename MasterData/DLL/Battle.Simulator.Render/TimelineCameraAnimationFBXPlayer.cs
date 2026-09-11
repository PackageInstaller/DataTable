using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class TimelineCameraAnimationFBXPlayer : CommonSimpleTimelineClipPlayer<CameraAnimationFBXClip>
{
	public NAgent agent;

	protected override void _Initialize(List<CameraAnimationFBXClip> clips)
	{
	}

	protected override void _EnterNodes(List<CameraAnimationFBXClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		int agentID = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent().AgentID;
		if (!(agent == null) && agentID == agent.AgentID)
		{
			CameraAnimationFBXClip cameraAnimationFBXClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
			GameObject gameObject = CommonEffectClipPlayer.InstantiateEffect(base.Transform, cameraAnimationFBXClip.Path, string.Empty, Vector3.zero, Vector3.one, Vector3.zero, base.Transform.forward, isAttach: false);
			Transform child = gameObject.transform.GetChild(0);
			if (child != null)
			{
				CinemachineVirtualCamera cinemachineVirtualCamera = U3DUtil.Get<CinemachineVirtualCamera>(child.gameObject);
				cinemachineVirtualCamera.Priority = 15;
				cinemachineVirtualCamera.m_Lens.FieldOfView = 27f;
			}
			EffectController effectController = U3DUtil.Get<EffectController>(gameObject);
			effectController.Initialize(isLoop: false, cameraAnimationFBXClip.Length, 1f, BattleScene.MainPlayerQuality, null);
			effectController.Simulator(0f);
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CameraAnimationFBXClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<CameraAnimationFBXClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override void _Shutdown()
	{
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}
}
