using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AccountDecorationTab : MonoBehaviour
{
	[SerializeField]
	public List<AccountDecorationTabItem> tabItems;

	[SerializeField]
	private RectTransform highlightBg;

	[SerializeField]
	private BetterAnimation betterAnimation;

	private Sequence tweener;

	private bool initSelection = true;

	public int CurrentIndex { get; private set; } = -1;

	public void RefreshRedDot()
	{
		if (tabItems == null)
		{
			return;
		}
		for (int i = 0; i < tabItems.Count; i++)
		{
			AccountDecorationTabItem accountDecorationTabItem = tabItems[i];
			if (!(accountDecorationTabItem == null) && i <= 2)
			{
				AccountDecorationType type = (AccountDecorationType)i;
				accountDecorationTabItem.InitRedDot(GetRedDotPath(type));
			}
		}
	}

	private static string GetRedDotPath(AccountDecorationType type)
	{
		return type switch
		{
			AccountDecorationType.Avatar => RedDotPathDefine.AccountDecorationAvatar, 
			AccountDecorationType.AvatarFrame => RedDotPathDefine.AccountDecorationAvatarFrame, 
			AccountDecorationType.Title => RedDotPathDefine.AccountDecorationTitle, 
			_ => RedDotPathDefine.AccountDecoration, 
		};
	}

	public bool TrySwitchTo(int index)
	{
		if (CurrentIndex == index)
		{
			return false;
		}
		CurrentIndex = index;
		foreach (AccountDecorationTabItem tabItem in tabItems)
		{
			tabItem.Set(status: false);
		}
		AccountDecorationTabItem accountDecorationTabItem = tabItems[index];
		accountDecorationTabItem.Set(status: true);
		if (!initSelection)
		{
			float highlightAnchoredPosX = GetHighlightAnchoredPosX(accountDecorationTabItem.RectTransform);
			float num = highlightAnchoredPosX - highlightBg.anchoredPosition.x;
			float endValue = highlightBg.anchoredPosition.x + num * 0.1f;
			float endValue2 = highlightBg.anchoredPosition.x + num * 0.85f;
			float endValue3 = highlightAnchoredPosX;
			tweener?.Kill(complete: true);
			tweener = DOTween.Sequence();
			tweener.Append(highlightBg.DOAnchorPosX(endValue, 0.1f));
			tweener.Append(highlightBg.DOAnchorPosX(endValue2, 0.1f).SetEase(Ease.InSine));
			tweener.Append(highlightBg.DOAnchorPosX(endValue3, 0.15f));
			tweener.Play();
		}
		else
		{
			ForceRebuildTabLayout();
			SetHighlightPosition(accountDecorationTabItem.RectTransform);
		}
		betterAnimation.GetSequence(initSelection ? "SelectedShow" : "Selected").OnComplete((AnimationBuilder _) =>
		{
		}).Play();
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
		foreach (AccountDecorationTabItem tabItem in tabItems)
		{
			tabItem.Set(status: false);
		}
		AccountDecorationTabItem accountDecorationTabItem = tabItems[index];
		accountDecorationTabItem.Set(status: true);
		tweener?.Kill(complete: true);
		ForceRebuildTabLayout();
		SetHighlightPosition(accountDecorationTabItem.RectTransform);
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
}
