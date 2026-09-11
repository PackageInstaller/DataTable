using System;
using UnityEngine;
using UnityEngine.UI;

public class SizeRelater : MonoBehaviour
{
	[SerializeField]
	public ContentSizeFilterEx contentSizeFilter;

	[SerializeField]
	public Vector2 percent = Vector2.one;

	[SerializeField]
	public Vector2 sizeDelta;

	[SerializeField]
	public Vector2 originWatchSize;

	private Vector2 _currentWatchSize;

	private void Awake()
	{
		if (contentSizeFilter != null)
		{
			ContentSizeFilterEx contentSizeFilterEx = contentSizeFilter;
			contentSizeFilterEx.onSizeChange = (Action)Delegate.Combine(contentSizeFilterEx.onSizeChange, new Action(OnWatchItemSizeChange));
		}
	}

	private void Start()
	{
		if (contentSizeFilter != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(contentSizeFilter.transform as RectTransform);
		}
	}

	private void OnWatchItemSizeChange()
	{
		if (!(contentSizeFilter == null) && !(((contentSizeFilter.transform as RectTransform).rect.size - _currentWatchSize).magnitude < 0.001f))
		{
			_currentWatchSize = (contentSizeFilter.transform as RectTransform).rect.size;
			Vector2 vector = _currentWatchSize + sizeDelta * percent;
			(base.transform as RectTransform).SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, vector.x);
			(base.transform as RectTransform).SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, vector.y);
			if (base.transform.parent != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(base.transform.parent as RectTransform);
			}
		}
	}

	private void OnDestroy()
	{
		if (contentSizeFilter != null)
		{
			ContentSizeFilterEx contentSizeFilterEx = contentSizeFilter;
			contentSizeFilterEx.onSizeChange = (Action)Delegate.Remove(contentSizeFilterEx.onSizeChange, new Action(OnWatchItemSizeChange));
		}
	}
}
