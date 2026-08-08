using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("播放镜头前特效")]
public class PlayCameraEffectNode : PlayableAsset
{
	public string m_effectPath = string.Empty;

	public float m_time = 1f;

	public Vector3 m_offset = Vector3.zero;

	public float m_fieldOfView = 55f;

	public Vector2 m_aspectRate = new Vector2(1920f, 1080f);

	public float m_nearValue = 0.3f;

	public bool m_stopIfDestroy;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<PlayCameraEffectBehaviour> scriptPlayable = ScriptPlayable<PlayCameraEffectBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_effectPath = m_effectPath;
		scriptPlayable.GetBehaviour().m_time = m_time;
		scriptPlayable.GetBehaviour().m_offset = m_offset;
		scriptPlayable.GetBehaviour().m_fieldOfView = m_fieldOfView;
		scriptPlayable.GetBehaviour().m_aspectRate = m_aspectRate;
		scriptPlayable.GetBehaviour().m_stopIfDestroy = m_stopIfDestroy;
		return scriptPlayable;
	}
}
