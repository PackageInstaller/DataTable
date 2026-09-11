using UnityEngine;

public class ScrollRectKeyMap : ScrollBaseKeyMap
{
	private RectTransform m_rectTf;

	private RectTransform m_parentRectTf;

	public override void AwakeInit()
	{
		m_rectTf = GetComponent<RectTransform>();
		m_parentRectTf = base.transform.parent.GetComponent<RectTransform>();
	}

	public override void AdjustPosition()
	{
		if (base.selectIndex < 0 || base.selectIndex >= base.scrollItemList.Count)
		{
			return;
		}
		ScrollItemKeyMap scrollItemKeyMap = base.scrollItemList[base.selectIndex];
		if (scrollItemKeyMap == null)
		{
			return;
		}
		RectTransform component = scrollItemKeyMap.GetComponent<RectTransform>();
		if (!IsVisibleInScrollRect(component))
		{
			Vector2 anchoredPosition = m_rectTf.anchoredPosition;
			Vector2 anchoredPosition2 = component.anchoredPosition;
			float num = component.sizeDelta.x / 2f;
			float width = m_parentRectTf.rect.width;
			float x = anchoredPosition.x;
			float num2 = anchoredPosition.x + width;
			float x2 = 0f;
			if (anchoredPosition2.x - num < Mathf.Abs(x))
			{
				x2 = 0f - anchoredPosition2.x + num;
			}
			else if (anchoredPosition2.x + num > num2)
			{
				x2 = 0f - anchoredPosition2.x - num + width;
			}
			float num3 = component.sizeDelta.y / 2f + 1f;
			float height = m_parentRectTf.rect.height;
			float num4 = 0f - anchoredPosition.y;
			float num5 = 0f - anchoredPosition.y - height;
			float y = 0f;
			if (anchoredPosition2.y - num3 < num5)
			{
				y = anchoredPosition.y + num5 - (anchoredPosition2.y - num3);
			}
			else if (anchoredPosition2.y + num3 > num4)
			{
				y = 0f - anchoredPosition2.y - num3;
			}
			m_rectTf.anchoredPosition = new Vector2(x2, y);
		}
	}

	private bool IsVisibleInScrollRect(RectTransform itemRect)
	{
		Rect rect = m_parentRectTf.rect;
		Vector2 point = m_parentRectTf.InverseTransformPoint(itemRect.position);
		return rect.Contains(point);
	}
}
