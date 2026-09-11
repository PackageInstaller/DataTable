using System;

namespace UnityEngine.UI;

public abstract class LoopScrollRect : LoopScrollRectBase
{
	[NonSerialized]
	[HideInInspector]
	public LoopScrollDataSource dataSource;

	protected override void ProvideData(Transform transform, int index)
	{
		dataSource.ProvideData(transform, index);
	}

	protected override RectTransform GetFromTempPool(int itemIdx)
	{
		RectTransform rectTransform = null;
		if (deletedItemTypeStart > 0)
		{
			deletedItemTypeStart--;
			rectTransform = m_Content.GetChild(0) as RectTransform;
			rectTransform.SetSiblingIndex(itemIdx - itemTypeStart + deletedItemTypeStart);
		}
		else if (deletedItemTypeEnd > 0)
		{
			deletedItemTypeEnd--;
			rectTransform = m_Content.GetChild(m_Content.childCount - 1) as RectTransform;
			rectTransform.SetSiblingIndex(itemIdx - itemTypeStart + deletedItemTypeStart);
		}
		else
		{
			rectTransform = prefabSource.GetObject(itemIdx).transform as RectTransform;
			rectTransform.transform.SetParent(m_Content, worldPositionStays: false);
			rectTransform.gameObject.SetActive(value: true);
		}
		ProvideData(rectTransform, itemIdx);
		return rectTransform;
	}

	protected override void ReturnToTempPool(bool fromStart, int count)
	{
		if (fromStart)
		{
			deletedItemTypeStart += count;
		}
		else
		{
			deletedItemTypeEnd += count;
		}
	}

	protected override void ClearTempPool()
	{
		if (deletedItemTypeStart > 0)
		{
			for (int num = deletedItemTypeStart - 1; num >= 0; num--)
			{
				prefabSource.ReturnObject(m_Content.GetChild(num));
			}
			deletedItemTypeStart = 0;
		}
		if (deletedItemTypeEnd > 0)
		{
			int num2 = m_Content.childCount - deletedItemTypeEnd;
			for (int num3 = m_Content.childCount - 1; num3 >= num2; num3--)
			{
				prefabSource.ReturnObject(m_Content.GetChild(num3));
			}
			deletedItemTypeEnd = 0;
		}
	}
}
