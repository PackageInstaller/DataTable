using System;
using Ase.ECS;
using UnityEngine;

[Serializable]
[ClipName("播放动画片段")]
public class PlayAnimationClip : TaskClip
{
	[EditorVariable("动画片段")]
	public AnimationClip clip;

	[VariableName("动画片段名字")]
	public string clipName;

	[VariableName("混合时间比例")]
	public float normalizedTransitionDuration;

	[VariableName("初始时间比例")]
	public float normalizedTimeOffset;

	[VariableName("动画层级")]
	public int layer;

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
		if (!((UnityEngine.Object)(object)clip == null))
		{
			context.GetComponent<AnimatorComponent>().PlayAnimation(clip, (float)currentFrameID / (float)taskDuration * clip.length);
		}
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
		if (!(context == null) && !((UnityEngine.Object)(object)clip == null))
		{
			clip.SampleAnimation(context, (float)currentFrameID / (float)taskDuration * clip.length);
		}
	}
}
