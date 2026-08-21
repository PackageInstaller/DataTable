using System.Collections.Generic;

public class TimelineCameraDampingClipPlayer : CommonSimpleTimelineClipPlayer<CameraDampingClip>, ILoopClipPlayer
{
	public NAgent m_agent;

	public LockTargetCinemachine lockCamera;

	private bool _Initialized;

	protected override void _Initialize(List<CameraDampingClip> clips)
	{
		if (!_Initialized)
		{
			lockCamera = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			_Initialized = true;
		}
	}

	protected override void _EnterNodes(List<CameraDampingClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (lockCamera == null || clipsInThisFrame == null)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlayer() || clipsInThisFrame[i].botherOthers)
			{
				lockCamera.AddCameraDampingClip(m_agent.AgentID, clipsInThisFrame[i]);
			}
		}
	}

	protected override void _UpdateNodes(List<CameraDampingClip> clipsInThisFrame, float normalized)
	{
		if (lockCamera == null || clipsInThisFrame == null)
		{
			return;
		}
		CameraDampingClip cameraDampingClip = lockCamera.UpdateCameraDamping(m_agent.AgentID);
		CameraDampingClip cameraDampingClip2 = null;
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (cameraDampingClip == null)
			{
				break;
			}
			if (cameraDampingClip.Key == clipsInThisFrame[i].Key)
			{
				cameraDampingClip2 = clipsInThisFrame[i];
				break;
			}
		}
		if (cameraDampingClip2 == null)
		{
			lockCamera.OnResetClipData();
			return;
		}
		float time = (normalized - cameraDampingClip2.NormalizedBegin) / (cameraDampingClip2.NormalizedEnd - cameraDampingClip2.NormalizedBegin);
		if (cameraDampingClip2.Damping != null && cameraDampingClip2.Damping.length > 0)
		{
			lockCamera.damping = cameraDampingClip2.Damping.Evaluate(time);
		}
		if (cameraDampingClip2.LookatDamping != null && cameraDampingClip2.LookatDamping.length > 0)
		{
			lockCamera.lookatDamping = cameraDampingClip2.LookatDamping.Evaluate(time);
		}
		if (cameraDampingClip2.LookatDisWithFollow != null && cameraDampingClip2.LookatDisWithFollow.length > 0)
		{
			lockCamera.lookatDisWithFollow = cameraDampingClip2.LookatDisWithFollow.Evaluate(time);
		}
	}

	protected override void _ExitNodes(List<CameraDampingClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (!(lockCamera == null) && clipsInThisFrame != null)
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				lockCamera.RemoveCameraDampingClip(m_agent.AgentID, clipsInThisFrame[i]);
			}
			CameraDampingClip cameraDampingClip = lockCamera.UpdateCameraDamping(m_agent.AgentID);
			if ((lockCamera.agentID == m_agent.AgentID || lockCamera.playerList.Contains(m_agent.AgentID)) && cameraDampingClip == null)
			{
				lockCamera.OnResetClipData();
			}
		}
	}

	protected override void _Shutdown()
	{
		if (!(lockCamera == null) && lockCamera.agentID == m_agent.AgentID)
		{
			lockCamera.OnResetClipData();
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _Stop(bool isForceClean = true)
	{
		if (!(lockCamera == null) && lockCamera.agentID == m_agent.AgentID)
		{
			lockCamera.OnResetClipData();
		}
	}

	private bool IsPlayer()
	{
		return m_agent.IsLocalPlayer;
	}
}
