using UnityEngine;
using UnityEngine.Playables;

public class ShowWeaponNodeBehaviour : PlayableBehaviour
{
	public ShowWeaponBehaviour.EShowWeaponState isShowOnEnter = ShowWeaponBehaviour.EShowWeaponState.None;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnStart = ShowWeaponBehaviour.EShowWeaponState.None;

	public float start;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnExit = ShowWeaponBehaviour.EShowWeaponState.None;

	public ShowWeaponBehaviour.EShowWeaponState isShowOnEnd = ShowWeaponBehaviour.EShowWeaponState.None;

	public float end = 1f;

	private Animator animator;

	private bool flag_s;

	private bool flag_e;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		Object userData = info.output.GetUserData();
		animator = userData as Animator;
		if (animator == null)
		{
			Debug.LogError("ShowWeaponNodeBehaviour could not get animator!");
			return;
		}
		flag_s = false;
		flag_e = false;
		if (isShowOnEnter != ShowWeaponBehaviour.EShowWeaponState.None)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnEnter == ShowWeaponBehaviour.EShowWeaponState.Show);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
		if (!(animator == null) && isShowOnExit != ShowWeaponBehaviour.EShowWeaponState.None)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnExit == ShowWeaponBehaviour.EShowWeaponState.Show);
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (!(animator == null))
		{
			float num = (float)(playable.GetTime() / playable.GetDuration());
			if (isShowOnStart != ShowWeaponBehaviour.EShowWeaponState.None && num >= start && !flag_s)
			{
				LuaForUtil.ShowWeapon(animator.transform, isShowOnStart == ShowWeaponBehaviour.EShowWeaponState.Show);
				flag_s = true;
			}
			if (isShowOnEnd != ShowWeaponBehaviour.EShowWeaponState.None && (Mathf.Approximately(num, end) || num >= end) && !flag_e)
			{
				LuaForUtil.ShowWeapon(animator.transform, isShowOnEnd == ShowWeaponBehaviour.EShowWeaponState.Show);
				flag_e = true;
			}
		}
	}
}
