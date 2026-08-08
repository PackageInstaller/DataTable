using UnityEngine.Playables;

public class TransformProxyMixer : PlayableBehaviour
{
	public static ScriptPlayable<TransformProxyMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<TransformProxyMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			_ = (ScriptPlayable<TransformProxyBehaviour>)playable.GetInput(i);
		}
	}
}
