using System;
using System.Collections;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public static class UIExtension
{
	public static UniTask<IWindow> OpenResWindow(this UIComponent uiComponent, string uiFormAssetName, object userData = null)
	{
		return uiComponent.OpenResWindow(uiFormAssetName, "DEFAULT", userData);
	}

	public static UniTask<IWindow> OpenResWindow(this UIComponent uiComponent, string uiFormAssetName, string uiGroupName, object userData = null)
	{
		return uiComponent.OpenResUIWindow<IWindow>(AssetUtility.GetResourceUIFormAsset(uiFormAssetName), uiGroupName, userData);
	}

	public static UniTask<T> OpenResWindow<T>(this UIComponent uiComponent, string uiFormAssetName, string uiGroupName, object userData = null) where T : IWindow
	{
		return uiComponent.OpenResUIWindow<T>(AssetUtility.GetResourceUIFormAsset(uiFormAssetName), uiGroupName, userData);
	}

	public static UniTask<IWindow> OpenWindow(this UIComponent uiComponent, string uiFormAssetName, object userData = null)
	{
		return uiComponent.OpenWindow<IWindow>(uiFormAssetName, "DEFAULT", userData, null);
	}

	public static UniTask<T> OpenWindow<T>(this UIComponent uiComponent, string uiFormAssetName, object userData = null) where T : IWindow
	{
		return uiComponent.OpenWindow<T>(uiFormAssetName, "DEFAULT", userData, null);
	}

	public static UniTask<T> OpenWindow<T>(this UIComponent uiComponent, string uiFormAssetName, object userData, Action callback) where T : IWindow
	{
		return uiComponent.OpenWindow<T>(uiFormAssetName, "DEFAULT", userData, callback);
	}

	public static UniTask<T> OpenWindow<T>(this UIComponent uiComponent, string uiFormAssetName, string uiGroupName, object userData = null) where T : IWindow
	{
		return uiComponent.OpenWindow<T>(uiFormAssetName, uiGroupName, userData, null);
	}

	public static UniTask<T> OpenWindow<T>(this UIComponent uiComponent, string uiFormAssetName, string uiGroupName, object userData, Action callback) where T : IWindow
	{
		return uiComponent.OpenUIWindow<T>(AssetUtility.GetUIFormAsset(uiFormAssetName), uiGroupName, userData, callback);
	}

	public static UniTask<T> LoadWindow<T>(this UIComponent uiComponent, string uiFormAssetName, object userData = null) where T : IWindow
	{
		return uiComponent.LoadWindow<T>(AssetUtility.GetUIFormAsset(uiFormAssetName), "DEFAULT", userData);
	}

	public static UniTask<T> OpenUIView<T>(this UIComponent uiComponent, string uiFormAssetName) where T : IUIView
	{
		return uiComponent.OpenUGUIView<T>(AssetUtility.GetUIFormAsset(uiFormAssetName));
	}

	public static IEnumerator FadeToAlpha(this CanvasGroup canvasGroup, float alpha, float duration)
	{
		float time = 0f;
		float originalAlpha = canvasGroup.alpha;
		while (time < duration)
		{
			time += Time.deltaTime;
			canvasGroup.alpha = Mathf.Lerp(originalAlpha, alpha, time / duration);
			yield return new WaitForEndOfFrame();
		}
		canvasGroup.alpha = alpha;
	}

	public static IEnumerator SmoothValue(this Slider slider, float value, float duration)
	{
		float time = 0f;
		float originalValue = slider.value;
		while (time < duration)
		{
			time += Time.deltaTime;
			slider.value = Mathf.Lerp(originalValue, value, time / duration);
			yield return new WaitForEndOfFrame();
		}
		slider.value = value;
	}

	public static bool GetVisibility(this UIBehaviour ui)
	{
		if (!ui.IsDestroyed() && !(ui.gameObject == null))
		{
			return ui.gameObject.activeSelf;
		}
		return false;
	}

	public static void SetVisibility(this UIBehaviour ui, bool visibility)
	{
		if (!ui.IsDestroyed() && !(ui.gameObject == null) && ui.gameObject.activeSelf != visibility)
		{
			ui.gameObject.SetActive(visibility);
		}
	}

	public static void SetVisibility(this UIBehaviour ui, bool visibility, float time)
	{
		if (ui.IsDestroyed() || ui.gameObject == null)
		{
			return;
		}
		CanvasGroup component = ui.GetComponent<CanvasGroup>();
		if ((UnityEngine.Object)(object)component == null)
		{
			return;
		}
		if (visibility)
		{
			ui.gameObject.SetActive(value: true);
			DOTweenModuleUI.DOFade(component, 1f, time);
		}
		else
		{
			DOTweenModuleUI.DOFade(component, 0f, time).onComplete = delegate
			{
				ui.gameObject.SetActive(value: false);
			};
		}
	}
}
