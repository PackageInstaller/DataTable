using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType1Window : UGuiWindowBase
{
	public float posFix;

	public float firstItemPadding;

	public float itemWidth;

	public float itemPadding;

	public Button btnBack;

	public Button btnCloseDetail;

	public LoopListView2 itemList;

	public List<CopyItemView> copyItemList;

	public CopyItemDetail1View detailView;

	public CopyMaterialSortView sortView;

	private CopySecondType1ViewModel viewModel;

	private float centerPos;

	private RectTransform itemListRt;

	private float oriContentW;

	private float moveDelta;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySecondType1ViewModel>();
		BindingSet<CopySecondType1Window, CopySecondType1ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType1Window v) => v.OnDismissRequest).To((CopySecondType1ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySecondType1Window v) => v.OpenUguiWindow).To((CopySecondType1ViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopySecondType1Window v) => v.OnOpt).To((CopySecondType1ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnCloseDetail).For((Button v) => v.onClick).To((CopySecondType1ViewModel vm) => vm.OptCommand)
			.CommandParameter("CloseDetail");
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopySecondType1ViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Build();
		itemList.InitListView(viewModel.CopyItemVms.Count + 2, OnGetItemByIndex);
		for (int num = 0; num < copyItemList.Count; num++)
		{
			if (num < viewModel.CopyItemVms.Count)
			{
				copyItemList[num].Init(viewModel.CopyItemVms[num]);
				copyItemList[num].gameObject.SetActive(value: true);
			}
			else
			{
				copyItemList[num].gameObject.SetActive(value: false);
			}
		}
		_ = viewModel.CopyItemVms.Count;
		_ = copyItemList.Count;
		itemListRt = itemList.GetComponent<RectTransform>();
		centerPos = (GameEntry.UI.RootTransform.rect.width - detailView.RectTransform.rect.width) / 2f + posFix;
		oriContentW = (float)(viewModel.CopyItemVms.Count + 2) * (itemWidth + itemPadding);
		btnCloseDetail.gameObject.SetActive(value: false);
		if (viewModel.CurSelectItem == null)
		{
			itemList.ScrollRect.enabled = true;
			CalculatePos(move: false);
			detailView.gameObject.SetActive(value: false);
		}
		else
		{
			itemList.ScrollRect.enabled = false;
			CalculatePos(move: true);
			detailView.gameObject.SetActive(value: true);
			btnCloseDetail.gameObject.SetActive(value: true);
			detailView.Init(viewModel.CopyDetailVm);
		}
		sortView.Init(viewModel.SortVm);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenDetail".Equals(optName))
		{
			itemList.ScrollRect.enabled = false;
			detailView.gameObject.SetActive(value: true);
			btnCloseDetail.gameObject.SetActive(value: true);
			detailView.Init(viewModel.CopyDetailVm);
			CalculatePos(move: true);
		}
		else if ("CloseDetail".Equals(optName))
		{
			itemList.ScrollRect.enabled = true;
			detailView.gameObject.SetActive(value: false);
			btnCloseDetail.gameObject.SetActive(value: false);
			CalculatePos(move: false);
		}
		else
		{
			if (!"RefreshCopyType".Equals(optName))
			{
				return;
			}
			itemList.SetListItemCount(viewModel.CopyItemVms.Count + 2);
			itemList.RefreshAllShownItem();
			for (int i = 0; i < copyItemList.Count; i++)
			{
				if (i < viewModel.CopyItemVms.Count)
				{
					copyItemList[i].RefreshData(viewModel.CopyItemVms[i]);
					copyItemList[i].gameObject.SetActive(value: true);
				}
				else
				{
					copyItemList[i].gameObject.SetActive(value: false);
				}
			}
		}
	}

	private void CalculatePos(bool move)
	{
		if (!move)
		{
			itemListRt.anchoredPosition = new Vector2(0f, itemListRt.anchoredPosition.y);
			return;
		}
		int curSelectIndex = viewModel.GetCurSelectIndex();
		float num = 0f - itemList.ScrollRect.content.anchoredPosition.x;
		float num2 = firstItemPadding + (float)curSelectIndex * itemWidth + (float)Math.Clamp(curSelectIndex - 1, 0, 10) * itemPadding - num;
		if (num2 > centerPos || itemList.ScrollRect.content.anchoredPosition.x < 0f)
		{
			float num3 = num2 - centerPos;
			itemList.ScrollRect.content.sizeDelta = new Vector2(oriContentW, itemList.ScrollRect.content.sizeDelta.y);
			itemList.ScrollRect.content.anchoredPosition = new Vector2(math.clamp(itemList.ScrollRect.content.anchoredPosition.x - num3, 0f - oriContentW, 0f), itemListRt.anchoredPosition.y);
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CopyItemVms.Count + 2)
		{
			return null;
		}
		return listView2.NewListViewItem("Item");
	}
}
