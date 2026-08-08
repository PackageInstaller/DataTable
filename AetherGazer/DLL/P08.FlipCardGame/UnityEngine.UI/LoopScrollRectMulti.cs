using System;

namespace UnityEngine.UI;

public abstract class LoopScrollRectMulti : LoopScrollRectBase
{
	[NonSerialized]
	[HideInInspector]
	public LoopScrollMultiDataSource dataSource;

	protected override void ProvideData(Transform transform, int index)
	{
		dataSource.ProvideData(transform, index);
	}

	protected override RectTransform GetFromTempPool(int itemIdx)
	{
		RectTransform rectTransform = prefabSource.GetObject(itemIdx).transform as RectTransform;
		rectTransform.transform.SetParent(m_Content, worldPositionStays: false);
		rectTransform.gameObject.SetActive(value: true);
		ProvideData(rectTransform, itemIdx);
		return rectTransform;
	}

	protected override void ReturnToTempPool(bool fromStart, int count)
	{
		if (fromStart)
		{
			for (int num = count - 1; num >= 0; num--)
			{
				prefabSource.ReturnObject(m_Content.GetChild(num));
			}
			return;
		}
		int num2 = m_Content.childCount - count;
		for (int num3 = m_Content.childCount - 1; num3 >= num2; num3--)
		{
			prefabSource.ReturnObject(m_Content.GetChild(num3));
		}
	}

	protected override void ClearTempPool()
	{
	}
}
