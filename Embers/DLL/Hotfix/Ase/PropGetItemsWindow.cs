using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropGetItemsWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoopListView2 propGetList;

	[SerializeField]
	private RectTransform rTF;

	[SerializeField]
	private GameObject banRoot;

	[SerializeField]
	private ListPaddingCal padding;

	[SerializeField]
	private float delayTime;

	[SerializeField]
	private float delayInterval;

	private PropGetItemsViewModel viewModel;

	private int maxDelayShowItemCount;

	private bool delaySequenceStarted;

	private bool delaySequenceScheduled;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PropGetItemsViewModel>();
		BindingSet<PropGetItemsWindow, PropGetItemsViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PropGetItemsWindow v) => v.OpenUguiWindow).To((PropGetItemsViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PropGetItemsWindow v) => v.OnDismissRequest).To((PropGetItemsViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PropGetItemsViewModel vm) => vm.Close);
		bindingSet.Build();
		InitListParam();
	}

	public void InitListParam()
	{
		delaySequenceStarted = false;
		delaySequenceScheduled = false;
		propGetList.ArrangeType = padding.Cal(viewModel.PropGetList.Count, rTF.rect.width);
		maxDelayShowItemCount = padding.GetMaxVisibleItemCount(rTF.rect.width) + 1;
		propGetList.InitListView(viewModel.PropGetList.Count, OnGetAttachmentGetItemByIndex);
		if (propGetList.ArrangeType == ListItemArrangeType.LeftToRight)
		{
			propGetList.MovePanelToItemIndex(0, 0f);
		}
		if (!delaySequenceScheduled)
		{
			delaySequenceScheduled = true;
			StartDelaySequenceAfterFirstBuildAsync(this.GetCancellationTokenOnDestroy()).Forget();
		}
	}

	private LoopListViewItem2 OnGetAttachmentGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.PropGetList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropLargeItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			DelayShow delayShow = ((component != null) ? component.GetComponentInChildren<DelayShow>(includeInactive: true) : null);
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PropGetList[index]);
			}
			else
			{
				component.RefreshData(viewModel.PropGetList[index]);
			}
			if (delayShow != null)
			{
				if (!delaySequenceStarted)
				{
					delayShow.Prepare(index);
					return loopListViewItem;
				}
				delayShow.SkipAndShow(index);
			}
		}
		return loopListViewItem;
	}

	private async UniTaskVoid StartDelaySequenceAfterFirstBuildAsync(CancellationToken cancellationToken)
	{
		float startTime = Time.realtimeSinceStartup;
		int num = ((propGetList != null) ? propGetList.GetComponentsInChildren<DelayShow>(includeInactive: true).Length : 0);
		while (num <= 0 && !cancellationToken.IsCancellationRequested)
		{
			if (Time.realtimeSinceStartup - startTime > 2f)
			{
				delaySequenceStarted = true;
				ForceShowAllDelayShowsInList();
				return;
			}
			await UniTask.Yield(PlayerLoopTiming.LastTimeUpdate, cancellationToken);
			num = ((propGetList != null) ? propGetList.GetComponentsInChildren<DelayShow>(includeInactive: true).Length : 0);
		}
		await UniTask.Yield(PlayerLoopTiming.LastTimeUpdate, cancellationToken);
		if (banRoot != null)
		{
			banRoot.SetActive(value: true);
		}
		delaySequenceStarted = true;
		DelayShow[] array = ((propGetList != null) ? propGetList.GetComponentsInChildren<DelayShow>(includeInactive: true) : null);
		if (array != null && array.Length != 0)
		{
			foreach (DelayShow delayShow in array)
			{
				if (!(delayShow == null))
				{
					delayShow.BeginOnce(delayTime, delayInterval, maxDelayShowItemCount);
				}
			}
		}
		float num2 = delayTime + (float)Mathf.Max(0, maxDelayShowItemCount - 1) * delayInterval;
		if (num2 < 0f)
		{
			num2 = 0f;
		}
		try
		{
			if (!(num2 > 0f))
			{
				await UniTask.Yield(PlayerLoopTiming.Update, cancellationToken);
			}
			else
			{
				await UniTask.Delay(TimeSpan.FromSeconds(num2), ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken);
			}
		}
		catch (OperationCanceledException)
		{
			return;
		}
		if (banRoot != null)
		{
			banRoot.SetActive(value: false);
		}
	}

	private void ForceShowAllDelayShowsInList()
	{
		if (propGetList == null)
		{
			return;
		}
		DelayShow[] componentsInChildren = propGetList.GetComponentsInChildren<DelayShow>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		foreach (DelayShow delayShow in componentsInChildren)
		{
			if (!(delayShow == null))
			{
				delayShow.SkipAndShow(delayShow.Index);
			}
		}
	}
}
