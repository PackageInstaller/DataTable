using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/改变timeline播放速度")]
[TrackClipType(typeof(StoryTimelineChangeSpeedNode))]
[TrackBindingType(typeof(PlayableDirector))]
public class StoryTimelineChangeSpeedTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<StoryTimelineChangeSpeedTrackBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineChangeSpeedTrackBehaviour>.Create(graph, inputCount);
		foreach (TimelineClip clip in GetClips())
		{
			if (clip.asset is StoryTimelineChangeSpeedNode storyTimelineChangeSpeedNode)
			{
				float num = 0f;
				int num2 = (int)(clip.duration / 0.0333333);
				for (int i = 0; i < num2; i++)
				{
					float time = (float)i * 0.0333333f;
					float num3 = storyTimelineChangeSpeedNode.speedCurve.Evaluate(time);
					num += 0.0333333f / num3;
				}
				int num4 = Mathf.CeilToInt(num / 0.0333333f);
				clip.displayName = $"改变Timeline播放速度(变速后总耗时:{Math.Round(num, 3)}秒 {num4}帧)";
			}
		}
		return scriptPlayable;
	}
}
