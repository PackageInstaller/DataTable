using UnityEngine;
using UnityEngine.Playables;

public class EyeControllerNode : PlayableAsset
{
	public bool closeEyeContol;

	public bool openEyeContolWhenFinish;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<EyeControllerNodePlayable> scriptPlayable = ScriptPlayable<EyeControllerNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().closeEyeContol = closeEyeContol;
		scriptPlayable.GetBehaviour().openEyeContolWhenFinish = openEyeContolWhenFinish;
		return scriptPlayable;
	}
}
