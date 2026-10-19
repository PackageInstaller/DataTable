using ACT.Drama;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoLetterBoxingView : BaseUIView
{
	[Tooltip("宽高比反比")]
	public float aspectRatio;

	public RectTransform up;

	public RectTransform down;

	public RectTransform rectTransform;

	public Image blackCurtain;

	public bool run;

	[Header("跳过按钮")]
	public GameObject skipButton;

	[Header("跳过按钮(开发者专用)")]
	public GameObject devSkipButton;

	[Header("黑幕参数")]
	[Tooltip("黑幕动画显示时间")]
	public float duration;

	private float m_CurrentRatio;

	private int m_Width;

	private float m_Offset;

	private Animation m_Animation;

	private readonly float targetAspectRatio = 2.1666667f;

	[Header("黑边")]
	public RectTransform topLetterbox;

	public RectTransform bottomLetterbox;

	public RectTransform leftLetterbox;

	public RectTransform rightLetterbox;

	private Tween tween1;

	private Tween tween2;

	public const string LetterBox1 = "LetterBoxing";

	public const string LetterBox2 = "LetterBoxing_FromCenter";

	public const string LetterBox3 = "LetterBoxing_Fade";

	protected override void Init()
	{
		base.Init();
		if (!m_Animation)
		{
			m_Animation = GetComponent<Animation>();
		}
		if (uiViewData != null && (bool)uiViewData)
		{
			Color color = blackCurtain.color;
			color.a = 1f;
			blackCurtain.color = color;
		}
		skipButton.SetActive(value: false);
		devSkipButton?.SetActive(value: false);
		topLetterbox.sizeDelta = new Vector2(topLetterbox.sizeDelta.x, 0f);
		bottomLetterbox.sizeDelta = new Vector2(bottomLetterbox.sizeDelta.x, 0f);
		leftLetterbox.sizeDelta = new Vector2(0f, leftLetterbox.sizeDelta.y);
		rightLetterbox.sizeDelta = new Vector2(0f, rightLetterbox.sizeDelta.y);
	}

	protected override void UnInit()
	{
		base.UnInit();
		skipButton.SetActive(value: false);
		tween1?.Kill();
		tween2?.Kill();
		tween1 = (tween2 = null);
	}

	private void Update()
	{
		if (run && !Mathf.Approximately(m_CurrentRatio, aspectRatio))
		{
			Translate();
		}
	}

	private void Translate()
	{
		m_Width = (int)rectTransform.rect.width >> 1;
		m_Offset = (int)((float)m_Width * aspectRatio);
		m_Offset = (float)m_Width * aspectRatio;
		up.anchoredPosition = new Vector2(0f, m_Offset);
		down.anchoredPosition = new Vector2(0f, 0f - m_Offset);
		m_CurrentRatio = aspectRatio;
	}

	public void EnterLetterBoxing(string aniName)
	{
		float num = rectTransform.rect.width / rectTransform.rect.height;
		if (!Mathf.Approximately(num, targetAspectRatio))
		{
			if (num > targetAspectRatio)
			{
				float x = (rectTransform.rect.width - rectTransform.rect.height * targetAspectRatio) / 2f;
				tween1 = DOTween.To(() => leftLetterbox.sizeDelta, (Vector2 size) =>
				{
					leftLetterbox.sizeDelta = size;
				}, new Vector2(x, leftLetterbox.sizeDelta.y), duration);
				tween2 = DOTween.To(() => rightLetterbox.sizeDelta, (Vector2 size) =>
				{
					rightLetterbox.sizeDelta = size;
				}, new Vector2(x, rightLetterbox.sizeDelta.y), duration);
			}
			else if (num < targetAspectRatio)
			{
				float y = (rectTransform.rect.height - rectTransform.rect.width / targetAspectRatio) / 2f;
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
		skipButton.SetActive(Singleton<ConversationManager>.instance.CanInterrupt);
		devSkipButton?.SetActive(GameLoader.meta.skipPlot);
	}

	public async UniTask ExitLetterBoxing(string aniName)
	{
		if (tween1 != null)
		{
			tween1.Kill();
		}
		if (tween2 != null)
		{
			tween2.Kill();
		}
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

	public void StopConversation()
	{
		run = false;
		Singleton<ConversationManager>.instance.JumpConversation();
	}
}
