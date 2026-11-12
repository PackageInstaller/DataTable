using UnityEngine;
using UnityEngine.Playables;

public sealed class L2DAnimClip : PlayableAsset
{
	public ExposedReference<L2DAnimPlayer> PLAYER;

	public string NAME;

	public bool LOOP;

	public bool PreHOLD;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<L2DAnimBehaviour> scriptPlayable = ScriptPlayable<L2DAnimBehaviour>.Create(graph);
		L2DAnimBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.player = PLAYER.Resolve(scriptPlayable.GetGraph().GetResolver());
		behaviour.name = NAME;
		behaviour.loop = LOOP;
		behaviour.preHold = PreHOLD;
		return scriptPlayable;
	}
}
