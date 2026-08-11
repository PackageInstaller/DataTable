using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HomeComeSignRewardViewModel : OptionBase
{
	private readonly List<HomeComeSignItemViewModel> signItems = new List<HomeComeSignItemViewModel>();

	private readonly List<DRHomeComeSign> signRows = new List<DRHomeComeSign>();

	private readonly InteractionRequest refreshSignListRequest = new InteractionRequest();

	private IHomeComeService service;

	private ISubscription<HomeComeMessage> subscription;

	private bool isClaiming;

	public List<HomeComeSignItemViewModel> SignItems => signItems;

	public IInteractionRequest RefreshSignListRequest => refreshSignListRequest;

	public HomeComeSignRewardViewModel()
	{
	}

	public HomeComeSignRewardViewModel(OptionBase parent)
	{
		base.parent = parent;
		service = Singleton<ServiceSystem>.Instance.GetService<IHomeComeService>();
		BuildSignItems();
		subscription = service?.GetMessager()?.Subscribe<HomeComeMessage>(OnHomeComeMessage);
		RefreshFromData();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HomeComeSignItemViewModel homeComeSignItemViewModel)
		{
			if (homeComeSignItemViewModel.CanClaim)
			{
				ClaimSign(homeComeSignItemViewModel);
			}
		}
		else if (obj is HomeComeSignRewardCellViewModel homeComeSignRewardCellViewModel)
		{
			OpenPropInfo(homeComeSignRewardCellViewModel.PropData);
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	private void BuildSignItems()
	{
		signItems.Clear();
		signRows.Clear();
		List<DRHomeComeSign> signRowsSorted = HomeComeTableHelper.GetSignRowsSorted();
		for (int i = 0; i < signRowsSorted.Count; i++)
		{
			DRHomeComeSign dRHomeComeSign = signRowsSorted[i];
			signRows.Add(dRHomeComeSign);
			List<PropDataBase> rewardProps = HomeComeTableHelper.BuildRewardPropsFromReward(dRHomeComeSign.Reward);
			signItems.Add(new HomeComeSignItemViewModel(this, dRHomeComeSign.Id, dRHomeComeSign.SignDate, rewardProps));
		}
		refreshSignListRequest.Raise();
	}

	private void OnHomeComeMessage(HomeComeMessage msg)
	{
		if (msg != null)
		{
			HomeComeMessageEnum type = msg.Type;
			if (type == HomeComeMessageEnum.InfoChanged || type == HomeComeMessageEnum.SignClaimed || type == HomeComeMessageEnum.RedPointChanged)
			{
				RefreshFromData();
			}
		}
	}

	private void RefreshFromData()
	{
		if (signRows.Count != signItems.Count)
		{
			BuildSignItems();
		}
		HomeComeData homeComeData = service?.GetData();
		HomeComeSignIdMode mode = HomeComeTableHelper.DetectSignIdMode(homeComeData, signRows);
		for (int i = 0; i < signRows.Count && i < signItems.Count; i++)
		{
			DRHomeComeSign dRHomeComeSign = signRows[i];
			HomeComeSignItemViewModel homeComeSignItemViewModel = signItems[i];
			bool flag = homeComeData != null && (homeComeData.IsSignClaimed(dRHomeComeSign.Id) || homeComeData.IsSignClaimed(dRHomeComeSign.SignDate));
			bool flag2 = homeComeData != null && homeComeData.IsInReturn && homeComeData.SignDays >= dRHomeComeSign.SignDate;
			bool isCanClaim = flag2 && !flag;
			int signRequestId = HomeComeTableHelper.GetSignRequestId(dRHomeComeSign, mode);
			int signAlternateRequestId = HomeComeTableHelper.GetSignAlternateRequestId(dRHomeComeSign, mode);
			homeComeSignItemViewModel.UpdateDynamicState(flag, isCanClaim, flag2, signRequestId, signAlternateRequestId);
		}
	}

	private async void ClaimSign(HomeComeSignItemViewModel item)
	{
		if (isClaiming || service == null || item == null || !item.CanClaim)
		{
			return;
		}
		isClaiming = true;
		item.SetClickable(enable: false);
		PbDropThing pbDropThing = null;
		if (item.RequestSignId > 0)
		{
			pbDropThing = await service.GetHomeComeSignRewardRst(item.RequestSignId);
		}
		if (pbDropThing == null && item.AltRequestSignId > 0 && item.AltRequestSignId != item.RequestSignId)
		{
			pbDropThing = await service.GetHomeComeSignRewardRst(item.AltRequestSignId);
		}
		item.SetClickable(enable: true);
		isClaiming = false;
		if (pbDropThing != null)
		{
			RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(pbDropThing);
			if (rewardGetData?.PropList != null && rewardGetData.PropList.Count > 0)
			{
				parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(parent, rewardGetData.PropList)));
			}
		}
		RefreshFromData();
	}

	private void OpenPropInfo(PropDataBase propData)
	{
		if (propData != null && !propData.Empty)
		{
			OpenViewArg obj = PropHelper.OpenPopupWindow(propData, parent);
			parent?.ItemOnClick(obj);
		}
	}

	public override void Dispose()
	{
		subscription?.Dispose();
		subscription = null;
		service = null;
		base.Dispose();
	}
}
