using GameFramework.Runtime;

namespace Ase;

public class WeaponCultureViewModel : OptionBase
{
	private WeaponData _weaponData;

	private WeaponPopupViewModel _weaponPopupViewModel;

	private WeaponDetailViewModel _weaponDetailViewModel;

	private WeaponUpgradeViewModel _weaponUpgradeViewModel;

	private WeaponUpStarViewModel _weaponUpStarViewModel;

	private WeaponRefineViewModel weaponRefineViewModel;

	private InteractionRequest _gotoUpStarViewRequest;

	private InteractionRequest _openUpLevelRequest;

	private InteractionRequest<EntryItem> _showEntryDetailRequest;

	private MoneyData moneyData;

	public WeaponData WeaponData
	{
		get
		{
			return _weaponData;
		}
		private set
		{
			Set(ref _weaponData, value, "WeaponData");
		}
	}

	public WeaponDetailViewModel WeaponDetailViewModel
	{
		get
		{
			return _weaponDetailViewModel;
		}
		private set
		{
			Set(ref _weaponDetailViewModel, value, "WeaponDetailViewModel");
		}
	}

	public WeaponUpgradeViewModel WeaponUpgradeViewModel
	{
		get
		{
			return _weaponUpgradeViewModel;
		}
		private set
		{
			Set(ref _weaponUpgradeViewModel, value, "WeaponUpgradeViewModel");
		}
	}

	public WeaponUpStarViewModel WeaponUpStarViewModel
	{
		get
		{
			return _weaponUpStarViewModel;
		}
		private set
		{
			Set(ref _weaponUpStarViewModel, value, "WeaponUpStarViewModel");
		}
	}

	public WeaponRefineViewModel WeaponRefineViewModel
	{
		get
		{
			return weaponRefineViewModel;
		}
		private set
		{
			Set(ref weaponRefineViewModel, value, "WeaponRefineViewModel");
		}
	}

	public MoneyData MoneyData => moneyData;

	public WeaponPopupViewModel WeaponPopupViewModel => _weaponPopupViewModel;

	public InteractionRequest GotoUpStarViewRequest => _gotoUpStarViewRequest;

	public InteractionRequest OpenUpLevelRequest => _openUpLevelRequest;

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public WeaponCultureViewModel(OptionBase parent, WeaponData weaponData)
	{
		base.parent = parent;
		_weaponData = weaponData;
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		_gotoUpStarViewRequest = new InteractionRequest();
		_openUpLevelRequest = new InteractionRequest();
		_weaponDetailViewModel = new WeaponDetailViewModel(this, WeaponData);
		WeaponDetailViewModel.IsShowChange = false;
		_weaponUpgradeViewModel = new WeaponUpgradeViewModel(this, WeaponData, moneyData);
		_showEntryDetailRequest = new InteractionRequest<EntryItem>();
		_weaponUpStarViewModel = new WeaponUpStarViewModel(this, weaponData, moneyData);
		weaponRefineViewModel = new WeaponRefineViewModel(this, weaponData);
		_weaponPopupViewModel = new WeaponPopupViewModel(this, _weaponData, showHeroInfo: true, -81f, 12f, showMask1: false, showMask2: false);
		OpenCulturePanel();
	}

	private bool CheckNeedRefreshWhenViewBack(object obj)
	{
		if (obj is OpenViewArg || obj is PropInfoViewModelBase || obj is WeaponPopupViewModel)
		{
			return false;
		}
		return true;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		object obj2 = obj;
		if (obj is ViewBackArg viewBackArg)
		{
			obj2 = viewBackArg.Obj;
		}
		if (CheckNeedRefreshWhenViewBack(obj2))
		{
			RefreshWeaponData();
		}
		if (obj is WeaponUpgradeViewModel)
		{
			if (WeaponData.Level == WeaponData.MaxLevel)
			{
				_gotoUpStarViewRequest.Raise();
			}
		}
		else if (obj is WeaponUpStarViewModel)
		{
			_weaponUpgradeViewModel.ClearExpItem();
			_weaponUpgradeViewModel.GetTargetData();
			_openUpLevelRequest.Raise();
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			GameProcessType gameProcess = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess();
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, gameProcess == GameProcessType.Outer);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (!(obj is WeaponRefineViewModel) && obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel"))
		{
			ShowEntryDetail((EntryItem)optionArg.Obj);
		}
		if (obj is OptionArg optionArg2 && "OnMulti".Equals(optionArg2.OptionName))
		{
			parent?.ItemOnClick(optionArg2);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		_weaponUpgradeViewModel?.RefreshWhenBack(arg);
		JumpReturnRefresh();
	}

	private void JumpReturnRefresh()
	{
		_weaponUpStarViewModel.Refresh();
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		_showEntryDetailRequest.Raise(entryItem);
	}

	private void RefreshWeaponData()
	{
		WeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(WeaponData.Uid);
		_weaponPopupViewModel?.RefreshData(WeaponData);
		_weaponDetailViewModel?.RefreshData(WeaponData, isShowChange: false);
		_weaponUpgradeViewModel?.RefreshData(WeaponData);
		_weaponUpgradeViewModel?.RefreshAll();
		_weaponUpStarViewModel?.Refresh(WeaponData);
	}

	public void OpenCulturePanel()
	{
		if (WeaponData.Level == WeaponData.MaxLevel)
		{
			_gotoUpStarViewRequest.Raise();
		}
		else
		{
			_openUpLevelRequest.Raise();
		}
	}

	public void CloseProp()
	{
		_weaponUpgradeViewModel.CloseProp();
	}

	public override void Close()
	{
		CloseProp();
		parent?.ItemOnClick(this);
		base.Close();
	}
}
