using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffDescScroll : MonoBehaviour
{
	public float maxHeight;

	public float padding;

	public float paddingLeft;

	public float paddingTop;

	public float paddingBottom;

	public GameObject templ;

	public ScrollRect scrollView;

	private List<BuffDescItemView> itemList = new List<BuffDescItemView>();

	private RectTransform rect;

	private bool hasCal;

	private bool showBuff;

	private Action onShowAction;

	private void Start()
	{
		rect = GetComponent<RectTransform>();
	}

	public void UpdateList(List<BuffItemViewModel> buffVMs)
	{
		for (int i = 0; i < buffVMs.Count; i++)
		{
			if (i >= itemList.Count)
			{
				GameObject obj = UnityEngine.Object.Instantiate(templ, scrollView.content);
				BuffDescItemView component = obj.GetComponent<BuffDescItemView>();
				obj.SetActive(value: true);
				component.Init(buffVMs[i]);
				itemList.Add(component);
			}
			else
			{
				itemList[i].RefreshData(buffVMs[i]);
				itemList[i].gameObject.SetActive(value: true);
			}
		}
		for (int j = buffVMs.Count; j < itemList.Count; j++)
		{
			itemList[j].gameObject.SetActive(value: false);
		}
		showBuff = true;
		hasCal = false;
	}

	private void Update()
	{
		if (hasCal || !showBuff)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		float num3 = 0f;
		for (int i = 0; i < itemList.Count; i++)
		{
			if (!itemList[i].gameObject.activeSelf)
			{
				num++;
				continue;
			}
			num2++;
			num3 += itemList[i].RectTransform.sizeDelta.y;
		}
		if (num == itemList.Count)
		{
			return;
		}
		num3 = num3 + paddingTop + paddingBottom + padding * (float)num2 - 1f;
		scrollView.content.sizeDelta = new Vector2(scrollView.content.sizeDelta.x, num3);
		float num4 = 0f - paddingTop;
		for (int j = 0; j < itemList.Count; j++)
		{
			if (itemList[j].gameObject.activeSelf)
			{
				itemList[j].RectTransform.anchoredPosition = new Vector2(paddingLeft, num4);
				num4 -= itemList[j].RectTransform.sizeDelta.y;
				num4 -= padding;
			}
		}
		rect.sizeDelta = new Vector2(rect.sizeDelta.x, (num3 > maxHeight) ? maxHeight : num3);
		LayoutRebuilder.ForceRebuildLayoutImmediate(scrollView.content);
		LayoutRebuilder.ForceRebuildLayoutImmediate(rect);
		onShowAction();
		showBuff = false;
		hasCal = true;
	}

	public void AddOnShow(Action onShow)
	{
		onShowAction = onShow;
	}

	public void UpdatePos(RectTransform pos)
	{
		if (!(pos == null))
		{
			Transform parent = base.transform.parent;
			rect.SetParent(pos.parent);
			rect.pivot = pos.pivot;
			rect.anchorMin = pos.anchorMin;
			rect.anchorMax = pos.anchorMax;
			rect.anchoredPosition = pos.anchoredPosition;
			rect.SetParent(parent);
		}
	}
}
