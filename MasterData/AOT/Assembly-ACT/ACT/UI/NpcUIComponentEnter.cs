using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class NpcUIComponentEnter : NpcUIComponentBase
{
	public Animator animator;

	public LocalizeStringEvent des;

	public override void Init()
	{
		base.Init();
		if ((bool)animator)
		{
			animator.keepAnimatorStateOnDisable = true;
		}
	}

	public override void UnInit()
	{
		base.UnInit();
		if ((bool)animator)
		{
			animator.keepAnimatorStateOnDisable = false;
		}
	}

	public override void ShowRefresh(bool enter)
	{
		if (enter)
		{
			animator.SetBool("Show", value: true);
		}
		else
		{
			animator.SetBool("Show", value: false);
		}
	}
}
