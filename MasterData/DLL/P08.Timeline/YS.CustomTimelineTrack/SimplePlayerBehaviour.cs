using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class SimplePlayerBehaviour : PlayableBehaviour
{
	public SimplePlayerBase m_SimplePlayer;

	public override void OnGraphStart(Playable playable)
	{
		if (!(m_SimplePlayer == null))
		{
			m_SimplePlayer.OnGraphStart();
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		if (!(m_SimplePlayer == null))
		{
			m_SimplePlayer.OnGraphStop();
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		if (!(m_SimplePlayer == null))
		{
			m_SimplePlayer.OnPlayableDestroy();
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!(m_SimplePlayer == null))
		{
			m_SimplePlayer.OnBehaviourPlay();
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!(m_SimplePlayer == null))
		{
			m_SimplePlayer.OnBehaviourPause();
		}
	}
}
