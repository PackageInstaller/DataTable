using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HomeComePopupWindowViewModel : OptionBase
{
	private readonly List<PropDataBase> rewardItems = new List<PropDataBase>();

	private readonly InteractionRequest refreshRewardRequest = new InteractionRequest();

	private readonly SimpleCommand claimOrCloseCommand;

	private IHomeComeService service;

	private ISubscription<HomeComeMessage> subscription;

	private bool isClaiming;

	public List<PropDataBase> RewardItems => rewardItems;

	public IInteractionRequest RefreshRewardRequest => refreshRewardRequest;

	public SimpleCommand ClaimOrCloseCommand => claimOrCloseCommand;

	public HomeComePopupWindowViewModel()
	{
		claimOrCloseCommand = new SimpleCommand(OnClaimOrCloseClick);
		Initialize();
	}

	public HomeComePopupWindowViewModel(OptionBase parent)
		: this()
	{
		base.parent = parent;
	}

	private void Initialize()
	{
		service = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
		BuildRewardPreview();
		subscription = service?.GetMessager()?.Subscribe<HomeComeMessage>(OnHomeComeMessage);
		RefreshCommandState();
	}

	private void BuildRewardPreview()
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
				rewardItems.Add(list[i]);
			}
		}
		refreshRewardRequest.Raise();
	}

	private void OnHomeComeMessage(HomeComeMessage msg)
	{
		if (msg == null)
		{
			return;
		}
		switch (msg.Type)
		{
		case HomeComeMessageEnum.GiftClaimed:
			Close();
			break;
		case HomeComeMessageEnum.InfoChanged:
		case HomeComeMessageEnum.OpenStateChanged:
			if (!CanClaimGift())
			{
				Close();
			}
			break;
		}
	}

	private bool CanClaimGift()
	{
		HomeComeData homeComeData = service?.GetData();
		if (homeComeData != null && homeComeData.IsInReturn)
		{
			return !homeComeData.GiftClaimed;
		}
		return false;
	}

	private void RefreshCommandState()
	{
		claimOrCloseCommand.Enabled = !isClaiming;
	}

	private async void OnClaimOrCloseClick()
	{
		if (isClaiming)
		{
			return;
		}
		if (!CanClaimGift())
		{
			Close();
			return;
		}
		isClaiming = true;
		RefreshCommandState();
		PbDropThing pbDropThing = await service.GetHomeComeGiftRst();
		isClaiming = false;
		RefreshCommandState();
		if (pbDropThing == null)
		{
			return;
		}
		RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(pbDropThing);
		if (rewardGetData?.PropList != null && rewardGetData.PropList.Count > 0)
		{
			OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(this, rewardGetData.PropList));
			if (parent != null)
			{
				parent.ItemOnClick(obj);
			}
			else
			{
				ItemOnClick(obj);
			}
		}
		Close();
	}

	public override void Dispose()
	{
		subscription?.Dispose();
		subscription = null;
		service = null;
		base.Dispose();
	}
}
