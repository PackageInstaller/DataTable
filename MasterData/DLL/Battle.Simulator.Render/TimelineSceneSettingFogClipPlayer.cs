using System.Collections.Generic;
using P08.EnvironmentHelper;
using UnityEngine;

public class TimelineSceneSettingFogClipPlayer : CommonSimpleTimelineClipPlayer<SceneSettingFogClip>
{
	public TimelineDynamicFogEffectHelper TimelineDynamicFogEffectHelper;

	public TimelineTintEffectHelper TimelineTintEffectHelper;

	public NAgent Agent;

	public int CreationIndex;

	public EnMemberPositionOfFog MemberPosition;

	private int testPos = 1;

	public void AddBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog memberPositionOfFog, float dynamicFogIntensity, EnMemberPositionOfFog memberPositionOfTintColor, Color fogColor, Color tintColor)
	{
		if ((NScene.GetCurrentScene() as BattleScene).GetBuffManager().TryGetBuffByAgentIDAndBuffID(CreationIndex, buffID, out var buffState))
		{
			if (memberPositionOfFog != EnMemberPositionOfFog.None)
			{
				TimelineDynamicFogEffectHelper.Play(CreationIndex, memberPositionOfFog, buffID, dynamicFogIntensity, (float)buffState.mBuffKeepTime / 1000f, 0f, fogColor);
			}
			if (memberPositionOfTintColor != EnMemberPositionOfFog.None)
			{
				TimelineTintEffectHelper.Play(CreationIndex, memberPositionOfTintColor, buffID, (float)buffState.mBuffKeepTime / 1000f, 0f, tintColor);
			}
		}
	}

	public void RemoveBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog memberPositionOfFog, EnMemberPositionOfFog memberPositionOfTintColor)
	{
		if (memberPositionOfFog != EnMemberPositionOfFog.None)
		{
			TimelineDynamicFogEffectHelper.Stop(CreationIndex, memberPositionOfFog, buffID);
		}
		if (memberPositionOfTintColor != EnMemberPositionOfFog.None)
		{
			TimelineTintEffectHelper.Stop(CreationIndex, memberPositionOfTintColor, buffID);
		}
	}

	public void UpdateBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog memberPositionOfFog, float dynamicFogIntensity, EnMemberPositionOfFog memberPositionOfTintColor, Color fogColor, Color tintColor)
	{
		if ((NScene.GetCurrentScene() as BattleScene).GetBuffManager().TryGetBuffByAgentIDAndBuffID(CreationIndex, buffID, out var buffState))
		{
			float normalized = 1f - (float)buffState.mDuring / (float)buffState.mBuffKeepTime;
			if (memberPositionOfFog != EnMemberPositionOfFog.None)
			{
				TimelineDynamicFogEffectHelper.Play(CreationIndex, memberPositionOfFog, buffID, dynamicFogIntensity, (float)buffState.mBuffKeepTime / 1000f, normalized, fogColor);
			}
			if (memberPositionOfTintColor != EnMemberPositionOfFog.None)
			{
				TimelineTintEffectHelper.Play(CreationIndex, memberPositionOfTintColor, buffID, (float)buffState.mBuffKeepTime / 1000f, normalized, tintColor);
			}
		}
	}

	public void ClearBuffSceneSettingDynamicFogEffect()
	{
		ResetSceneSettingFog();
	}

	public void ResetSceneSettingFog()
	{
		TimelineDynamicFogEffectHelper.Stop(CreationIndex, MemberPosition, 0);
		TimelineTintEffectHelper.Stop(CreationIndex, MemberPosition, 0);
	}

	protected override void _Initialize(List<SceneSettingFogClip> clips)
	{
	}

	protected override void _EnterNodes(List<SceneSettingFogClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<SceneSettingFogClip> clipsInThisFrame, float normalized)
	{
		if (MemberPosition != EnMemberPositionOfFog.Player || CreationIndex == (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mPlayerAgentID)
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				SceneSettingFogClip sceneSettingFogClip = clipsInThisFrame[i];
				float num = (normalized - sceneSettingFogClip.NormalizedBegin) / (sceneSettingFogClip.NormalizedEnd - sceneSettingFogClip.NormalizedBegin);
				float intensityValue = sceneSettingFogClip.DynamicFogIntensityCurve.Evaluate(num * sceneSettingFogClip.Length);
				float normalized2 = (normalized - sceneSettingFogClip.NormalizedBegin) / (sceneSettingFogClip.NormalizedEnd - sceneSettingFogClip.NormalizedBegin);
				TimelineDynamicFogEffectHelper.Play(CreationIndex, MemberPosition, sceneSettingFogClip.Key, intensityValue, sceneSettingFogClip.Length, normalized2, sceneSettingFogClip.DynamicFogColor, sceneSettingFogClip.DynamicFogIntensityCurve);
				TimelineTintEffectHelper.Play(CreationIndex, MemberPosition, sceneSettingFogClip.Key, sceneSettingFogClip.Length, normalized2, sceneSettingFogClip.TintColor);
			}
		}
	}

	protected override void _ExitNodes(List<SceneSettingFogClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			SceneSettingFogClip sceneSettingFogClip = clipsInThisFrame[i];
			TimelineDynamicFogEffectHelper.Stop(CreationIndex, MemberPosition, sceneSettingFogClip.Key);
			TimelineTintEffectHelper.Stop(CreationIndex, MemberPosition, sceneSettingFogClip.Key);
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	protected override void _Shutdown()
	{
		ResetSceneSettingFog();
	}
}
