using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("测试功能/SimplePlayer")]
[TrackClipType(typeof(SimplePlayerNode))]
[TrackBindingType(typeof(SimplePlayerBase))]
public class SimplePlayerTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<SimplePlayerMixer> scriptPlayable = SimplePlayerMixer.Create(graph, inputCount);
		scriptPlayable.GetBehaviour().m_SimplePlayer = GetBinding((go != null) ? go.GetComponent<PlayableDirector>() : null);
		return scriptPlayable;
	}

	private SimplePlayerBase GetBinding(PlayableDirector director)
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
		return (SimplePlayerBase)obj;
	}
}
