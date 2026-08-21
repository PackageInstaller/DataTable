using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HomeComeAllGiftViewModel : OptionBase
{
	private readonly List<HomeComeAllGiftItemViewModel> rewardItems = new List<HomeComeAllGiftItemViewModel>();

	private readonly InteractionRequest refreshRewardListRequest = new InteractionRequest();

	private readonly SimpleCommand jumpSignCommand;

	private readonly SimpleCommand jumpTaskCommand;

	private IHomeComeService service;

	private ISubscription<HomeComeMessage> subscription;

	private bool showReceiveState;

	public List<HomeComeAllGiftItemViewModel> RewardItems => rewardItems;

	public IInteractionRequest RefreshRewardListRequest => refreshRewardListRequest;

	public SimpleCommand JumpSignCommand => jumpSignCommand;

	public SimpleCommand JumpTaskCommand => jumpTaskCommand;

	public bool ShowReceiveState
	{
		get
		{
			return showReceiveState;
		}
		set
		{
			Set(ref showReceiveState, value, "ShowReceiveState");
		}
	}

	public HomeComeAllGiftViewModel()
	{
		jumpSignCommand = new SimpleCommand(OnJumpSignTab);
		jumpTaskCommand = new SimpleCommand(OnJumpTaskTab);
	}

	public HomeComeAllGiftViewModel(OptionBase parent)
		: this()
	{
		base.parent = parent;
		service = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
		BuildRewardItems();
		subscription = service?.GetMessager()?.Subscribe<HomeComeMessage>(OnHomeComeMessage);
		RefreshState();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HomeComeAllGiftItemViewModel homeComeAllGiftItemViewModel)
		{
			OpenPropInfo(homeComeAllGiftItemViewModel.PropData);
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	private void BuildRewardItems()
	{
		rewardItems.Clear();
		List<PropDataBase> list = HomeComeTableHelper.BuildRewardPropsFromRewardDesc(10001);
		if (list.Count <= 0)
		{
			list = HomeComeTableHelper.BuildRewardPropsFromReward(1001001);
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] != null && !list[i].Empty)
			{
				rewardItems.Add(new HomeComeAllGiftItemViewModel(this, list[i]));
			}
		}
		refreshRewardListRequest.Raise();
	}

	private void OnHomeComeMessage(HomeComeMessage msg)
	{
		if (msg != null)
		{
			HomeComeMessageEnum type = msg.Type;
			if ((uint)type <= 1u || type == HomeComeMessageEnum.GiftClaimed)
			{
				RefreshState();
			}
		}
	}

	private void OnJumpSignTab()
	{
		if (parent is HomeComeWindowViewModel homeComeWindowViewModel)
		{
			homeComeWindowViewModel.SelectTab(1);
		}
	}

	private void OnJumpTaskTab()
	{
		if (parent is HomeComeWindowViewModel homeComeWindowViewModel)
		{
			homeComeWindowViewModel.SelectTab(2);
		}
	}

	private void OpenPropInfo(PropDataBase propData)
	{
		if (propData != null && !propData.Empty)
		{
			OpenViewArg obj = PropHelper.OpenPopupWindow(propData, parent);
			parent?.ItemOnClick(obj);
		}
	}

	private void RefreshState()
	{
		HomeComeData homeComeData = service?.GetData();
		ShowReceiveState = homeComeData != null && homeComeData.IsInReturn && homeComeData.GiftClaimed;
	}

	public override void Dispose()
	{
		subscription?.Dispose();
		subscription = null;
		service = null;
		base.Dispose();
	}
}
