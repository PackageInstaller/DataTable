using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("开关战斗语音")]
public class StoryCriwareBattleMuteNode : PlayableAsset
{
	public bool m_SwitchTag;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCriwareBattleMuteBehaviour> scriptPlayable = ScriptPlayable<StoryCriwareBattleMuteBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_SwitchTag = !m_SwitchTag;
		return scriptPlayable;
	}
}
