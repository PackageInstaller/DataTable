using UnityEngine;
using UnityEngine.Playables;

public class ShowWeaponNode : PlayableAsset
{
	public ShowWeaponBehaviour.EShowWeaponState isShowOnEnter = ShowWeaponBehaviour.EShowWeaponState.None;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnStart = ShowWeaponBehaviour.EShowWeaponState.None;

	[Range(0f, 1f)]
	public float start;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnExit = ShowWeaponBehaviour.EShowWeaponState.None;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnEnd = ShowWeaponBehaviour.EShowWeaponState.None;

	[Range(0f, 1f)]
	public float end = 1f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<ShowWeaponNodeBehaviour> scriptPlayable = ScriptPlayable<ShowWeaponNodeBehaviour>.Create(graph);
		ShowWeaponNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.isShowOnEnter = isShowOnEnter;
		behaviour.isShowOnStart = isShowOnStart;
		behaviour.start = start;
		behaviour.isShowOnExit = isShowOnExit;
		behaviour.isShowOnEnd = isShowOnEnd;
		behaviour.end = end;
		return scriptPlayable;
	}
}
