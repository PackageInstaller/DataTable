using System;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace Dorm.Character;

public class FadeBehaviour : SerializedMonoBehaviour
{
	public SDCharacter sdChara;

	[NonSerialized]
	public Renderer[] renderers;

	private LTDescr fade;

	public Transform fadePointTrs;

	private Vector3? fadePoint;

	public Vector2 fadeRange = new Vector2(0f, 1f);

	private const float FADE_RANGE_MIN = 0.0625f;

	public Vector3? FadePointPos
	{
		get
		{
			if (!fadePointTrs)
			{
				return fadePoint;
			}
			return fadePointTrs.position;
		}
	}

	public float startFade => fadeRange.y;

	public float endFade => fadeRange.x;

	private void Awake()
	{
		if (!sdChara)
		{
			sdChara = base.transform.GetComponent<SDCharacter>();
		}
		renderers = GetComponentsInChildren<Renderer>();
	}

	private void OnDestroy()
	{
		if (fade != null && LeanTween.isTweening(fade.id))
		{
			LeanTween.cancel(base.gameObject, fade.id);
			fade = null;
		}
	}

	public void StartFadeIn(float duration, Action afterFadeIn = null)
	{
		if ((bool)sdChara)
		{
			if (fade != null && LeanTween.isTweening(fade.id))
			{
				LeanTween.cancel(base.gameObject, fade.id);
			}
			fade = LeanTween.value(sdChara.gameObject, SetFadeIncreaseOnly, 0f, 1f, duration).setOnComplete(afterFadeIn);
		}
	}

	public void StartFadeOut(float duration, Action afterFadeOut = null)
	{
		if ((bool)sdChara)
		{
			if (fade != null && LeanTween.isTweening(fade.id))
			{
				LeanTween.cancel(base.gameObject, fade.id);
			}
			fade = LeanTween.value(sdChara.gameObject, SetFadeDecreaseOnly, 1f, 0f, duration).setOnComplete(afterFadeOut);
		}
	}

	public void SetFadeIncreaseOnly(float value)
	{
		if (value > sdChara.ditherAlpha)
		{
			SetFade(value);
		}
	}

	public void SetFadeDecreaseOnly(float value)
	{
		if (value < sdChara.ditherAlpha)
		{
			SetFade(value);
		}
	}

	public void SetFade(float value)
	{
		bool num = ((double)sdChara.ditherAlpha <= 0.2) ^ ((double)value <= 0.2);
		if ((bool)sdChara)
		{
			sdChara.ditherAlpha = value;
		}
		if (num)
		{
			Renderer[] array = renderers;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].enabled = (double)value > 0.2;
			}
		}
	}

	private void Update()
	{
		if ((bool)sdChara && FadePointPos.HasValue)
		{
			float num = startFade - endFade;
			float ditherAlpha = Mathf.Clamp01((Vector3.Distance(FadePointPos.Value, base.transform.position) - endFade) / num);
			sdChara.ditherAlpha = ditherAlpha;
		}
	}

	internal void SetFadeOutAt(Vector3 point, float rangeStart, float rangeEnd)
	{
		fadePoint = point;
		fadeRange = new Vector2(Mathf.Max(rangeEnd, 0f), Mathf.Max(rangeStart, endFade + 0.0625f));
	}

	internal void SetFadeOutAt(Transform point, float rangeStart, float rangeEnd)
	{
		fadePointTrs = point;
		fadeRange = new Vector2(Mathf.Max(rangeEnd, 0f), Mathf.Max(rangeStart, endFade + 0.0625f));
	}

	internal void ClearFadeOutAt()
	{
		fadePointTrs = null;
		fadePoint = null;
		StartFadeIn(0.5f);
	}

	internal void SetVisible(bool visible)
	{
		Renderer[] array = renderers;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].enabled = visible;
		}
	}
}
