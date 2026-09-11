using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("剧情Timeline/特效/连携奥义环境(ComboSkillEnvironment)")]
[TrackClipType(typeof(ComboSkillEnvironmentNode))]
[TrackBindingType(typeof(GameObject))]
public class ComboSkillEnvironmentTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<ComboSkillEnvironmentMixer> scriptPlayable = ComboSkillEnvironmentMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_BoundGameObject = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
		return scriptPlayable;
	}

	internal GameObject GetBinding(PlayableDirector director)
	{
		if (director == null)
		{
			return null;
		}
		Object key = this;
		if (base.isSubTrack)
		{
			key = base.parent;
		}
		Object obj = null;
		if (director != null)
		{
			obj = director.GetGenericBinding(key);
		}
		return (GameObject)obj;
	}
}
