using UnityEngine;

namespace ACT.UI;

public class MonoBlackLoadView : BaseUIView
{
	public GameObject triangle;

	protected override void Init()
	{
		base.Init();
	}

	protected override void OpenEffectCallback()
	{
		triangle.SetActive(value: true);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("Show");
	}

	protected override void PlayCloseAnimation()
	{
		triangle.SetActive(value: false);
		uiEffectAnimator.Play("Hide");
	}
}
