using System;
using Ase;
using DG.Tweening;
using TMPro;
using UnityEngine;

public class BattleTipFloatingWindow : MonoBehaviour
{
	[SerializeField]
	private AutoDispose AutoDispose;

	[SerializeField]
	private CanvasGroup canvasGroup;

	[SerializeField]
	private TextMeshProUGUI TipsText;

	private Tweener showTween;

	private Tweener closeTween;

	public void Init()
	{
		AutoDispose.enabled = false;
		AutoDispose.AddDisposeAction((Action)delegate
		{
			CloseUI();
		});
	}

	public void Show(float time, string content)
	{
		if (showTween != null)
		{
			showTween.Kill();
			showTween = null;
		}
		if (closeTween != null)
		{
			closeTween.Kill();
			closeTween = null;
		}
		canvasGroup.alpha = 0f;
		showTween = DOTweenModuleUI.DOFade(canvasGroup, 1f, 0.2f).OnComplete(delegate
		{
			showTween = null;
		});
		AutoDispose.enabled = true;
		AutoDispose.ResetTime(time);
		((TMP_Text)TipsText).text = content;
	}

	private void CloseUI()
	{
		AutoDispose.enabled = false;
		canvasGroup.alpha = 1f;
		closeTween = DOTweenModuleUI.DOFade(canvasGroup, 0f, 0.4f).OnComplete(delegate
		{
			closeTween = null;
			if (showTween != null)
			{
				showTween.Kill();
			}
		});
	}
}
