using System.Collections.Generic;
using Cinemachine;

public class TimelineCameraCraneShotClipPlayer : CommonSimpleTimelineClipPlayer<CameraCraneShotClip>, ILoopClipPlayer
{
	public NAgent m_Agent;

	public CinemachineCraneShotExtension m_Extend;

	private bool _Initialized;

	protected override void _Initialize(List<CameraCraneShotClip> clips)
	{
		if (!_Initialized && m_Extend == null)
		{
			CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
			m_Extend = U3DUtil.Get<CinemachineCraneShotExtension>(virtualCameraParam.gameObject);
			_Initialized = true;
		}
	}

	protected override void _EnterNodes(List<CameraCraneShotClip> clipsInThisFrame, float normalized, bool isRolleback = false)
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

	protected override void _UpdateNodes(List<CameraCraneShotClip> clipsInThisFrame, float normalized)
	{
		if (!(m_Extend == null))
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				CameraCraneShotClip cameraCraneShotClip = clipsInThisFrame[i];
				float normalized2 = (normalized - cameraCraneShotClip.NormalizedBegin) / (cameraCraneShotClip.NormalizedEnd - cameraCraneShotClip.NormalizedBegin);
				m_Extend.TickClipNormalized(cameraCraneShotClip, normalized2);
			}
		}
	}

	protected override void _ExitNodes(List<CameraCraneShotClip> clipsInThisFrame, float normalized, bool isRolleback = false)
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
		m_Agent = null;
		if (m_Extend != null)
		{
			m_Extend.RemoveClips(m_runningClips);
		}
		m_Extend = null;
		_Initialized = false;
	}

	private bool IsPlayer()
	{
		return m_Agent.IsLocalPlayer;
	}
}
