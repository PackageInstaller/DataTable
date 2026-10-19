using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

public class MonoConversationColorScreen : MonoBehaviour
{
	public Image colorImage;

	public CanvasGroup canvasGroup;

	private bool m_Visible;

	private Tween m_Tween;

	public async UniTask Show(Color color, float speed)
	{
		if (m_Visible)
		{
			return;
		}
		m_Visible = true;
		m_Tween.Kill();
		m_Tween = null;
		if (speed <= 0f)
		{
			gameObject.SetActive(value: true);
			canvasGroup.alpha = 1f;
			colorImage.color = color;
			return;
		}
		gameObject.SetActive(value: true);
		canvasGroup.alpha = 0f;
		colorImage.color = color;
		m_Tween = canvasGroup.DOFade(1f, speed);
		await m_Tween;
		if ((bool)this)
		{
			m_Tween = null;
		}
	}

	public void ForceShow(Color color)
	{
		m_Visible = true;
		m_Tween?.Kill();
		m_Tween = null;
		gameObject.SetActive(value: true);
		canvasGroup.alpha = 1f;
		colorImage.color = color;
	}

	public async UniTask Hide(float speed)
	{
		if (!m_Visible)
		{
			return;
		}
		m_Visible = false;
		m_Tween?.Kill();
		m_Tween = null;
		if (speed <= 0f)
		{
			canvasGroup.gameObject.SetActive(value: false);
			canvasGroup.alpha = 0f;
			return;
		}
		canvasGroup.gameObject.SetActive(value: true);
		canvasGroup.alpha = 1f;
		m_Tween = canvasGroup.DOFade(0f, speed);
		await m_Tween;
		if ((bool)this)
		{
			m_Tween = null;
			canvasGroup.gameObject.SetActive(value: false);
		}
	}

	public void ForceHide()
	{
		m_Visible = false;
		m_Tween?.Kill();
		m_Tween = null;
		if ((bool)canvasGroup)
		{
			canvasGroup.alpha = 0f;
			canvasGroup.gameObject.SetActive(value: false);
		}
	}

	public void Init()
	{
		ForceHide();
	}

	public void UnInit()
	{
		ForceHide();
	}
}
