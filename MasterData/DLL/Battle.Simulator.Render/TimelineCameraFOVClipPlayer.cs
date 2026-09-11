using System.Collections.Generic;
using Cinemachine;

public class TimelineCameraFOVClipPlayer : CommonSimpleTimelineClipPlayer<CameraFOVClip>, ILoopClipPlayer
{
	public NAgent m_Agent;

	public CinemachineFieldOfViewExtension m_Extend;

	private bool _Initialized;

	protected override void _Initialize(List<CameraFOVClip> clips)
	{
		if (!_Initialized && m_Extend == null)
		{
			CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
			m_Extend = U3DUtil.Get<CinemachineFieldOfViewExtension>(virtualCameraParam.gameObject);
			_Initialized = true;
		}
	}

	protected override void _EnterNodes(List<CameraFOVClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (m_Extend == null || clipsInThisFrame == null)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlayer() || clipsInThisFrame[i].botherOthers)
			{
				m_Extend.AddClip(clipsInThisFrame[i]);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CameraFOVClip> clipsInThisFrame, float normalized)
	{
		if (!(m_Extend == null))
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				CameraFOVClip cameraFOVClip = clipsInThisFrame[i];
				float normalized2 = (normalized - cameraFOVClip.NormalizedBegin) / (cameraFOVClip.NormalizedEnd - cameraFOVClip.NormalizedBegin);
				m_Extend.TickClipNormalized(cameraFOVClip, normalized2);
			}
		}
	}

	protected override void _ExitNodes(List<CameraFOVClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		if (!(m_Extend == null))
		{
			m_Extend.RemoveClips(clipsInThisFrame);
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	protected override void _Shutdown()
	{
		if (m_Extend != null)
		{
			m_Extend.RemoveClips(m_runningClips);
		}
		m_Agent = null;
		m_Extend = null;
		_Initialized = false;
	}

	private bool IsPlayer()
	{
		return m_Agent.IsLocalPlayer;
	}
}
