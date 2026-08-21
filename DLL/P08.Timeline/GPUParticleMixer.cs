using UnityEngine;
using UnityEngine.Playables;

public class GPUParticleMixer : PlayableBehaviour
{
	public GameObject m_effect;

	public static ScriptPlayable<GPUParticleMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<GPUParticleMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			((ScriptPlayable<GPUParticleNodeBehaviour>)playable.GetInput(i)).GetBehaviour().effect = m_effect;
		}
	}
}
