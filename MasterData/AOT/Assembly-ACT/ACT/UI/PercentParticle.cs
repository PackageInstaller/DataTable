using UnityEngine;

namespace ACT.UI;

public class PercentParticle : MonoBehaviour
{
	public RectTransform targetRect;

	public ParticleSystem particleSystem;

	private RectTransform m_Rect;

	private Vector3 m_TargetLocalPos;

	private void Start()
	{
		m_Rect = transform as RectTransform;
		m_TargetLocalPos = targetRect.localPosition;
	}

	public void Play(bool leftBase, float fillAmount)
	{
		PlayParticle(leftBase, fillAmount);
	}

	public void Stop()
	{
		particleSystem.Stop();
	}

	private void PlayParticle(bool leftBase, float fillAmount)
	{
		RectTransform rectTransform = targetRect;
		float x = targetRect.anchoredPosition.x + rectTransform.rect.x + (leftBase ? (rectTransform.rect.width * fillAmount) : (rectTransform.sizeDelta.x * (1f - fillAmount)));
		(transform as RectTransform).anchoredPosition = new Vector3(x, 0f);
		particleSystem.Stop();
		particleSystem.Play();
	}
}
