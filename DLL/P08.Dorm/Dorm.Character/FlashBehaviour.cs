using System;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace Dorm.Character;

public class FlashBehaviour : SerializedMonoBehaviour
{
	public SDCharacter sdChara;

	public AnimationCurve flashRatioCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	private LTDescr curTween;

	private void Start()
	{
		if (!sdChara)
		{
			sdChara = base.transform.GetComponent<SDCharacter>();
		}
	}

	private void OnDestroy()
	{
		InterruptFlash();
	}

	public void SetFlashColor(Color outerColor, Color innerColor, float soft)
	{
		sdChara.flashOuterColor = outerColor;
		sdChara.flashInnerColor = innerColor;
		sdChara.flashFillSoft = soft;
	}

	private void InterruptFlash()
	{
		if (curTween != null)
		{
			LeanTween.cancel(base.gameObject, curTween.id, callOnComplete: true);
			curTween = null;
		}
	}

	internal void SetFlash(float ratio)
	{
		InterruptFlash();
		sdChara.flashRatio = ratio;
	}

	public void Flash(float duration, AnimationCurve animationCurve)
	{
		InterruptFlash();
		LeanTween.value(base.gameObject, 0f, 1f, duration).setEase(animationCurve ?? flashRatioCurve).setOnUpdate(delegate(float r)
		{
			sdChara.flashRatio = r;
		})
			.setOnComplete((Action)delegate
			{
				curTween = null;
			});
	}
}
