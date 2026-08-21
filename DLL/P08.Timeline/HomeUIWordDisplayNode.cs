using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("主界面角色说话文本")]
public class HomeUIWordDisplayNode : PlayableAsset
{
	public int heroId;

	public int heroVoiceDescId;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<HomeUIWordDisplayNodeBehaviour> scriptPlayable = ScriptPlayable<HomeUIWordDisplayNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().heroId = heroId;
		scriptPlayable.GetBehaviour().heroVoiceDescId = heroVoiceDescId;
		return scriptPlayable;
	}
}
