using P08.CriLipsEx;
using UnityEngine.Playables;

public class StoryCriwareMixer : PlayableBehaviour
{
	public CriLipsExPlayer m_criLipsExPlayer;

	public static ScriptPlayable<StoryCriwareMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<StoryCriwareMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			((ScriptPlayable<StoryCriwareNodeBehaviour>)playable.GetInput(i)).GetBehaviour().m_criLipsExPlayer = m_criLipsExPlayer;
		}
	}
}
