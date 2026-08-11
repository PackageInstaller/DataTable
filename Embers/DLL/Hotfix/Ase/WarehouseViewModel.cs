using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WarehouseViewModel : OptionBase
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct FuncBtnUseType
	{
		public const string DetailInfo = "详情";

		public const string Use = "使用";

		public const string LookOver = "查看";

		public const string Open = "开启";
	}

	private bool showScreenToggle;

	private bool showDecompose;

	private bool showDecomposeScreen;

	private bool _showFuncBtn;

	private string _funcBtnText;

	private KnapsackDefinition.WarehouseTabEnum _curTabType = KnapsackDefinition.WarehouseTabEnum.Weapon;

	private KnapsackDefinition.WarehouseScreenType _curScreenType = KnapsackDefinition.WarehouseScreenType.Rarity;

	private KnapsackDefinition.WarehouseAutoScreenType _curAutoDecomposeScreenType = KnapsackDefinition.WarehouseAutoScreenType.Green;

	private string _curScreenMode;

	private string _curAutoDecomposeScreenMode;

	private KnapsackDefinition.WarehouseStateMode stateMode;

	private List<KnapsackItemViewModel> _filterDataList = new List<KnapsackItemViewModel>();

	private Dictionary<long, KnapsackItemViewModel> _selectedDecomposeDatas = new Dictionary<long, KnapsackItemViewModel>();

	private List<PropData> decomposeProducts = new List<PropData>();

	private bool autoSelect;

	private KnapsackItemViewModel _curSelectData;

	private WeaponPopupViewModel _weaponPopupViewModel;

	private ArmourPopupViewModel _armourPropViewModel;

	private PropInfoViewModel _propInfoViewModel;

	private RockPopupViewModel _rockInfoViewModel;

	private InteractionRequest<WeaponPopupViewModel> openWeaponInfoViewRst = new InteractionRequest<WeaponPopupViewModel>();

	private InteractionRequest<ArmourPopupViewModel> openArmourInfoViewRst = new InteractionRequest<ArmourPopupViewModel>();

	private InteractionRequest<PropInfoViewModel> openPropInfoViewRst = new InteractionRequest<PropInfoViewModel>();

	private InteractionRequest<RockPopupViewModel> openRockInfoViewRst = new InteractionRequest<RockPopupViewModel>();

	private InteractionRequest refreshDecomposeProducts = new InteractionRequest();

	private InteractionRequest _refreshPropRequest = new InteractionRequest();

	private InteractionRequest<EntryItem> _showEntryDetailRequest = new InteractionRequest<EntryItem>();

	private SimpleCommand _decomposeCommand;

	private SimpleCommand<JumpWindowParams> _openWindowCmd;

	public KnapsackDefinition.WarehouseTabEnum CurTabType
	{
		get
		{
			return _curTabType;
		}
		private set
		{
			if (Set(ref _curTabType, value, "CurTabType") && _curSelectData != null)
			{
				_curSelectData.IsSelected = false;
				_curSelectData = null;
			}
			ShowScreenToggle = value == KnapsackDefinition.WarehouseTabEnum.Weapon || value == KnapsackDefinition.WarehouseTabEnum.Armour || value == KnapsackDefinition.WarehouseTabEnum.SuitBox;
			ShowDecompose = value == KnapsackDefinition.WarehouseTabEnum.Weapon || value == KnapsackDefinition.WarehouseTabEnum.Armour || value == KnapsackDefinition.WarehouseTabEnum.SuitBox || value == KnapsackDefinition.WarehouseTabEnum.Consume;
			ShowDecomposeScreen = value == KnapsackDefinition.WarehouseTabEnum.Weapon || value == KnapsackDefinition.WarehouseTabEnum.Armour || value == KnapsackDefinition.WarehouseTabEnum.SuitBox;
			CurAutoDecomposeScreenMode = CurAutoDecomposeScreenType.GetDescription() + value.GetDescription();
		}
	}

	public KnapsackDefinition.WarehouseScreenType CurScreenType
	{
		get
		{
			return _curScreenType;
		}
		set
		{
			Set(ref _curScreenType, value, "CurScreenType");
			CurScreenMode = value.GetDescription();
		}
	}

	public bool ShowScreenToggle
	{
		get
		{
			return showScreenToggle;
		}
		set
		{
			Set(ref showScreenToggle, value, "ShowScreenToggle");
		}
	}

	public bool ShowDecompose
	{
		get
		{
			return showDecompose;
		}
		set
		{
			Set(ref showDecompose, value, "ShowDecompose");
		}
	}

	public bool ShowDecomposeScreen
	{
		get
		{
			return showDecomposeScreen;
		}
		set
		{
			Set(ref showDecomposeScreen, value, "ShowDecomposeScreen");
		}
	}

	public string CurScreenMode
	{
		get
		{
			return _curScreenMode;
		}
		set
		{
			Set(ref _curScreenMode, value, "CurScreenMode");
		}
	}

	public KnapsackDefinition.WarehouseAutoScreenType CurAutoDecomposeScreenType
	{
		get
		{
			return _curAutoDecomposeScreenType;
		}
		set
		{
			if (Set(ref _curAutoDecomposeScreenType, value, "CurAutoDecomposeScreenType"))
			{
				ClearDecomposeSelect();
				refreshDecomposeProducts.Raise();
			}
			CurAutoDecomposeScreenMode = value.GetDescription() + CurTabType.GetDescription();
		}
	}

	public string CurAutoDecomposeScreenMode
	{
		get
		{
			return _curAutoDecomposeScreenMode;
		}
		set
		{
			Set(ref _curAutoDecomposeScreenMode, value, "CurAutoDecomposeScreenMode");
		}
	}

	public KnapsackDefinition.WarehouseStateMode StateMode
	{
		get
		{
			return stateMode;
		}
		set
		{
			if (Set(ref stateMode, value, "StateMode"))
			{
				OnStateModeChanged();
			}
		}
	}

	public bool ShowFuncBtn
	{
		get
		{
			return _showFuncBtn;
		}
		set
		{
			Set(ref _showFuncBtn, value, "ShowFuncBtn");
		}
	}

	public string FuncBtnText
	{
		get
		{
			return _funcBtnText;
		}
		set
		{
			Set(ref _funcBtnText, value, "FuncBtnText");
		}
	}

	public KnapsackItemViewModel CurSelectData => _curSelectData;

	public bool AutoSelect => autoSelect;

	public List<PropData> DecomposeProducts => decomposeProducts;

	public List<KnapsackItemViewModel> FilterDataList => _filterDataList;

	public InteractionRequest RefreshPropRequest => _refreshPropRequest;

	public InteractionRequest<WeaponPopupViewModel> OpenWeaponInfoViewRst => openWeaponInfoViewRst;

	public InteractionRequest<ArmourPopupViewModel> OpenArmourInfoViewRst => openArmourInfoViewRst;

	public InteractionRequest<PropInfoViewModel> OpenPropInfoViewRst => openPropInfoViewRst;

	public InteractionRequest<RockPopupViewModel> OpenRockInfoViewRst => openRockInfoViewRst;

	public InteractionRequest RefreshDecomposeProducts => refreshDecomposeProducts;

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public WeaponPopupViewModel WeaponPopupViewModel => _weaponPopupViewModel;

	public ArmourPopupViewModel ArmourPropViewModel => _armourPropViewModel;

	public RockPopupViewModel RockInfoViewModel => _rockInfoViewModel;

	public PropInfoViewModel PropInfoViewModel => _propInfoViewModel;

	public WarehouseViewModel()
	{
	}

	public WarehouseViewModel(OptionBase parent, bool inBattle = false, KnapsackDefinition.WarehouseTabEnum defaultTab = KnapsackDefinition.WarehouseTabEnum.Weapon)
	{
		base.parent = parent;
		_decomposeCommand = new SimpleCommand(DecomposeCommand);
		_openWindowCmd = new SimpleCommand<JumpWindowParams>(OpenWindowCommand);
		_weaponPopupViewModel = new WeaponPopupViewModel(this, showHeroInfo: true, -81f, 12f, showMask1: false, showMask2: false);
		_armourPropViewModel = new ArmourPopupViewModel(this, showHeroInfo: true, -81f, 12f, showOutsideMask: false);
		_propInfoViewModel = new PropInfoViewModel(this, new Vector2(-81f, 12f), showOutsideMask: false, showOwnCount: false);
		_rockInfoViewModel = new RockPopupViewModel(this, new Vector2(-81f, 12f), showOutsideMask: false);
		if (!Enum.IsDefined(typeof(KnapsackDefinition.WarehouseTabEnum), defaultTab))
		{
			defaultTab = KnapsackDefinition.WarehouseTabEnum.Weapon;
		}
		CurTabType = defaultTab;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackDefinition.WarehouseTabEnum curTabType)
		{
			CurTabType = curTabType;
			StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
			GetFilterDataList();
		}
		else if (obj is KnapsackDefinition.WarehouseScreenType curScreenType)
		{
			CurScreenType = curScreenType;
			GetFilterDataList();
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			if (knapsackItemViewModel is WeaponItemData || knapsackItemViewModel is ArmourItemData || knapsackItemViewModel is WarehouseItemData)
			{
				OnKnapsackItemClick(knapsackItemViewModel);
				return;
			}
			GameProcessType gameProcess = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess();
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, gameProcess == GameProcessType.Outer);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			_openWindowCmd.Execute(jumpWindowParams);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is WarehouseItemData data)
			{
				if (optionArg.OptionName == "RemoveSelect")
				{
					OnPropCancelSelectInDecompose(data);
				}
				else if (optionArg.OptionName == "AddSelect")
				{
					UpdateDecomposeProducts();
				}
				else if (optionArg.OptionName == "DecSelect")
				{
					UpdateDecomposeProducts();
				}
			}
			else if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				ShowEntryDetail((EntryItem)optionArg.Obj);
			}
			else if ("OnMulti".Equals(optionArg.OptionName))
			{
				parent.ItemOnClick(optionArg);
			}
			else if (optionArg.OptionName == "ChangeLock")
			{
				OnLockChangedInDecomposeMode(optionArg);
			}
		}
		else if (obj is BattleReadyViewModel || obj is CopyST4EnterItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		_showEntryDetailRequest.Raise(entryItem);
	}

	private void OnStateModeChanged()
	{
		if (StateMode != KnapsackDefinition.WarehouseStateMode.Decompose)
		{
			ClearDecomposeSelect();
			refreshDecomposeProducts.Raise();
		}
		GetFilterDataList(!StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose));
		if (_weaponPopupViewModel != null)
		{
			_weaponPopupViewModel.ShowLockBtn = StateMode != KnapsackDefinition.WarehouseStateMode.Decompose;
		}
		if (_armourPropViewModel != null)
		{
			_armourPropViewModel.ShowLockBtn = StateMode != KnapsackDefinition.WarehouseStateMode.Decompose;
		}
		if (_rockInfoViewModel != null)
		{
			_rockInfoViewModel.ShowLockBtn = StateMode != KnapsackDefinition.WarehouseStateMode.Decompose;
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		if (arg == null || (!(arg.Obj is PropWindowViewModel) && !(arg.Obj is ArmourPopupViewModel) && !(arg.Obj is WeaponPopupViewModel)))
		{
			GetFilterDataList();
		}
	}

	public void OnKnapsackItemClick(KnapsackItemViewModel data)
	{
		if (data.New)
		{
			data.New = false;
			if (data is WarehouseItemData warehouseItemData)
			{
				warehouseItemData.PropDataBase.New = false;
				Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(warehouseItemData.PropDataBase.Id)
					.IsNew = false;
			}
			else if (data is WeaponItemData weaponItemData)
			{
				weaponItemData.Data.New = false;
			}
			else if (data is ArmourItemData armourItemData)
			{
				armourItemData.Data.New = false;
			}
		}
		if (StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Normal))
		{
			SetSelected(data);
			ShowItemInfoWindow(data);
			UpdateFuncBtnState(data);
		}
		else if (StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose))
		{
			if (!data.IsActive)
			{
				OnInActiveItemClickInDecompose(data);
			}
			else if (data is WarehouseItemData data2)
			{
				OnPropClickInDecompose(data2);
			}
			else
			{
				OnEquipmentClickInDecompose(data);
			}
		}
	}

	private void SetSelected(KnapsackItemViewModel data)
	{
		if (_curSelectData != null)
		{
			_curSelectData.IsSelected = false;
		}
		_curSelectData = data;
		_curSelectData.IsSelected = true;
	}

	public void OnFuncBtnClick()
	{
		if (!ShowFuncBtn)
		{
			return;
		}
		List<object> list = new List<object>();
		switch (FuncBtnText)
		{
		case "详情":
			if (_curSelectData is WeaponItemData item)
			{
				list.Add(item);
				_openWindowCmd.Execute(new JumpWindowParams("WeaponCultureWindow", list));
			}
			else if (_curSelectData is ArmourItemData item2)
			{
				list.Add(item2);
				_openWindowCmd.Execute(new JumpWindowParams("ArmourCultureWindow", list));
			}
			break;
		case "使用":
			if (_curSelectData.PropDataBase.Id == PropHelper.GetChangeNameCardId())
			{
				_openWindowCmd.Execute(new JumpWindowParams("PlayerNameChangeWindow"));
			}
			else if (_curSelectData.PropDataBase is PropData propData)
			{
				if (propData.UseType.Contains(21))
				{
					list.Add(propData.Id);
					_openWindowCmd.Execute(new JumpWindowParams("ArmourCustomWindow", list));
				}
			}
			else
			{
				_openWindowCmd.Execute(new JumpWindowParams("HeroWarehouseWindow"));
			}
			break;
		case "查看":
			list.Add((PropData)_curSelectData.PropDataBase);
			_openWindowCmd.Execute(new JumpWindowParams("PropTaskInfoWindow", list));
			break;
		case "开启":
			list.Add((PropData)_curSelectData.PropDataBase);
			_openWindowCmd.Execute(new JumpWindowParams("PropPackWindow", list));
			break;
		}
	}

	public void OnPropOpeBtnClick()
	{
		_openWindowCmd.Execute(new JumpWindowParams("PropOperationWindow"));
	}

	public async void OnBtnOpenDecomposeClick()
	{
		if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour || CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			EquipmentEnum equipmentEnum = ((CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox) ? EquipmentEnum.SuitBox : EquipmentEnum.Armour);
			List<KnapsackItemViewModel> armourItems = ArmourFilterDataUtil.BuildArmourItemsForDecomposeWindow(this, out var hasDecomposeable, CurScreenType, null, equipmentEnum);
			if (armourItems.Count <= 0 || !hasDecomposeable)
			{
				Toast.ShowInfo("当前没有可分解的装备");
				return;
			}
			ArmourFilterViewModel userData = new ArmourFilterViewModel(this, armourItems, await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetEquipmentDecomposePreferences(equipmentEnum), CurScreenType, equipmentEnum);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourFilterWindow), userData));
		}
		else
		{
			StateMode = KnapsackDefinition.WarehouseStateMode.Decompose;
		}
	}

	public void OnBtnCancelDecomposeClick()
	{
		StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
	}

	public void OnAutoSelectDecomposeClick()
	{
		foreach (KnapsackItemViewModel filterData in FilterDataList)
		{
			if (!filterData.IsActive || (ShowDecomposeScreen && filterData.Quality > (int)CurAutoDecomposeScreenType))
			{
				continue;
			}
			long id2;
			if (filterData is WarehouseItemData warehouseItemData)
			{
				if (CheckSelectedDecompose(filterData, out var _))
				{
					warehouseItemData.SelectMax();
					continue;
				}
				warehouseItemData.SelectMax();
				AddSelectedDecompose(warehouseItemData);
			}
			else if (!CheckSelectedDecompose(filterData, out id2))
			{
				filterData.IsToggleOn = true;
				AddSelectedDecompose(filterData);
			}
		}
		UpdateDecomposeProducts();
	}

	private void OnInActiveItemClickInDecompose(KnapsackItemViewModel data)
	{
		if (data.PropDataBase is EquipmentDataBase equipmentDataBase)
		{
			if (equipmentDataBase.GetOwnerId() > 0)
			{
				Toast.ShowInfo("已穿戴，无法分解");
			}
			else if (equipmentDataBase.IsLock)
			{
				Toast.ShowInfo("已锁定，无法分解");
			}
		}
		else if (data.PropDataBase is PropData propData)
		{
			if (propData.UseType.Contains(6))
			{
				Toast.ShowInfo("该角色灵冠未满，无法分解");
			}
			else
			{
				Toast.ShowInfo("该道具无法分解");
			}
		}
	}

	private void OnEquipmentClickInDecompose(KnapsackItemViewModel data)
	{
		if (!data.IsToggleOn)
		{
			AddSelectedDecompose(data);
			data.IsToggleOn = true;
		}
		else
		{
			RemoveSelectedDecompose(data);
			data.IsToggleOn = false;
		}
		ShowItemInfoWindow(data);
		UpdateFuncBtnState(data);
		UpdateDecomposeProducts();
	}

	private void OnPropClickInDecompose(WarehouseItemData data)
	{
		ShowItemInfoWindow(data);
		UpdateFuncBtnState(data);
		data.SelectMin();
		AddSelectedDecompose(data);
		UpdateDecomposeProducts();
	}

	private void OnPropCancelSelectInDecompose(WarehouseItemData data)
	{
		ShowItemInfoWindow(data);
		UpdateFuncBtnState(data);
		data.CancelSelect();
		RemoveSelectedDecompose(data);
		UpdateDecomposeProducts();
	}

	private bool CheckSelectedDecompose(KnapsackItemViewModel data, out long id)
	{
		id = 0L;
		if (data.PropDataBase is EquipmentDataBase equipmentDataBase)
		{
			id = equipmentDataBase.Uid;
		}
		else
		{
			id = data.PropDataBase.Id;
		}
		return _selectedDecomposeDatas.ContainsKey(id);
	}

	private void AddSelectedDecompose(KnapsackItemViewModel data)
	{
		if (!CheckSelectedDecompose(data, out var id))
		{
			_selectedDecomposeDatas.Add(id, data);
		}
	}

	private bool RemoveSelectedDecompose(KnapsackItemViewModel data)
	{
		if (CheckSelectedDecompose(data, out var id))
		{
			return _selectedDecomposeDatas.Remove(id);
		}
		return false;
	}

	private void UpdateDecomposeProducts()
	{
		decomposeProducts.Clear();
		if (_selectedDecomposeDatas.Count <= 0)
		{
			refreshDecomposeProducts.Raise();
			return;
		}
		List<KnapsackItemViewModel> list = _selectedDecomposeDatas.Values.ToList();
		if (list[0].PropDataBase is WeaponData)
		{
			List<WeaponData> weapons = new List<WeaponData>();
			list.ForEach(delegate(KnapsackItemViewModel p)
			{
				weapons.Add((WeaponData)p.PropDataBase);
			});
			decomposeProducts = KnapsackDefinition.GetWeaponDecomposeProducts(weapons);
		}
		else if (list[0].PropDataBase is ArmourData armourData)
		{
			List<ArmourData> armours = new List<ArmourData>();
			list.ForEach(delegate(KnapsackItemViewModel p)
			{
				armours.Add((ArmourData)p.PropDataBase);
			});
			if (armourData.EquipmentEnum == EquipmentEnum.Armour)
			{
				decomposeProducts = KnapsackDefinition.GetArmourDecomposeProducts(armours);
			}
			else if (armourData.EquipmentEnum == EquipmentEnum.SuitBox)
			{
				decomposeProducts = KnapsackDefinition.GetSuitBoxDecomposeProducts(armours);
			}
		}
		else if (list[0] is WarehouseItemData)
		{
			List<int> propIds = new List<int>();
			List<int> propCounts = new List<int>();
			list.ForEach(delegate(KnapsackItemViewModel p)
			{
				WarehouseItemData warehouseItemData = (WarehouseItemData)p;
				propIds.Add(warehouseItemData.PropDataBase.Id);
				propCounts.Add(warehouseItemData.SelectCount);
			});
			decomposeProducts = KnapsackDefinition.GetPropDecomposeProducts(propIds, propCounts);
		}
		decomposeProducts.ClearZeroAmount();
		refreshDecomposeProducts.Raise();
	}

	private void ClearDecomposeSelect()
	{
		if (_selectedDecomposeDatas == null)
		{
			return;
		}
		foreach (KnapsackItemViewModel value in _selectedDecomposeDatas.Values)
		{
			value.IsToggleOn = false;
		}
		decomposeProducts.Clear();
		_selectedDecomposeDatas.Clear();
	}

	public async void DecomposeCommand()
	{
		if (_selectedDecomposeDatas.Count <= 0)
		{
			return;
		}
		_decomposeCommand.Enabled = false;
		Loading loading = await Loading.Show();
		if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon || CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour || CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			List<long> list = new List<long>();
			foreach (KnapsackItemViewModel value in _selectedDecomposeDatas.Values)
			{
				if (value.PropDataBase is EquipmentDataBase equipmentDataBase)
				{
					list.Add(equipmentDataBase.Uid);
				}
			}
			EquipmentEnum type = EquipmentEnum.Weapon;
			if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon)
			{
				type = EquipmentEnum.Weapon;
			}
			else if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour)
			{
				type = EquipmentEnum.Armour;
			}
			else if (CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
			{
				type = EquipmentEnum.SuitBox;
			}
			RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().RequestDecomposeEquipment(list, type);
			if (rewardGetData != null)
			{
				StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
				if (rewardGetData.PropList != null && rewardGetData.PropList.Count > 0)
				{
					PropGetViewModel userData = new PropGetViewModel(this, rewardGetData.PropList);
					openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				}
			}
		}
		else
		{
			List<PropData> list2 = new List<PropData>();
			foreach (KnapsackItemViewModel value2 in _selectedDecomposeDatas.Values)
			{
				if (value2 is WarehouseItemData warehouseItemData)
				{
					list2.Add((PropData)PropDataBase.CreateByType(warehouseItemData.PropDataBase.PropTypeEnum, warehouseItemData.PropDataBase.Id, warehouseItemData.SelectCount));
				}
			}
			KeyValuePair<bool, RewardGetData> keyValuePair = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().RequestDecomposeThing(list2);
			if (keyValuePair.Key)
			{
				StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
				PropGetViewModel userData2 = new PropGetViewModel(this, keyValuePair.Value);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData2));
			}
		}
		loading?.Dispose();
		_decomposeCommand.Enabled = true;
	}

	private void OnLockChangedInDecomposeMode(OptionArg arg)
	{
		if (StateMode != KnapsackDefinition.WarehouseStateMode.Decompose)
		{
			return;
		}
		long num = 0L;
		if (arg.Obj is WeaponPopupViewModel weaponPopupViewModel && CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon)
		{
			num = weaponPopupViewModel.WeaponData?.Uid ?? 0;
		}
		else if (arg.Obj is ArmourPopupViewModel armourPopupViewModel && CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour)
		{
			num = armourPopupViewModel.ArmourData?.Uid ?? 0;
		}
		else if (arg.Obj is RockPopupViewModel rockPopupViewModel && CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			num = rockPopupViewModel.ArmourData?.Uid ?? 0;
		}
		if (num <= 0)
		{
			return;
		}
		foreach (KnapsackItemViewModel filterData in FilterDataList)
		{
			if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon)
			{
				WeaponItemData weaponItemData = (WeaponItemData)filterData;
				if (weaponItemData.Data.Uid == num && weaponItemData.IsToggleOn)
				{
					OnEquipmentClickInDecompose(weaponItemData);
					UpdateDecomposeProducts();
					weaponItemData.IsActive = false;
					break;
				}
			}
			else if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour || CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
			{
				ArmourItemData armourItemData = (ArmourItemData)filterData;
				if (armourItemData.Data.Uid == num && armourItemData.IsToggleOn)
				{
					OnEquipmentClickInDecompose(armourItemData);
					UpdateDecomposeProducts();
					armourItemData.IsActive = false;
					break;
				}
			}
		}
	}

	private void GetFilterDataList(bool autoSelect = true)
	{
		_filterDataList.Clear();
		bool flag = StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose);
		List<PropDataBase> list = new List<PropDataBase>();
		switch (CurTabType)
		{
		case KnapsackDefinition.WarehouseTabEnum.Weapon:
			foreach (WeaponData value in Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllWeaponData().Values)
			{
				list.Add(value);
			}
			break;
		case KnapsackDefinition.WarehouseTabEnum.Armour:
			foreach (ArmourData value2 in Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllArmourData().Values)
			{
				if (value2.EquipmentEnum == EquipmentEnum.Armour)
				{
					list.Add(value2);
				}
			}
			break;
		case KnapsackDefinition.WarehouseTabEnum.SuitBox:
			foreach (ArmourData value3 in Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllArmourData().Values)
			{
				if (value3.EquipmentEnum == EquipmentEnum.SuitBox)
				{
					list.Add(value3);
				}
			}
			break;
		default:
			foreach (KnapsackPropData displayProp in Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetDisplayProps(negative: true))
			{
				if (((CurTabType == KnapsackDefinition.WarehouseTabEnum.Material && CheckMaterial(displayProp)) || (CurTabType == KnapsackDefinition.WarehouseTabEnum.Consume && CheckCanUse(displayProp)) || (CurTabType == KnapsackDefinition.WarehouseTabEnum.Task && CheckTaskProp(displayProp))) && CheckDisplay(displayProp))
				{
					list.Add(displayProp);
				}
			}
			break;
		}
		if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon || CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour || CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
		{
			if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon)
			{
				SortWeaponData(list);
			}
			else if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Armour)
			{
				SortArmourData(list);
			}
			else if (CurTabType == KnapsackDefinition.WarehouseTabEnum.SuitBox)
			{
				SortSuitBoxData(list);
			}
			if (CurTabType == KnapsackDefinition.WarehouseTabEnum.Weapon)
			{
				foreach (WeaponData item in list)
				{
					int ownerId = item.GetOwnerId();
					WeaponItemData weaponItemData = new WeaponItemData(this, item, ownerId);
					weaponItemData.IsActive = !flag || item.CanDecompose();
					_filterDataList.Add(weaponItemData);
				}
			}
			else
			{
				foreach (ArmourData item2 in list)
				{
					int ownerId2 = item2.GetOwnerId();
					ArmourItemData armourItemData = new ArmourItemData(this, item2, ownerId2);
					armourItemData.IsActive = !flag || item2.CanDecompose();
					_filterDataList.Add(armourItemData);
				}
			}
		}
		else
		{
			SortNormalData(list);
			foreach (PropData item3 in list)
			{
				WarehouseItemData warehouseItemData = new WarehouseItemData(this, item3);
				warehouseItemData.IsActive = !flag || item3.CanDecompose();
				_filterDataList.Add(warehouseItemData);
			}
		}
		this.autoSelect = autoSelect;
		_refreshPropRequest.Raise();
		if (autoSelect && _filterDataList.Count > 0)
		{
			_filterDataList[0].OnClick();
		}
	}

	private void SortWeaponData(List<PropDataBase> filterDataList)
	{
		filterDataList.Sort(delegate(PropDataBase x, PropDataBase y)
		{
			WeaponData weaponData = (WeaponData)x;
			WeaponData weaponData2 = (WeaponData)y;
			int num = 0;
			int value = 0;
			bool num2 = StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose);
			if (num2)
			{
				num = (weaponData.CanDecompose() ? 1 : (-1));
				value = (weaponData2.CanDecompose() ? 1 : (-1));
			}
			int num3 = ((weaponData.GetOwnerId() > 0) ? 1 : (-1));
			int value2 = ((weaponData2.GetOwnerId() > 0) ? 1 : (-1));
			int num4 = (num2 ? (-weaponData.WeaponEnum.CompareTo(weaponData2.WeaponEnum) * 100) : (weaponData.WeaponEnum.CompareTo(weaponData2.WeaponEnum) * 100));
			int result = 0;
			switch (CurScreenType)
			{
			case KnapsackDefinition.WarehouseScreenType.Rarity:
				result = -(num.CompareTo(value) * 1000000 + num3.CompareTo(value2) * 100000 + weaponData.Rarity.CompareTo(weaponData2.Rarity) * 10000 + weaponData.Level.CompareTo(weaponData2.Level) * 1000 + num4 + weaponData.WeaponRefine.CompareTo(weaponData2.WeaponRefine) * 10 - weaponData.Id.CompareTo(weaponData2.Id));
				break;
			case KnapsackDefinition.WarehouseScreenType.Level:
				result = -(num.CompareTo(value) * 1000000 + num3.CompareTo(value2) * 100000 + weaponData.Level.CompareTo(weaponData2.Level) * 10000 + weaponData.Rarity.CompareTo(weaponData2.Rarity) * 1000 + num4 + weaponData.WeaponRefine.CompareTo(weaponData2.WeaponRefine) * 10 - weaponData.Id.CompareTo(weaponData2.Id));
				break;
			}
			return result;
		});
	}

	private void SortArmourData(List<PropDataBase> filterDataList)
	{
		filterDataList.Sort((PropDataBase x, PropDataBase y) => ArmourFilterDataUtil.CompareEquipment((ArmourData)x, (ArmourData)y, isDecomposing: StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose), screenType: CurScreenType, equipmentEnum: EquipmentEnum.Armour));
	}

	private void SortSuitBoxData(List<PropDataBase> filterDataList)
	{
		filterDataList.Sort(delegate(PropDataBase x, PropDataBase y)
		{
			ArmourData armourData = (ArmourData)x;
			ArmourData armourData2 = (ArmourData)y;
			int num = 0;
			int value = 0;
			if (StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose))
			{
				num = (armourData.CanDecompose() ? 1 : (-1));
				value = (armourData2.CanDecompose() ? 1 : (-1));
			}
			int num2 = ((armourData.GetOwnerId() > 0) ? 1 : (-1));
			int value2 = ((armourData2.GetOwnerId() > 0) ? 1 : (-1));
			int num3 = 0;
			switch (CurScreenType)
			{
			case KnapsackDefinition.WarehouseScreenType.Rarity:
				num3 = -(num.CompareTo(value) * 10000 + num2.CompareTo(value2) * 1000 + armourData.Rarity.CompareTo(armourData2.Rarity) * 100 + armourData.Rank.CompareTo(armourData2.Rank) * 10);
				break;
			case KnapsackDefinition.WarehouseScreenType.Rank:
				num3 = -(num.CompareTo(value) * 10000 + num2.CompareTo(value2) * 1000 + armourData.Rank.CompareTo(armourData2.Rank) * 100 + armourData.Rarity.CompareTo(armourData2.Rarity) * 10);
				break;
			}
			return (num3 == 0) ? ArmourFilterDataUtil.CompareSuitBoxEntryCountAndMainEntry(armourData, armourData2) : num3;
		});
	}

	private void SortNormalData(List<PropDataBase> filterDataList)
	{
		filterDataList.Sort(delegate(PropDataBase x, PropDataBase y)
		{
			PropData propData = (PropData)x;
			PropData propData2 = (PropData)y;
			int num = 0;
			int value = 0;
			if (StateMode.Equals(KnapsackDefinition.WarehouseStateMode.Decompose))
			{
				num = (propData.CanDecompose() ? 1 : (-1));
				value = (propData2.CanDecompose() ? 1 : (-1));
			}
			return -(num.CompareTo(value) * 10 + propData.Sort.CompareTo(propData2.Sort));
		});
	}

	private bool CheckDisplay(KnapsackPropData itemData)
	{
		return !itemData.UseType.Contains(16);
	}

	private bool CheckTaskProp(KnapsackPropData itemData)
	{
		return itemData.PropType == 10;
	}

	private bool CheckCanUse(KnapsackPropData itemData)
	{
		if (CheckTaskProp(itemData))
		{
			return false;
		}
		return !itemData.UseType.Contains(0);
	}

	private bool CheckMaterial(KnapsackPropData itemData)
	{
		if (CheckTaskProp(itemData))
		{
			return false;
		}
		if (itemData.UseType.Count == 1)
		{
			return itemData.UseType[0] == 0;
		}
		return false;
	}

	private void ShowItemInfoWindow(KnapsackItemViewModel data)
	{
		if (data is WeaponItemData weaponItemData)
		{
			_weaponPopupViewModel.RefreshData(weaponItemData.Data);
			openWeaponInfoViewRst.Raise(_weaponPopupViewModel);
		}
		else if (data is ArmourItemData armourItemData)
		{
			if (armourItemData.Data.EquipmentEnum == EquipmentEnum.Armour)
			{
				_armourPropViewModel.RefreshData(armourItemData.Data);
				openArmourInfoViewRst.Raise(_armourPropViewModel);
			}
			else if (armourItemData.Data.EquipmentEnum == EquipmentEnum.SuitBox)
			{
				_rockInfoViewModel.RefreshData(armourItemData.Data);
				openRockInfoViewRst.Raise(_rockInfoViewModel);
			}
		}
		else
		{
			PropData data2 = (PropData)data.PropDataBase;
			_propInfoViewModel.RefreshData(data2);
			openPropInfoViewRst.Raise(_propInfoViewModel);
		}
	}

	private void UpdateFuncBtnState(KnapsackItemViewModel data)
	{
		GameProcessType gameProcess = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess();
		if (data is WeaponItemData || data is ArmourItemData)
		{
			if (gameProcess == GameProcessType.Outer)
			{
				ShowFuncBtn = true;
				FuncBtnText = "详情";
			}
			return;
		}
		PropData propData = (PropData)data.PropDataBase;
		if (propData.UseType.Contains(10))
		{
			ShowFuncBtn = true;
			FuncBtnText = "查看";
		}
		else if (gameProcess != GameProcessType.Outer)
		{
			ShowFuncBtn = false;
		}
		else if (propData.UseType.Contains(1) || propData.UseType.Contains(17) || propData.UseType.Contains(21))
		{
			ShowFuncBtn = true;
			FuncBtnText = "使用";
		}
		else if (propData.UseType.Contains(15))
		{
			ShowFuncBtn = true;
			FuncBtnText = "开启";
		}
		else
		{
			ShowFuncBtn = false;
		}
	}

	private async void OpenWindowCommand(JumpWindowParams jumpParams)
	{
		_openWindowCmd.Enabled = false;
		switch (jumpParams.WindowName)
		{
		case "HeroWarehouseWindow":
		{
			HeroWarehouseViewModel userData4 = new HeroWarehouseViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroWarehouseWindow), userData4), delegate
			{
				Cb();
			});
			break;
		}
		case "WeaponCultureWindow":
		{
			WeaponItemData weaponItemData = (WeaponItemData)jumpParams.Args[0];
			WeaponCultureViewModel userData3 = new WeaponCultureViewModel(this, weaponItemData.Data);
			openWindowRequest.Raise(new OpenViewArg(typeof(WeaponCultureWindow), userData3), delegate
			{
				Cb();
			});
			break;
		}
		case "ArmourCultureWindow":
		{
			ArmourItemData armourItemData = (ArmourItemData)jumpParams.Args[0];
			if (armourItemData.Data.EquipmentEnum == EquipmentEnum.Armour)
			{
				int ownerId = armourItemData.Data.GetOwnerId();
				HeroModel heroModel = null;
				if (ownerId > 0)
				{
					heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
				}
				ArmourCultureViewModel userData5 = new ArmourCultureViewModel(this, armourItemData.Data, heroModel, null, needOpenDetail: true);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourCultureWindow), userData5), delegate
				{
					Cb();
				});
				break;
			}
			long unselectedUid = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetUnselectSuitBox();
			ArmourData unselectedData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(unselectedUid);
			if (unselectedUid != 0L)
			{
				Loading loading = await Loading.Show();
				bool num2 = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().EnterMakeSuitBox(unselectedUid, unselectedData.AdditionalEntryList);
				loading.Dispose();
				if (num2)
				{
					RockCultureViewModel userData6 = new RockCultureViewModel(this, armourItemData.Data);
					openWindowRequest.Raise(new OpenViewArg(typeof(RockCultureWindow), userData6), delegate
					{
						Cb();
					});
				}
				else
				{
					Toast.ShowInfo("进入护石改造界面失败");
				}
			}
			else
			{
				RockCultureViewModel userData7 = new RockCultureViewModel(this, armourItemData.Data);
				openWindowRequest.Raise(new OpenViewArg(typeof(RockCultureWindow), userData7), delegate
				{
					Cb();
				});
			}
			break;
		}
		case "PropTaskInfoWindow":
		{
			PropData propData2 = (PropData)jumpParams.Args[0];
			PropTaskInfoViewModel userData8 = new PropTaskInfoViewModel(this, propData2.Title, propData2.Illustration, propData2.Content);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropTaskInfoWindow), userData8), delegate
			{
				Cb();
			});
			break;
		}
		case "PropOperationWindow":
		{
			KnapsackDefinition.PropOperationMode mode = KnapsackDefinition.PropOperationMode.Compose;
			int propId = 0;
			if (jumpParams.Args.Count > 0 && jumpParams.Args[0] is KnapsackDefinition.PropOperationMode propOperationMode)
			{
				mode = propOperationMode;
			}
			if (jumpParams.Args.Count > 1 && jumpParams.Args[1] is int num)
			{
				propId = num;
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(PropOperationWindow), new PropOperationViewModel(this, mode, propId)), delegate
			{
				Cb();
			});
			break;
		}
		case "PropPackWindow":
		{
			PropData propData = (PropData)jumpParams.Args[0];
			if (GameEntry.DataTable.GetDataRow<DRPacks>(propData.Id) != null)
			{
				PropPackViewModel userData2 = new PropPackViewModel(this, propData.Id, propData.Amount);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropPackWindow), userData2), delegate
				{
					Cb();
				});
			}
			else
			{
				_openWindowCmd.Enabled = true;
			}
			break;
		}
		case "PlayerNameChangeWindow":
		{
			PlayerNameChangeViewModel userData = new PlayerNameChangeViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerNameChangeWindow), userData), delegate
			{
				_openWindowCmd.Enabled = true;
			});
			break;
		}
		case "ArmourCustomWindow":
		{
			int usePropId = (int)jumpParams.Args[0];
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourCustomWindow), new ArmourCustomViewModel(this, usePropId)), delegate
			{
				Cb();
			});
			break;
		}
		}
		StateMode = KnapsackDefinition.WarehouseStateMode.Normal;
		void Cb()
		{
			GetFilterDataList();
			_openWindowCmd.Enabled = true;
		}
	}

	private async void OpenPack(PropData packItem)
	{
		RewardThings rewardThings = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().OpenPackRequest(packItem.Id, 1, new List<int>());
		if (rewardThings != null)
		{
			PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
			{
				GetFilterDataList();
				_openWindowCmd.Enabled = true;
			});
		}
	}

	public void TryOpenExpiredWindow()
	{
		List<KnapsackPropData> list = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.ExpiredPropList.Values.ToList();
		if (list == null || list.Count <= 0)
		{
			return;
		}
		List<PropDataBase> list2 = new List<PropDataBase>();
		foreach (KnapsackPropData item in list)
		{
			list2.Add(item);
		}
		openWindowRequest.Raise(new OpenViewArg(typeof(PropExpiredWindow), new PropExpiredViewModel(this, list2)));
		Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.ClearExpiredDataList();
		Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.SetExpiredPropShowed();
	}
}
