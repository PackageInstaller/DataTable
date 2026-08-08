using UnityEngine;

public class FadeGroup
{
	public float groupFade;

	private LTDescr fadeTween;

	public void StartFadeIn(GameObject gameObject)
	{
		if ((bool)gameObject)
		{
			if (fadeTween != null && LeanTween.isTweening(fadeTween.id))
			{
				LeanTween.cancel(gameObject, fadeTween.id);
			}
			fadeTween = LeanTween.value(gameObject, SetFadeIncreaseOnly, 0f, 1f, 0.5f);
		}
	}

	public void StartFadeOut(GameObject gameObject)
	{
		if ((bool)gameObject)
		{
			if (fadeTween != null && LeanTween.isTweening(fadeTween.id))
			{
				LeanTween.cancel(gameObject, fadeTween.id);
			}
			fadeTween = LeanTween.value(gameObject, SetFadeDecreaseOnly, 1f, 0f, 0.5f);
		}
	}

	private void SetFadeIncreaseOnly(float value)
	{
		if (value > groupFade)
		{
			groupFade = value;
		}
	}

	private void SetFadeDecreaseOnly(float value)
	{
		if (value < groupFade)
		{
			groupFade = value;
		}
	}
}
