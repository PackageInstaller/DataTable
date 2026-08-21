using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class RandomBuffDisplayWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 buffList;

	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Button openBtn;

	[SerializeField]
	private GameObject displayPart;

	[SerializeField]
	private GameObject topArrow;

	[SerializeField]
	private GameObject bottomArrow;

	private const float ArrowEpsilon = 1f;

	private RandomBuffDisplayViewModel viewModel;

	private bool hookArrow;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<RandomBuffDisplayViewModel>();
		BindingSet<RandomBuffDisplayWindow, RandomBuffDisplayViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(displayPart).For((GameObject v) => v.activeSelf).To((RandomBuffDisplayViewModel vm) => vm.ShowDisplay);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((RandomBuffDisplayViewModel vm) => vm.ClickCloseBtn);
		bindingSet.Bind(openBtn).For((Button v) => v.onClick).To((RandomBuffDisplayViewModel vm) => vm.ClickOpenBtn);
		bindingSet.Bind(this).For((RandomBuffDisplayWindow v) => v.RefreshBuffList).To((RandomBuffDisplayViewModel vm) => vm.RefreshBuffRequest);
		bindingSet.Bind().For((RandomBuffDisplayWindow v) => v.OnDismissRequest).To((RandomBuffDisplayViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		buffList.InitListView(viewModel.BuffDisplayItemViewModels.Count, OnGetBuffItemByIndex);
		HookArrowListener(buffList, ref hookArrow, UpdateBuffArrow);
	}

	public void RefreshBuffList(object sender, InteractionEventArgs args)
	{
		if (!(buffList == null))
		{
			buffList.SetListItemCount(viewModel.BuffDisplayItemViewModels.Count);
			buffList.RefreshAllShownItem();
			UpdateBuffArrow();
		}
	}

	private void UpdateArrowForList(LoopListView2 list, GameObject topArrow, GameObject bottomArrow)
	{
		if (list == null || list.ScrollRect == null || list.ScrollRect.content == null)
		{
			if (topArrow != null)
			{
				topArrow.SetActive(value: false);
			}
			if (bottomArrow != null)
			{
				bottomArrow.SetActive(value: false);
			}
			return;
		}
		RectTransform rectTransform = list.ScrollRect.viewport;
		if (rectTransform == null)
		{
			rectTransform = list.ScrollRect.GetComponent<RectTransform>();
		}
		float height = rectTransform.rect.height;
		float height2 = list.ScrollRect.content.rect.height;
		float y = list.ScrollRect.content.anchoredPosition.y;
		if (height2 <= height + 1f)
		{
			if (topArrow != null)
			{
				topArrow.SetActive(value: false);
			}
			if (bottomArrow != null)
			{
				bottomArrow.SetActive(value: false);
			}
			return;
		}
		bool active = y > 1f;
		bool active2 = height2 - height - y > 1f;
		if (topArrow != null)
		{
			topArrow.SetActive(active);
		}
		if (bottomArrow != null)
		{
			bottomArrow.SetActive(active2);
		}
	}

	public LoopListViewItem2 OnGetBuffItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.BuffDisplayItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("RandomBuffItemDisplay");
		if (loopListViewItem == null)
		{
			return null;
		}
		RandomBuffItemDisplayView component = loopListViewItem.GetComponent<RandomBuffItemDisplayView>();
		if (component != null)
		{
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BuffDisplayItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.BuffDisplayItemViewModels[index]);
			}
			component.ApplyHeight();
			listView.OnItemSizeChanged(index);
		}
		return loopListViewItem;
	}

	private void HookArrowListener(LoopListView2 list, ref bool hooked, UnityAction callback)
	{
		if (!((list == null || list.ScrollRect == null) | hooked))
		{
			list.ScrollRect.onValueChanged.AddListener(delegate
			{
				callback?.Invoke();
			});
			hooked = true;
		}
	}

	private void UpdateBuffArrow()
	{
		UpdateArrowForList(buffList, topArrow, bottomArrow);
	}
}
