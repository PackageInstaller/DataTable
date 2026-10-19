using System;
using System.Threading;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ConversationImage : UIBehaviour
{
	public CanvasGroup canvasGroup;

	public Image image;

	public UIRelativeEffect blur;

	private AssetLoadHandle m_ImageHandle;

	public async UniTask<bool> Show(int imageId, float imageOffset, AssetStation station, UIRelativeEffect blur, CancellationToken token)
	{
		Release(station);
		Clear();
		RuntimeConfigs.data.dialogueImageDatas.TryGetValue(imageId, out var value);
		string text = value?.path;
		if (string.IsNullOrEmpty(text))
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		Sprite imageResult = null;
		try
		{
			m_ImageHandle = station.LoadAsync<Sprite>("Sprite/" + text);
			await m_ImageHandle;
			imageResult = m_ImageHandle.As<Sprite>();
		}
		catch (Exception exception)
		{
			_ = LuminApplication.LogEnabled;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		if (token.IsCancellationRequested || imageResult == null)
		{
			return false;
		}
		gameObject.SetActive(value: true);
		blur?.RemoveUIEffect(this);
		blur?.AddUIEffect(this);
		image.sprite = imageResult;
		RectTransform rectTransform = transform as RectTransform;
		rectTransform.anchoredPosition = new Vector2(imageOffset, rectTransform.anchoredPosition.y);
		canvasGroup.alpha = 0f;
		canvasGroup.gameObject.SetActive(value: true);
		canvasGroup.DOKill();
		UniTask uniTask = canvasGroup.DOFade(1f, 0.5f).ToUniTask(TweenCancelBehaviour.Kill, token);
		UniTask uniTask2 = FadeBlur(blur, 1f, token);
		await UniTask.WhenAll(uniTask, uniTask2).SuppressCancellationThrow();
		return !token.IsCancellationRequested;
	}

	public async UniTask Hide(AssetStation station, UIRelativeEffect blur, bool fadeBlur)
	{
		if (!IsActive())
		{
			Release(station);
			Clear();
			return;
		}
		CancellationToken cancellationTokenOnDestroy = gameObject.GetCancellationTokenOnDestroy();
		canvasGroup.DOKill();
		canvasGroup.alpha = 1f;
		UniTask uniTask = canvasGroup.DOFade(0f, 0.5f).ToUniTask(TweenCancelBehaviour.Kill, cancellationTokenOnDestroy);
		UniTask uniTask2 = (fadeBlur ? FadeBlur(blur, 0f, cancellationTokenOnDestroy) : UniTask.CompletedTask);
		await UniTask.WhenAll(uniTask, uniTask2).SuppressCancellationThrow();
		Release(station);
		Clear();
	}

	public void Release(AssetStation station)
	{
		if (m_ImageHandle.IsValid)
		{
			station.Release(m_ImageHandle);
		}
		m_ImageHandle = default;
	}

	public void Clear()
	{
		if ((bool)canvasGroup)
		{
			canvasGroup.DOKill();
			canvasGroup.alpha = 0f;
		}
		if ((bool)image)
		{
			image.sprite = null;
		}
		gameObject?.SetActive(value: false);
		blur?.RemoveUIEffect(this);
	}

	public static async UniTask FadeBlur(UIRelativeEffect blur, float target, CancellationToken token)
	{
		if (!blur)
		{
			return;
		}
		if (target > 0f)
		{
			blur.transform.parent.parent.gameObject.SetActive(value: true);
		}
		else if (!blur.gameObject.activeSelf)
		{
			foreach (UIEffectRendering uiEffect in blur.uiEffects)
			{
				uiEffect.Intensity = 0f;
			}
			return;
		}
		float intensity = ((blur.uiEffects.Count <= 0) ? 0f : blur.uiEffects[0].Intensity);
		await DOTween.To(() => intensity, (float value) =>
		{
			if ((bool)blur)
			{
				foreach (UIEffectRendering uiEffect2 in blur.uiEffects)
				{
					uiEffect2.Intensity = value;
				}
			}
		}, target, 0.5f).ToUniTask(TweenCancelBehaviour.Kill, token).SuppressCancellationThrow();
		if (!token.IsCancellationRequested && target <= 0f && (bool)blur)
		{
			blur.transform.parent.parent.gameObject.SetActive(value: true);
		}
	}
}
