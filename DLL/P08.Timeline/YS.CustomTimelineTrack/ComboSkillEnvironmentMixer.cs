using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

internal class ComboSkillEnvironmentMixer : PlayableBehaviour
{
	public GameObject m_BoundGameObject;

	private bool _inSourceSapce;

	public static ScriptPlayable<ComboSkillEnvironmentMixer> Create(PlayableGraph graph, int inputCount)
	{
		return ScriptPlayable<ComboSkillEnvironmentMixer>.Create(graph, inputCount);
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		if (!(m_BoundGameObject == null))
		{
			m_BoundGameObject.SetActive(value: false);
			_inSourceSapce = false;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (m_BoundGameObject == null)
		{
			m_BoundGameObject = playerData as GameObject;
		}
		if (m_BoundGameObject == null || _inSourceSapce)
		{
			return;
		}
		bool flag = false;
		if (SceneDirector.Instance != null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				if (battleScene.GetWorldSatetManager().m_breakEntityID == 0)
				{
					flag = true;
				}
				else
				{
					_inSourceSapce = true;
				}
			}
		}
		bool active = false;
		if (flag)
		{
			int inputCount = playable.GetInputCount();
			for (int i = 0; i < inputCount; i++)
			{
				if (playable.GetInputWeight(i) > 0f)
				{
					active = true;
					break;
				}
			}
		}
		m_BoundGameObject.SetActive(active);
	}
}
