using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class NewActivationMixerPlayable : PlayableBehaviour
{
	private NewActivationTrack.PostPlaybackState m_PostPlaybackState;

	private bool m_BoundGameObjectInitialStateIsActive;

	private GameObject m_BoundGameObject;

	public NewActivationTrack.PostPlaybackState postPlaybackState
	{
		get
		{
			return m_PostPlaybackState;
		}
		set
		{
			m_PostPlaybackState = value;
		}
	}

	public static ScriptPlayable<NewActivationMixerPlayable> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<NewActivationMixerPlayable>.Create(graph, inputCount);
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		if (!(m_BoundGameObject == null))
		{
			switch (m_PostPlaybackState)
			{
			case NewActivationTrack.PostPlaybackState.Active:
				m_BoundGameObject.SetActive(value: true);
				break;
			case NewActivationTrack.PostPlaybackState.Inactive:
				m_BoundGameObject.SetActive(value: false);
				break;
			case NewActivationTrack.PostPlaybackState.Revert:
				m_BoundGameObject.SetActive(m_BoundGameObjectInitialStateIsActive);
				break;
			case NewActivationTrack.PostPlaybackState.LeaveAsIs:
				break;
			}
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (m_BoundGameObject == null)
		{
			m_BoundGameObject = playerData as GameObject;
			m_BoundGameObjectInitialStateIsActive = m_BoundGameObject != null && m_BoundGameObject.activeSelf;
		}
		if (m_BoundGameObject == null)
		{
			return;
		}
		int inputCount = playable.GetInputCount();
		bool active = false;
		for (int i = 0; i < inputCount; i++)
		{
			if (playable.GetInputWeight(i) > 0f)
			{
				active = true;
				break;
			}
		}
		m_BoundGameObject.SetActive(active);
	}
}
