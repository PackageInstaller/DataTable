using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class RockCultureViewModel : OptionBase
{
	private ArmourData armourData;

	private RockPopupViewModel rockPopupViewModel;

	private RockDevelopViewModel rockDevelopViewModel;

	private R6RockDevelopViewModel r6RockDevelopViewModel;

	private InteractionRequest refreshViewRequest;

	private InteractionRequest closePopupRequest;

	private TabItemNormalData rockDetailBtn;

	private TabItemNormalData rockDevelopBtn;

	private bool openPropPopupWindowEnable = true;

	private InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> openPropPopupRst = new InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>>();

	public InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> OpenPropPopupRst => openPropPopupRst;

	public ArmourData ArmourData
	{
		get
		{
			return armourData;
		}
		private set
		{
			Set(ref armourData, value, "ArmourData");
		}
	}

	public TabItemNormalData RockDetailBtn => rockDetailBtn;

	public TabItemNormalData RockDevelopBtn => rockDevelopBtn;

	public RockPopupViewModel RockPopupViewModel => rockPopupViewModel;

	public RockDevelopViewModel RockDevelopViewModel => rockDevelopViewModel;

	public R6RockDevelopViewModel R6RockDevelopViewModel => r6RockDevelopViewModel;

	public InteractionRequest ClosePopupRequest => closePopupRequest;

	public InteractionRequest RefreshViewRequest => refreshViewRequest;

	public RockCultureViewModel(OptionBase parent, ArmourData armourData, bool needOpenDetail = true)
	{
		base.parent = parent;
		refreshViewRequest = new InteractionRequest();
		closePopupRequest = new InteractionRequest();
		this.armourData = armourData;
		rockPopupViewModel = new RockPopupViewModel(this, armourData);
		rockPopupViewModel.SetShowTotalEntryLevel(show: true);
		rockPopupViewModel.LoadDefaultEntry();
		rockDevelopViewModel = new RockDevelopViewModel(this, armourData);
		r6RockDevelopViewModel = new R6RockDevelopViewModel(this, armourData);
		InitTabData(needOpenDetail);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData onclickBtn)
		{
			SwitchTab(onclickBtn);
			rockPopupViewModel.HideEntryDetailRequest.Raise();
			refreshViewRequest.Raise();
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if ("ClosePopup".Equals(optionArg.OptionName))
			{
				closePopupRequest.Raise();
			}
			if ("Refresh".Equals(optionArg.OptionName))
			{
				refreshViewRequest.Raise();
				rockPopupViewModel.RefreshArmourData();
				rockPopupViewModel.PlayNewEntryEffect();
			}
			if (optionArg.Obj is RockDevelopSelectViewModel rockDevelopSelectViewModel)
			{
				if ("Success".Equals(optionArg.OptionName) && rockDevelopSelectViewModel.OldPopupViewModel.ArmourData.Uid == armourData.Uid)
				{
					rockDevelopViewModel.RefreshData();
					r6RockDevelopViewModel.RefreshData();
					refreshViewRequest.Raise();
					rockPopupViewModel.RefreshArmourData();
					rockPopupViewModel.PlayNewEntryEffect();
				}
			}
			else if (optionArg.Obj is RockPopupViewModel)
			{
				if ("ChangeLock".Equals(optionArg.OptionName))
				{
					rockDevelopViewModel.RockPopupViewModel.ChangeLockState();
					r6RockDevelopViewModel.RockPopupViewModel.ChangeLockState();
				}
			}
			else if (optionArg.Obj is RockDevelopViewModel)
			{
				if ("ChangeLock".Equals(optionArg.OptionName))
				{
					rockPopupViewModel.ChangeLockState();
				}
			}
			else if (optionArg.Obj is KeyValuePair<RoleMoneyEnum, Vector3> context)
			{
				if (optionArg.OptionName == "OnIconBtnClick" && openPropPopupWindowEnable)
				{
					openPropPopupRst.Raise(context);
				}
			}
			else
			{
				parent?.ItemOnClick(optionArg);
			}
		}
	}

	public void OpenPropPopupWindow(DRProp drProp, Vector2 pos)
	{
		if (openPropPopupWindowEnable)
		{
			openPropPopupWindowEnable = false;
			Vector2 zero = Vector2.zero;
			if (pos.x < (0f - UIUtilly.GetCanvasSize().x) / 2f + 522f)
			{
				pos = new Vector2(pos.x + 50f, pos.y);
				zero = new Vector2(0f, 1f);
			}
			else
			{
				zero = Vector2.one;
			}
			PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, allowSkipWindow: true);
			propWindowViewModel.RefreshData(new PropData(drProp));
			propWindowViewModel.SetPosition(pos);
			propWindowViewModel.SetRectInfo(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), zero);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel, "RockCulture", isOpenWindow: true, "DEFAULT", delegate
			{
				openPropPopupWindowEnable = true;
			}));
		}
	}

	public void OpenSuccess()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetUnselectSuitBox();
		if (uid <= 0)
		{
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", "您有改造流程未完成,需先完成才能进行新的改造 \n <color=#ff8a7a>点击确定可跳转至未完成的改造流程</color>", "", "", "确认", canceledOnTop: false);
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -3)
			{
				OpenSelectWindow(uid);
			}
		});
	}

	private void InitTabData(bool needOpenDetail)
	{
		rockDetailBtn = new TabItemNormalData(this, string.Empty);
		rockDevelopBtn = new TabItemNormalData(this, string.Empty, 1);
		TabItemNormalData onclickBtn = (needOpenDetail ? rockDetailBtn : rockDevelopBtn);
		SwitchTab(onclickBtn);
		refreshViewRequest.Raise();
	}

	private async void SwitchTab(TabItemNormalData onclickBtn)
	{
		if (onclickBtn != null && !onclickBtn.IsSelected)
		{
			rockDetailBtn.IsSelected = onclickBtn.ID == rockDetailBtn.ID;
			rockDevelopBtn.IsSelected = rockDevelopBtn.ID == onclickBtn.ID;
			rockDevelopViewModel.Clear();
			r6RockDevelopViewModel.Clear();
			rockPopupViewModel.CloseEffect();
			await UniTask.Delay(100);
		}
	}

	private void OpenSelectWindow(long uid)
	{
		ArmourData armourById = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(uid);
		if (uid == 0L)
		{
			return;
		}
		Dictionary<int, List<RockDevelopEntryItemData>> developEntryDic = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetDevelopEntryDic();
		List<RockPopupViewModel> list = new List<RockPopupViewModel>();
		foreach (int key in developEntryDic.Keys)
		{
			RockPopupViewModel rockPopupViewModel = new RockPopupViewModel(this, armourById);
			rockPopupViewModel.LoadDevelopEntry(developEntryDic[key], key);
			list.Add(rockPopupViewModel);
		}
		RockPopupViewModel rockPopupViewModel2 = new RockPopupViewModel(this, armourById);
		rockPopupViewModel2.LoadDefaultEntry();
		list.Sort((RockPopupViewModel p1, RockPopupViewModel p2) => (p1.Index != p2.Index) ? p1.Index.CompareTo(p2.Index) : 0);
		RockDevelopSelectViewModel userData = new RockDevelopSelectViewModel(this, rockPopupViewModel2, list);
		openWindowRequest.Raise(new OpenViewArg(typeof(RockDevelopSelectWindow), userData));
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "RefreshRock"));
		base.Close();
	}
}
