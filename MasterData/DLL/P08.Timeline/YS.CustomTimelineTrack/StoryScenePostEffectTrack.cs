using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/特效/场景后处理(StoryScenePostEffect)")]
[TrackClipType(typeof(StoryScenePostEffectNode))]
[TrackBindingType(typeof(SceneSetting))]
public class StoryScenePostEffectTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<StoryScenePostEffectMixer> scriptPlayable = StoryScenePostEffectMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_sceneSetting = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
		return scriptPlayable;
	}

	private SceneSetting GetBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		UnityEngine.Object key = this;
		if (base.isSubTrack)
		{
			key = base.parent;
		}
		UnityEngine.Object obj = null;
		if (director != null)
		{
			obj = director.GetGenericBinding(key);
		}
		return (SceneSetting)obj;
	}
}
