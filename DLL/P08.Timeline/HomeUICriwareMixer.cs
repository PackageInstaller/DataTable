using P08.CriLipsEx;
using UnityEngine.Playables;

public class HomeUICriwareMixer : PlayableBehaviour
{
	public CriLipsExPlayer m_criLipsExPlayer;

	public static ScriptPlayable<HomeUICriwareMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<HomeUICriwareMixer>.Create(graph, inputCount);
	}

	public override void OnGraphStart(Playable playable)
	{
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			((ScriptPlayable<HomeUICriwareNodeBehaviour>)playable.GetInput(i)).GetBehaviour().m_criLipsExPlayer = m_criLipsExPlayer;
		}
	}
}
