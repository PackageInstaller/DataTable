using DG.Tweening;
using UnityEngine;

namespace ACT.UI;

public class MonoConversationLetterBox2 : MonoBehaviour
{
	public class LetterboxState
	{
		public bool showTop;

		public bool showBottom;

		public float topPercent;

		public float bottomPercent;

		public float duration = 1f;
	}

	[Header("Black Bars")]
	public RectTransform topLetterbox;

	public RectTransform bottomLetterbox;

	[Header("Default Percentages")]
	[Range(0f, 100f)]
	public float defaultTopPercent = 10f;

	[Range(0f, 100f)]
	public float defaultBottomPercent = 10f;

	private Sequence m_TweenSequence;

	private void Awake()
	{
		SetHeight(topLetterbox, 0f);
		SetHeight(bottomLetterbox, 0f);
	}

	private void OnDisable()
	{
		m_TweenSequence?.Kill();
		m_TweenSequence = null;
	}

	public void SetState(LetterboxState state)
	{
		float num = (state.showTop ? GetHeightByPercent(state.topPercent) : 0f);
		float num2 = (state.showBottom ? GetHeightByPercent(state.bottomPercent) : 0f);
		m_TweenSequence?.Kill();
		m_TweenSequence = null;
		float num3 = Mathf.Max(0f, state.duration);
		if (num3 <= 0f)
		{
			SetHeight(topLetterbox, num);
			SetHeight(bottomLetterbox, num2);
			return;
		}
		m_TweenSequence = DOTween.Sequence();
		m_TweenSequence.Join(DOTween.To(() => GetHeight(topLetterbox), (float height) =>
		{
			SetHeight(topLetterbox, height);
		}, num, num3));
		m_TweenSequence.Join(DOTween.To(() => GetHeight(bottomLetterbox), (float height) =>
		{
			SetHeight(bottomLetterbox, height);
		}, num2, num3));
	}

	public void SetDefaultState(bool display, float duration)
	{
		SetState(new LetterboxState
		{
			showTop = display,
			showBottom = display,
			topPercent = defaultTopPercent,
			bottomPercent = defaultBottomPercent,
			duration = duration
		});
	}

	private float GetHeightByPercent(float percent)
	{
		RectTransform rectTransform = transform as RectTransform;
		if (!(rectTransform == null))
		{
			return rectTransform.rect.height * Mathf.Clamp(percent, 0f, 100f) * 0.01f;
		}
		return 0f;
	}

	private static float GetHeight(RectTransform letterbox)
	{
		if (!(letterbox == null))
		{
			return letterbox.sizeDelta.y;
		}
		return 0f;
	}

	private static void SetHeight(RectTransform letterbox, float height)
	{
		if (!(letterbox == null))
		{
			letterbox.sizeDelta = new Vector2(letterbox.sizeDelta.x, height);
		}
	}
}
