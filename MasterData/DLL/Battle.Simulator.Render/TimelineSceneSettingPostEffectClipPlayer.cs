using System.Collections.Generic;
using P08.EnvironmentHelper;

public class TimelineSceneSettingPostEffectClipPlayer : CommonSimpleTimelineClipPlayer<SceneSettingPostEffectClip>
{
	public int CreationIndex;

	public NAgent m_Agent;

	public TimelinePostEffectHelper TimelinePostEffectHelper;

	protected override void _Initialize(List<SceneSettingPostEffectClip> clips)
	{
	}

	protected override void _EnterNodes(List<SceneSettingPostEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsLocalPlayer() || clipsInThisFrame[i].EffectWhileNotLocalPlayer)
			{
				TimelinePostEffectHelper.AddPostEffectClip(CreationIndex, clipsInThisFrame[i]);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<SceneSettingPostEffectClip> clipsInThisFrame, float normalized)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			SceneSettingPostEffectClip sceneSettingPostEffectClip = clipsInThisFrame[i];
			float pNormalized = (normalized - sceneSettingPostEffectClip.NormalizedBegin) / (sceneSettingPostEffectClip.NormalizedEnd - sceneSettingPostEffectClip.NormalizedBegin);
			TimelinePostEffectHelper.UpdatePostEffect(CreationIndex, clipsInThisFrame[i], pNormalized);
		}
	}

	protected override void _ExitNodes(List<SceneSettingPostEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			TimelinePostEffectHelper.RemovePostEffectClip(CreationIndex, clipsInThisFrame[i].Key);
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	protected override void _Shutdown()
	{
	}

	private bool IsLocalPlayer()
	{
		return m_Agent.IsLocalPlayer;
	}
}
