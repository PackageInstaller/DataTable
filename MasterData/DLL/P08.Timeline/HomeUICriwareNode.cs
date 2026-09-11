using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("主界面角色语音")]
public class HomeUICriwareNode : PlayableAsset
{
	public string mCueSheet;

	public string mCueName;

	public string mCueAcb;

	public string mCueAwb;

	public bool useStream = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<HomeUICriwareNodeBehaviour> scriptPlayable = ScriptPlayable<HomeUICriwareNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().mCueSheet = mCueSheet;
		scriptPlayable.GetBehaviour().mCueName = mCueName;
		scriptPlayable.GetBehaviour().mCueAcb = mCueAcb;
		scriptPlayable.GetBehaviour().mCueAwb = mCueAwb;
		scriptPlayable.GetBehaviour().useStream = useStream;
		return scriptPlayable;
	}
}
