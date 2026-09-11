using System.Collections.Generic;
using P08.EnvironmentHelper;

public class TimelineCameraAbberationEffectPlayer : CommonSimpleTimelineClipPlayer<CameraAbberationClip>, ILoopClipPlayer
{
	public int CreationIndex;

	public NAgent Agent;

	public TimelineAbberationEffectHelper TimelineAbberationEffectHelper;

	private bool m_isRegister;

	private bool m_isHitTarget;

	public void AddBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		TimelineAbberationEffectHelper.AddAbberationEffectClip(CreationIndex, buffID, float.MaxValue, abberationIntensity, pIsActive: true, 0);
	}

	public void RemoveBuffCameraAbberationEffect(int buffID)
	{
		TimelineAbberationEffectHelper.RemoveAbberationEffectClip(CreationIndex, buffID);
	}

	public void UpdateBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		TimelineAbberationEffectHelper.UpdateAbberationEffect(CreationIndex, buffID, abberationIntensity, 0f, pIsActive: true);
	}

	public void ClearBuffCameraAbberationEffect()
	{
		ResetCameraAbberationParams();
	}

	public void ResetCameraAbberationParams()
	{
		TimelineAbberationEffectHelper.RemoveAbberationEffectClip(CreationIndex);
	}

	public bool IsPlayer()
	{
		return Agent.IsLocalPlayer;
	}

	public void OnHitTarget(HitTargetEvent hit)
	{
		if (hit.mAttackerID == CreationIndex)
		{
			m_isHitTarget = true;
		}
	}

	protected override void _Initialize(List<CameraAbberationClip> clips)
	{
		if (!m_isRegister)
		{
			ClientSimulator.Instance.GetSimToPresentation().AddHandler<HitTargetEvent>(OnHitTarget);
			m_isRegister = true;
		}
	}

	protected override void _EnterNodes(List<CameraAbberationClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			CameraAbberationClip cameraAbberationClip = clipsInThisFrame[i];
			if (IsPlayer() || cameraAbberationClip.BotherOthers)
			{
				TimelineAbberationEffectHelper.AddAbberationEffectClip(CreationIndex, cameraAbberationClip.Key, cameraAbberationClip.Length, 0f, !cameraAbberationClip.OnlyHit, cameraAbberationClip.Priority);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CameraAbberationClip> clipsInThisFrame, float normalized)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			CameraAbberationClip cameraAbberationClip = clipsInThisFrame[i];
			if (IsPlayer() || cameraAbberationClip.BotherOthers)
			{
				float num = (normalized - cameraAbberationClip.NormalizedBegin) / (cameraAbberationClip.NormalizedEnd - cameraAbberationClip.NormalizedBegin);
				float pIntensity = cameraAbberationClip.AbberationIntensityValue * cameraAbberationClip.AbberationIntensityCurve.Evaluate(num);
				TimelineAbberationEffectHelper.UpdateAbberationEffect(CreationIndex, cameraAbberationClip.Key, pIntensity, num, !cameraAbberationClip.OnlyHit || m_isHitTarget);
			}
		}
	}

	protected override void _ExitNodes(List<CameraAbberationClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		m_isHitTarget = false;
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlayer() || clipsInThisFrame[i].BotherOthers)
			{
				TimelineAbberationEffectHelper.RemoveAbberationEffectClip(CreationIndex, clipsInThisFrame[i].Key);
			}
		}
	}

	protected override void _Shutdown()
	{
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<HitTargetEvent>(OnHitTarget);
		ResetCameraAbberationParams();
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}
}
