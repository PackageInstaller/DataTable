using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

internal class StoryScenePostEffectMixer : PlayableBehaviour
{
	public SceneSetting m_sceneSetting;

	public static ScriptPlayable<StoryScenePostEffectMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<StoryScenePostEffectMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			ScriptPlayable<StoryScenePostEffectNodeBehaviour> scriptPlayable = (ScriptPlayable<StoryScenePostEffectNodeBehaviour>)playable.GetInput(i);
			scriptPlayable.GetBehaviour().sceneSetting = m_sceneSetting;
			scriptPlayable.GetBehaviour().InitOriginData();
		}
	}
}
