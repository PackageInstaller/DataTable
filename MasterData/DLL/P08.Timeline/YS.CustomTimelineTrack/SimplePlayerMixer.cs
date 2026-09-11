using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

internal class SimplePlayerMixer : PlayableBehaviour
{
	public SimplePlayerBase m_SimplePlayer;

	public static ScriptPlayable<SimplePlayerMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<SimplePlayerMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			((ScriptPlayable<SimplePlayerBehaviour>)playable.GetInput(i)).GetBehaviour().m_SimplePlayer = m_SimplePlayer;
		}
	}
}
