using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("QWorld/剧情Timeline/特效/场景后处理(StoryScenePostEffect)")]
[TrackClipType(typeof(QWorldStoryScenePostEffectNode))]
[TrackBindingType(typeof(SceneSetting))]
public class QWorldStoryScenePostEffectTrack : TrackAsset
{
	private class QWorldStoryScenePostEffectMixer : PlayableBehaviour
	{
		public SceneSetting m_sceneSetting;

		public static ScriptPlayable<QWorldStoryScenePostEffectMixer> Create(PlayableGraph graph, int inputCount)
		{
			return ScriptPlayable<QWorldStoryScenePostEffectMixer>.Create(graph, inputCount);
		}

		public override void OnGraphStart(Playable playable)
		{
			for (int i = 0; i < playable.GetInputCount(); i++)
			{
				ScriptPlayable<QWorldStoryScenePostEffectNodeBehaviour> scriptPlayable = (ScriptPlayable<QWorldStoryScenePostEffectNodeBehaviour>)playable.GetInput(i);
				scriptPlayable.GetBehaviour().sceneSetting = m_sceneSetting;
				scriptPlayable.GetBehaviour().InitOriginData();
			}
		}
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<QWorldStoryScenePostEffectMixer> scriptPlayable = QWorldStoryScenePostEffectMixer.Create(graph, inputCount);
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
