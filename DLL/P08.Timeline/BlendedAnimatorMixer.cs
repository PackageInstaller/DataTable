using UnityEngine;
using UnityEngine.Playables;

public class BlendedAnimatorMixer : PlayableBehaviour
{
	public Animator animator;

	public static ScriptPlayable<BlendedAnimatorMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<BlendedAnimatorMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			((ScriptPlayable<BlendedAnimatorNodeBehaviour>)playable.GetInput(i)).GetBehaviour().animator = animator;
		}
	}
}
