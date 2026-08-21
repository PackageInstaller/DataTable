using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class Type4ProgressView : UGuiView
{
	public RectTransform copyItemRoot;

	public CopyItem4View2 item1;

	public CopyItem4View2 item2;

	public GameObject nextChallenge;

	public GameObject nextCopyRank;

	public RectTransform starRoot;

	public LoopListView2 starList;

	public int fixedSpacingMinCount;

	public float fixedSpacing;

	public float starWidth;

	public GameObject complete;

	public RectTransform curTab;

	private Type4ProgressViewModel viewModel;

	private Type4StarItem curItemRect;

	private float width;

	private Action<bool> canDrag;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<Type4ProgressViewModel>(userData);
		BindingSet<Type4ProgressView, Type4ProgressViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((Type4ProgressView v) => v.OnVisibleChanged).To((Type4ProgressViewModel vm) => vm.VisibleRequest);
		bindingSet.Build();
		complete.gameObject.SetActive(viewModel.IsAllComplete);
		width = starRoot.sizeDelta.x;
		float num = 0f;
		int count = viewModel.CurStarState.Count;
		ScrollRect.MovementType movementType = ScrollRect.MovementType.Clamped;
		if (count == 0)
		{
			return;
		}
		if (count <= fixedSpacingMinCount)
		{
			num = ((count != 2) ? ((width - starWidth) / (float)(count - 1) - starWidth) : width);
			movementType = ScrollRect.MovementType.Clamped;
			curTab.anchoredPosition = new Vector2(starList.PaddingLeft + num * (float)viewModel.CurIndex, curTab.anchoredPosition.y);
		}
		else
		{
			num = fixedSpacing;
			movementType = ScrollRect.MovementType.Elastic;
		}
		LoopListView2 loopListView = starList;
		loopListView.mOnBeginDragAction = (Action)Delegate.Combine(loopListView.mOnBeginDragAction, (Action)delegate
		{
			StopDrag();
		});
		LoopListView2 loopListView2 = starList;
		loopListView2.mOnEndDragAction = (Action)Delegate.Combine(loopListView2.mOnEndDragAction, (Action)delegate
		{
			StartDrag();
		});
		List<ItemPrefabConfData> itemPrefabDataList = starList.ItemPrefabDataList;
		if (itemPrefabDataList != null && itemPrefabDataList.Count > 0)
		{
			itemPrefabDataList[0].mPadding = num;
		}
		starList.InitListView(count, OnGetStarItemByIndex);
		starList.ScrollRect.movementType = movementType;
		curTab.SetParent(starList.ScrollRect.content);
		float num2 = num + starWidth;
		float offset = 0f;
		int num3 = Mathf.FloorToInt((width / 2f - starWidth) / num2) + 1;
		if (viewModel.CurIndex < count - num3)
		{
			offset = Math.Min(width / 2f, (float)viewModel.CurIndex * num2 + starWidth);
		}
		if (count >= fixedSpacingMinCount)
		{
			starList.MovePanelToItemIndex(viewModel.CurIndex, offset);
		}
		if (viewModel.IsWin && !viewModel.IsAllComplete)
		{
			copyItemRoot.gameObject.SetActive(value: true);
			nextChallenge.SetActive(viewModel.NextChallenge);
			nextCopyRank.SetActive(!viewModel.NextChallenge);
			if (viewModel.CopyItem1 != null)
			{
				item1.Init(viewModel.CopyItem1);
				item1.gameObject.SetActive(value: true);
			}
			else
			{
				item1.gameObject.SetActive(value: false);
			}
			if (viewModel.CopyItem2 != null)
			{
				item2.Init(viewModel.CopyItem2);
				item2.gameObject.SetActive(value: true);
			}
			else
			{
				item2.gameObject.SetActive(value: false);
			}
		}
		else
		{
			copyItemRoot.gameObject.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (curItemRect != null && curItemRect.Index == viewModel.CurIndex)
		{
			curTab.gameObject.SetActive(curItemRect.gameObject.activeSelf);
			curTab.anchoredPosition = new Vector2(curItemRect.GetComponent<RectTransform>().anchoredPosition.x, curTab.anchoredPosition.y);
		}
		else
		{
			curTab.gameObject.SetActive(value: false);
		}
	}

	private void StartDrag()
	{
		canDrag(obj: true);
	}

	private void StopDrag()
	{
		canDrag(obj: false);
	}

	public void AddDragAction(Action<bool> action)
	{
		canDrag = action;
	}

	private LoopListViewItem2 OnGetStarItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CurStarState.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StarTempl");
		if (loopListViewItem != null)
		{
			Type4StarItem component = loopListViewItem.GetComponent<Type4StarItem>();
			component.State = viewModel.CurStarState[index];
			component.Index = index;
			if (index == viewModel.CurIndex)
			{
				curItemRect = component;
			}
		}
		return loopListViewItem;
	}

	public void SetCopyItemRoot(RectTransform barRoot)
	{
		copyItemRoot.transform.parent = barRoot;
		copyItemRoot.anchoredPosition = Vector2.zero;
	}

	protected override void OnDestroy()
	{
		canDrag = null;
		base.OnDestroy();
	}
}
