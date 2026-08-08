using UnityEngine.Playables;

public class AnimatorProxyMixer : PlayableBehaviour
{
	public static ScriptPlayable<AnimatorProxyMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<AnimatorProxyMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			_ = (ScriptPlayable<AnimatorProxyBehaviour>)playable.GetInput(i);
		}
	}
}
