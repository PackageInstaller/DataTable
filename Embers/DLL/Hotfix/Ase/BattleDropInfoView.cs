using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleDropInfoView : UGuiView
{
	public float wait2TweenTime = 1f;

	public int maxShowCount = 5;

	public float itemShowInternal = 0.02f;

	[SerializeField]
	private GameObject main;

	[SerializeField]
	private BattleDropItem itemTpl;

	[SerializeField]
	private Transform shownItemRoot;

	[SerializeField]
	private Transform cacheItemRoot;

	private Queue<BattleDropItem> _itemQueue = new Queue<BattleDropItem>();

	private List<BattleDropItem> disposeList = new List<BattleDropItem>();

	private ISubscription<DropSystem.DropInfo> _showDrops;

	private ISubscription<TaskRewardsReceiveMessager> _showTaskRewards;

	private IMessenger _messenger;

	private BattleDropInfoViewModel _viewModel;

	public void Init(BattleDropInfoViewModel viewModel)
	{
		_viewModel = viewModel;
		_viewModel.Wait2TweenTime = wait2TweenTime;
		_viewModel.MaxShowCount = maxShowCount;
		_viewModel.ItemShowInterval = itemShowInternal;
		_messenger = Context.GetApplicationContext().GetService<IMessenger>();
		_showDrops = _messenger.Subscribe<DropSystem.DropInfo>("DropMessageInfoChannel", _viewModel.ShowDrop);
		_showTaskRewards = _messenger.Subscribe<TaskRewardsReceiveMessager>(_viewModel.ShowTaskRewards);
		BindingSet<BattleDropInfoView, BattleDropInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((BattleDropInfoView v) => v.TryShowDrop).To((BattleDropInfoViewModel vm) => vm.ShowDropRst);
		bindingSet.Build();
		for (int num = 0; num < maxShowCount; num++)
		{
			BattleDropItem item = Object.Instantiate(itemTpl, cacheItemRoot);
			disposeList.Add(item);
			_itemQueue.Enqueue(item);
		}
	}

	private void TryShowDrop(object sender, InteractionEventArgs e)
	{
		BattleDropItemData itemData = (BattleDropItemData)e.Context;
		BattleDropItem battleDropItem = Acquire(itemData);
		if (!(battleDropItem == null))
		{
			if (!main.activeSelf)
			{
				main.SetActive(value: true);
			}
			battleDropItem.Show();
		}
	}

	public BattleDropItem Acquire(BattleDropItemData itemData)
	{
		BattleDropItem battleDropItem = null;
		if (_itemQueue.Count > 0)
		{
			battleDropItem = _itemQueue.Dequeue();
			if (!battleDropItem.Iniitialized)
			{
				battleDropItem.Init(itemData, Return2Pool);
			}
			else
			{
				battleDropItem.RefreshData(itemData);
			}
			battleDropItem.transform.SetParent(shownItemRoot);
			_viewModel.ShownItemCount++;
		}
		return battleDropItem;
	}

	public void Return2Pool(BattleDropItem item)
	{
		_itemQueue.Enqueue(item);
		item.transform.SetParent(cacheItemRoot);
		_viewModel.ShownItemCount--;
		if (_viewModel.ShownItemCount <= 0)
		{
			main.SetActive(value: false);
		}
	}

	public void Dispose()
	{
		_showDrops?.Dispose();
		_showDrops = null;
		_itemQueue?.Clear();
		if (disposeList != null)
		{
			for (int num = disposeList.Count - 1; num >= 0; num--)
			{
				Object.DestroyImmediate(disposeList[num]);
				disposeList[num] = null;
			}
			disposeList = null;
		}
		_itemQueue = null;
		_viewModel = null;
	}

	public override void AfterCloseView()
	{
		Dispose();
	}
}
