using UnityEngine;

public class ShowWeaponBehaviour : StateMachineBehaviour
{
	public enum EShowWeaponState
	{
		Show,
		Hide,
		None
	}

	public EShowWeaponState isShowOnEnter = EShowWeaponState.None;

	public EShowWeaponState isShowOnStart = EShowWeaponState.None;

	[Range(0f, 1f)]
	public float start;

	public EShowWeaponState isShowOnExit = EShowWeaponState.None;

	public EShowWeaponState isShowOnEnd = EShowWeaponState.None;

	[Range(0f, 1f)]
	public float end = 1f;

	private bool flag_s;

	private bool flag_e;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		flag_s = false;
		flag_e = false;
		if (isShowOnEnter != EShowWeaponState.None)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnEnter == EShowWeaponState.Show);
		}
	}

	public override void OnStateUpdate(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		float normalizedTime = stateInfo.normalizedTime;
		if (isShowOnStart != EShowWeaponState.None && normalizedTime >= start && !flag_s)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnStart == EShowWeaponState.Show);
			flag_s = true;
		}
		if (isShowOnEnd != EShowWeaponState.None && (Mathf.Approximately(normalizedTime, end) || normalizedTime >= end) && !flag_e)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnEnd == EShowWeaponState.Show);
			flag_e = true;
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (isShowOnExit != EShowWeaponState.None)
		{
			LuaForUtil.ShowWeapon(animator.transform, isShowOnExit == EShowWeaponState.Show);
		}
	}
}
