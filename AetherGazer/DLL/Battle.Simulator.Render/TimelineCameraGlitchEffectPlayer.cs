using System.Collections.Generic;
using P08.EnvironmentHelper;

public class TimelineCameraGlitchEffectPlayer : CommonSimpleTimelineClipPlayer<CameraGlitchClip>, ILoopClipPlayer
{
	public int CreationIndex;

	public NAgent Agent;

	public TimelineGlitchEffectHelper TimelineGlitchEffectHelper;

	public void AddBuffCameraGlitchEffect(int buffID, float glitchIntensity, float glitchFrequency)
	{
		TimelineGlitchEffectHelper.AddGlitchEffectClip(CreationIndex, buffID, float.MaxValue, glitchIntensity, glitchFrequency, 0);
	}

	public void RemoveBuffCameraGlitchEffect(int buffID)
	{
		TimelineGlitchEffectHelper.RemoveGlitchEffectClip(CreationIndex, buffID);
	}

	public void UpdateBuffCameraGlitchEffect(int buffID, float glitchIntensity)
	{
		TimelineGlitchEffectHelper.UpdateGlitchEffect(CreationIndex, buffID, 0f, glitchIntensity);
	}

	public void ClearBuffCameraGlitchEffect()
	{
		TimelineGlitchEffectHelper.RemoveGlitchEffectClip(CreationIndex);
	}

	public bool IsPlayer()
	{
		return Agent.IsLocalPlayer;
	}

	protected override void _Initialize(List<CameraGlitchClip> clips)
	{
	}

	protected override void _EnterNodes(List<CameraGlitchClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			CameraGlitchClip cameraGlitchClip = clipsInThisFrame[i];
			if (IsPlayer() || cameraGlitchClip.BotherOthers)
			{
				float pIntensity = cameraGlitchClip.GlitchIntensityValue * cameraGlitchClip.GlitchIntensityCurve.Evaluate(0f);
				float pFrequency = cameraGlitchClip.GlitchFrequencyValue * cameraGlitchClip.GlitchFrequencyCurve.Evaluate(0f);
				TimelineGlitchEffectHelper.AddGlitchEffectClip(CreationIndex, cameraGlitchClip.Key, cameraGlitchClip.Length, pIntensity, pFrequency, 0);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CameraGlitchClip> clipsInThisFrame, float normalized)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			CameraGlitchClip cameraGlitchClip = clipsInThisFrame[i];
			if (IsPlayer() || cameraGlitchClip.BotherOthers)
			{
				float num = (normalized - cameraGlitchClip.NormalizedBegin) / (cameraGlitchClip.NormalizedEnd - cameraGlitchClip.NormalizedBegin);
				float pIntensity = cameraGlitchClip.GlitchIntensityValue * cameraGlitchClip.GlitchIntensityCurve.Evaluate(num);
				float pFrequency = cameraGlitchClip.GlitchFrequencyValue * cameraGlitchClip.GlitchFrequencyCurve.Evaluate(num);
				TimelineGlitchEffectHelper.UpdateGlitchEffect(CreationIndex, cameraGlitchClip.Key, cameraGlitchClip.Length, pIntensity, pFrequency);
			}
		}
	}

	protected override void _ExitNodes(List<CameraGlitchClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlayer() || clipsInThisFrame[i].BotherOthers)
			{
				TimelineGlitchEffectHelper.RemoveGlitchEffectClip(CreationIndex, clipsInThisFrame[i].Key);
			}
		}
	}

	protected override void _Shutdown()
	{
		TimelineGlitchEffectHelper.RemoveGlitchEffectClip(CreationIndex);
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}
}
