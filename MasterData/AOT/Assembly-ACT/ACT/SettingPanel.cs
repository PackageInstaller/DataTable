using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT;

public abstract class SettingPanel : MonoBehaviour
{
	private readonly List<ScrollRect> _scrollRects = new List<ScrollRect>();

	private bool _scrollRectsCached;

	public abstract void PlayOpenAnim(Action onFinish = null);

	public abstract void PlayCloseAnim(Action onFinish = null);

	public void ResetScrollToTop()
	{
		if (!_scrollRectsCached)
		{
			GetComponentsInChildren(includeInactive: true, _scrollRects);
			_scrollRectsCached = true;
		}
		if (_scrollRects.Count == 0)
		{
			return;
		}
		Canvas.ForceUpdateCanvases();
		for (int i = 0; i < _scrollRects.Count; i++)
		{
			ScrollRect scrollRect = _scrollRects[i];
			if (!(scrollRect == null) && !(scrollRect.content == null))
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
				scrollRect.StopMovement();
				scrollRect.velocity = Vector2.zero;
				scrollRect.verticalNormalizedPosition = 1f;
			}
		}
	}
}
