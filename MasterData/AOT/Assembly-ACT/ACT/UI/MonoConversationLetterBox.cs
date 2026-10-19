using DG.Tweening;
using UnityEngine;

namespace ACT.UI;

public class MonoConversationLetterBox : MonoBehaviour
{
	public class LetterboxState
	{
		public bool display;

		public float duration = 1f;
	}

	private const float TargetAspectRatio = 2.1666667f;

	[Header("黑边")]
	public RectTransform topLetterbox;

	public RectTransform bottomLetterbox;

	public RectTransform leftLetterbox;

	public RectTransform rightLetterbox;

	private Tween tween1;

	private Tween tween2;

	private void Awake()
	{
		topLetterbox.sizeDelta = new Vector2(topLetterbox.sizeDelta.x, 0f);
		bottomLetterbox.sizeDelta = new Vector2(bottomLetterbox.sizeDelta.x, 0f);
		leftLetterbox.sizeDelta = new Vector2(0f, leftLetterbox.sizeDelta.y);
		rightLetterbox.sizeDelta = new Vector2(0f, rightLetterbox.sizeDelta.y);
	}

	private void OnDisable()
	{
		UnInit();
	}

	public void Init()
	{
		UnInit();
	}

	public void UnInit()
	{
		tween1?.Kill();
		tween2?.Kill();
		tween1 = (tween2 = null);
		if ((bool)topLetterbox)
		{
			topLetterbox.sizeDelta = new Vector2(topLetterbox.sizeDelta.x, 0f);
		}
		if ((bool)bottomLetterbox)
		{
			bottomLetterbox.sizeDelta = new Vector2(bottomLetterbox.sizeDelta.x, 0f);
		}
		if ((bool)leftLetterbox)
		{
			leftLetterbox.sizeDelta = new Vector2(0f, leftLetterbox.sizeDelta.y);
		}
		if ((bool)rightLetterbox)
		{
			rightLetterbox.sizeDelta = new Vector2(0f, rightLetterbox.sizeDelta.y);
		}
	}

	public void SetState(LetterboxState state)
	{
		if (state.display)
		{
			EnterLetterBoxing(state.duration);
		}
		else
		{
			ExitLetterBoxing(state.duration);
		}
	}

	private void EnterLetterBoxing(float duration)
	{
		gameObject.SetActive(value: true);
		tween1?.Kill();
		tween2?.Kill();
		tween1 = (tween2 = null);
		RectTransform rectTransform = (RectTransform)transform;
		float num = rectTransform.rect.width / rectTransform.rect.height;
		if (Mathf.Approximately(num, 2.1666667f))
		{
			return;
		}
		if (num > 2.1666667f)
		{
			float x = (rectTransform.rect.width - rectTransform.rect.height * 2.1666667f) / 2f;
			tween1 = DOTween.To(() => leftLetterbox.sizeDelta, (Vector2 size) =>
			{
				leftLetterbox.sizeDelta = size;
			}, new Vector2(x, leftLetterbox.sizeDelta.y), duration);
			tween2 = DOTween.To(() => rightLetterbox.sizeDelta, (Vector2 size) =>
			{
				rightLetterbox.sizeDelta = size;
			}, new Vector2(x, rightLetterbox.sizeDelta.y), duration);
		}
		else if (num < 2.1666667f)
		{
			float y = (rectTransform.rect.height - rectTransform.rect.width / 2.1666667f) / 2f;
			tween1 = DOTween.To(() => topLetterbox.sizeDelta, (Vector2 size) =>
			{
				topLetterbox.sizeDelta = size;
			}, new Vector2(topLetterbox.sizeDelta.x, y), duration);
			tween2 = DOTween.To(() => bottomLetterbox.sizeDelta, (Vector2 size) =>
			{
				bottomLetterbox.sizeDelta = size;
			}, new Vector2(bottomLetterbox.sizeDelta.x, y), duration);
		}
	}

	private void ExitLetterBoxing(float duration)
	{
		tween1?.Kill();
		tween2?.Kill();
		tween1 = (tween2 = null);
		if (topLetterbox.sizeDelta.y > 0f)
		{
			DOTween.To(() => topLetterbox.sizeDelta, (Vector2 size) =>
			{
				topLetterbox.sizeDelta = size;
			}, new Vector2(topLetterbox.sizeDelta.x, 0f), duration);
			DOTween.To(() => bottomLetterbox.sizeDelta, (Vector2 size) =>
			{
				bottomLetterbox.sizeDelta = size;
			}, new Vector2(bottomLetterbox.sizeDelta.x, 0f), duration);
		}
		else if (leftLetterbox.sizeDelta.x > 0f)
		{
			DOTween.To(() => leftLetterbox.sizeDelta, (Vector2 size) =>
			{
				leftLetterbox.sizeDelta = size;
			}, new Vector2(0f, leftLetterbox.sizeDelta.y), duration);
			DOTween.To(() => rightLetterbox.sizeDelta, (Vector2 size) =>
			{
				rightLetterbox.sizeDelta = size;
			}, new Vector2(0f, rightLetterbox.sizeDelta.y), duration);
		}
	}
}
