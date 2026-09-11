using UnityEngine;

public class UIListKeyMap : ScrollBaseKeyMap
{
	private RectTransform m_rectTf;

	private RectTransform m_parentRectTf;

	private UIList m_uiList;

	private void Start()
	{
		ResetSelectItem();
	}

	public override void SelectNextItem()
	{
		int childCount = m_uiList.GetChildCount();
		if (base.selectIndex < childCount - 1)
		{
			base.selectIndex++;
			RefreshItemList();
		}
	}

	public override void SelectPrevItem()
	{
		if (base.selectIndex > 0)
		{
			base.selectIndex--;
			RefreshItemList();
		}
	}

	public override void RefreshItemList()
	{
		AdjustPosition();
		m_uiList.OnScroll(Vector2.zero);
		Vector2 headAndTail = m_uiList.GetHeadAndTail();
		for (int i = (int)headAndTail.x; i <= (int)headAndTail.y; i++)
		{
			if (m_uiList._itemDic.ContainsKey(i))
			{
				m_uiList._itemDic[i].GetComponent<ScrollItemKeyMap>().ChangeSelectedState(i == base.selectIndex, i, m_useAlphaNumKey);
			}
		}
	}

	public override void AwakeInit()
	{
		m_rectTf = GetComponent<RectTransform>();
		m_parentRectTf = base.transform.parent.GetComponent<RectTransform>();
		m_uiList = base.transform.parent.parent.GetComponent<UIList>();
	}

	public override void AdjustPosition()
	{
		if (m_uiList._itemDic.ContainsKey(base.selectIndex))
		{
			RectTransform component = m_uiList._itemDic[base.selectIndex].GetComponent<RectTransform>();
			if (IsVisibleInScrollRect(m_parentRectTf, component))
			{
				return;
			}
			Vector2 anchoredPosition = m_rectTf.anchoredPosition;
			Vector2 anchoredPosition2 = component.anchoredPosition;
			float x = 0f;
			float y = 0f;
			if (m_uiList.IsHorizontal())
			{
				float x2 = component.sizeDelta.x;
				float width = m_parentRectTf.rect.width;
				float x3 = anchoredPosition.x;
				float num = anchoredPosition.x + width;
				if (anchoredPosition2.x - x2 < 0f - x3)
				{
					x = 0f - anchoredPosition2.x;
				}
				else if (anchoredPosition2.x + x2 > 0f - num)
				{
					x = 0f - (anchoredPosition2.x + x2 - width);
				}
			}
			else
			{
				float y2 = component.sizeDelta.y;
				float height = m_parentRectTf.rect.height;
				float y3 = anchoredPosition.y;
				float num2 = anchoredPosition.y + height;
				if (anchoredPosition2.y - y2 < 0f - num2)
				{
					y = 0f - (anchoredPosition2.y - y2 + height);
				}
				else if (anchoredPosition2.y + y2 > 0f - y3)
				{
					y = 0f - anchoredPosition2.y;
				}
			}
			m_rectTf.anchoredPosition = new Vector2(x, y);
		}
		else
		{
			Vector2 headAndTail = m_uiList.GetHeadAndTail();
			Vector2 sizeDelta = m_uiList.ItemPrefab.GetComponent<RectTransform>().sizeDelta;
			Vector2 spacing = m_uiList._spacing;
			float x4 = 0f;
			float y4 = 0f;
			if (m_uiList.IsHorizontal())
			{
				x4 = sizeDelta.x + spacing.x;
			}
			else
			{
				y4 = sizeDelta.y + spacing.y;
			}
			if (base.selectIndex < (int)headAndTail.x)
			{
				m_rectTf.anchoredPosition -= new Vector2(x4, y4) * ((int)headAndTail.x - base.selectIndex);
			}
			else if (base.selectIndex > (int)headAndTail.y)
			{
				m_rectTf.anchoredPosition += new Vector2(x4, y4) * (base.selectIndex - (int)headAndTail.y);
			}
		}
	}

	private bool IsVisibleInScrollRect(RectTransform outerUI, RectTransform innerUI)
	{
		if (outerUI == null || innerUI == null)
		{
			return false;
		}
		Vector3[] array = new Vector3[4];
		outerUI.GetWorldCorners(array);
		float num = Mathf.Min(array[0].x, array[1].x, array[2].x, array[3].x);
		float num2 = Mathf.Min(array[0].y, array[1].y, array[2].y, array[3].y);
		float num3 = Mathf.Max(array[0].x, array[1].x, array[2].x, array[3].x);
		float num4 = Mathf.Max(array[0].y, array[1].y, array[2].y, array[3].y);
		Vector3[] array2 = new Vector3[4];
		innerUI.GetWorldCorners(array2);
		float num5 = Mathf.Min(array2[0].x, array2[1].x, array2[2].x, array2[3].x);
		float num6 = Mathf.Min(array2[0].y, array2[1].y, array2[2].y, array2[3].y);
		float num7 = Mathf.Max(array2[0].x, array2[1].x, array2[2].x, array2[3].x);
		float num8 = Mathf.Max(array2[0].y, array2[1].y, array2[2].y, array2[3].y);
		if (m_uiList.IsHorizontal())
		{
			if (num5 >= num)
			{
				return num7 <= num3;
			}
			return false;
		}
		if (num6 >= num2)
		{
			return num8 <= num4;
		}
		return false;
	}
}
