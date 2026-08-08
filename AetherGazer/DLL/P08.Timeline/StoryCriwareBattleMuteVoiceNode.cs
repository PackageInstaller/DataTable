using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("开关战斗语音(细分)")]
public class StoryCriwareBattleMuteVoiceNode : PlayableAsset
{
	public bool m_SwitchEffectTag;

	public bool m_SwitchVoiceTag;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCriwareBattleMuteVoiceBehaviour> scriptPlayable = ScriptPlayable<StoryCriwareBattleMuteVoiceBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_EffectTag = !m_SwitchEffectTag;
		scriptPlayable.GetBehaviour().m_VoiceTag = !m_SwitchVoiceTag;
		return scriptPlayable;
	}
}
