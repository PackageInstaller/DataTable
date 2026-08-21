using RogoDigital.Lipsync;
using UnityEngine;
using UnityEngine.Playables;

public class LipSyncNode : PlayableAsset
{
	public LipSyncData lipSyncData;

	public override double duration
	{
		get
		{
			if (!(lipSyncData == null))
			{
				return lipSyncData.length;
			}
			return base.duration;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<LipSyncNodePlayable> scriptPlayable = ScriptPlayable<LipSyncNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().lipSyncData = lipSyncData;
		return scriptPlayable;
	}
}
