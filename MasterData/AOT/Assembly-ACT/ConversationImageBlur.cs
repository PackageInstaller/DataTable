using System.Collections.Generic;
using ACT.UI;
using Fundamental;
using UnityEngine;

public class ConversationImageBlur : MonoBehaviour
{
	[Range(0f, 1f)]
	public float intensity = 1f;

	public List<UIEffectRendering> UIEffects;

	public BaseUIView UIView;

	private void OnEnable()
	{
		intensity = 0f;
		ApplyIntensity();
		Singleton<NewUIManager>.instance.PushUIEffectRenderingList(this, UIEffects);
	}

	private void OnDisable()
	{
		Singleton<NewUIManager>.instance.PopUIEffectRenderingList(this);
	}

	private void Update()
	{
		ApplyIntensity();
	}

	private void ApplyIntensity()
	{
		if (UIEffects == null)
		{
			return;
		}
		foreach (UIEffectRendering uIEffect in UIEffects)
		{
			if (uIEffect != null)
			{
				uIEffect.Intensity = intensity;
			}
		}
	}
}
