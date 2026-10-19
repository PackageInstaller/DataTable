using System;
using ACT.UI;
using UnityEngine;

namespace ACT.Battle;

internal class CursorEffect : EffectParameters
{
	private RectTransform selfTransform;

	private BetterAnimation anim;

	public override void Init()
	{
		selfTransform = Obj.GetComponent<RectTransform>();
		anim = Obj.GetComponent<BetterAnimation>();
		selfTransform.localScale = new Vector3(1.1f, 1.1f, 1f);
		Obj.SetActive(value: false);
	}

	public void PlayAnim(Vector2 position, Action<CursorEffect> onComplete = null)
	{
		selfTransform.anchoredPosition = position;
		anim.StopAnimation();
		Obj.SetActive(value: true);
		anim.GetSequence("click_ef").OnComplete((AnimationBuilder __) =>
		{
			onComplete?.Invoke(this);
		}).Play();
	}

	public override void UnInit()
	{
		Obj.SetActive(value: false);
	}
}
