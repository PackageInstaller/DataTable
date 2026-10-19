using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupTargetGachaViewTab : MonoBehaviour
{
	[SerializeField]
	public List<PopupTargetGachaViewTabItem> tabItems;

	[SerializeField]
	private RectTransform highlightBg;

	private Sequence tweener;

	private bool initSelection = true;

	public int CurrentIndex { get; private set; } = -1;

	public bool TrySwitchTo(int index)
	{
		if (index < 0 || index >= tabItems.Count || CurrentIndex == index)
		{
			return false;
		}
		CurrentIndex = index;
		foreach (PopupTargetGachaViewTabItem tabItem in tabItems)
		{
			tabItem.Set(status: false);
		}
		PopupTargetGachaViewTabItem popupTargetGachaViewTabItem = tabItems[index];
		popupTargetGachaViewTabItem.Set(status: true);
		if (!initSelection)
		{
			float highlightAnchoredPosX = GetHighlightAnchoredPosX(popupTargetGachaViewTabItem.RectTransform);
			float num = highlightAnchoredPosX - highlightBg.anchoredPosition.x;
			float endValue = highlightBg.anchoredPosition.x + num * 0.1f;
			float endValue2 = highlightBg.anchoredPosition.x + num * 0.85f;
			tweener?.Kill(complete: true);
			tweener = DOTween.Sequence();
			tweener.Append(highlightBg.DOAnchorPosX(endValue, 0.1f));
			tweener.Append(highlightBg.DOAnchorPosX(endValue2, 0.1f).SetEase(Ease.InSine));
			tweener.Append(highlightBg.DOAnchorPosX(highlightAnchoredPosX, 0.15f));
			tweener.Play();
		}
		else
		{
			ForceRebuildTabLayout();
			SetHighlightPosition(popupTargetGachaViewTabItem.RectTransform);
		}
		initSelection = false;
		return true;
	}

	public void SwitchToImmediately(int index)
	{
		if (index < 0 || index >= tabItems.Count)
		{
			return;
		}
		CurrentIndex = index;
		foreach (PopupTargetGachaViewTabItem tabItem in tabItems)
		{
			tabItem.Set(status: false);
		}
		PopupTargetGachaViewTabItem popupTargetGachaViewTabItem = tabItems[index];
		popupTargetGachaViewTabItem.Set(status: true);
		tweener?.Kill(complete: true);
		ForceRebuildTabLayout();
		SetHighlightPosition(popupTargetGachaViewTabItem.RectTransform);
		initSelection = false;
	}

	private void ForceRebuildTabLayout()
	{
		if (tabItems.Count != 0)
		{
			Canvas.ForceUpdateCanvases();
			RectTransform rectTransform = tabItems[0].RectTransform.parent as RectTransform;
			if (rectTransform != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
			}
		}
	}

	private void SetHighlightPosition(RectTransform target)
	{
		Vector2 anchoredPosition = highlightBg.anchoredPosition;
		anchoredPosition.x = GetHighlightAnchoredPosX(target);
		highlightBg.anchoredPosition = anchoredPosition;
	}

	private float GetHighlightAnchoredPosX(RectTransform target)
	{
		RectTransform rectTransform = highlightBg.parent as RectTransform;
		if (rectTransform == null)
		{
			return highlightBg.anchoredPosition.x;
		}
		Vector3 vector = rectTransform.InverseTransformPoint(target.position);
		float num = ((highlightBg.anchorMin.x + highlightBg.anchorMax.x) * 0.5f - rectTransform.pivot.x) * rectTransform.rect.width;
		return vector.x - num;
	}

	private void OnDisable()
	{
		tweener?.Kill();
		tweener = null;
	}
}
