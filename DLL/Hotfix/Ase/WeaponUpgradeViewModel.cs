using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class WeaponUpgradeViewModel : OptionBase
{
	private List<EquipExpItemDataNew> _equipExpItemDataNews;

	private WeaponData _weaponData;

	private IEquipmentService _equipmentService;

	private KnapsackViewModel _knapsackViewModel;

	private InteractionRequest _refreshShowDataRequest;

	private InteractionRequest _refreshInfoRequest;

	private MoneyData _moneyData;

	private int _curSortType = 1;

	private string _curSortName;

	private int _expPool;

	private float _coinNeed;

	private string _showCoin;

	private List<ItemResult> _itemChange;

	private List<long> _equipChange;

	private string _weaponEnumName;

	private float _curExpProgress;

	private float _preExpProgress;

	private int _addLevel;

	private string _showExp;

	private string _showAddLevel;

	private string _showAddExp;

	private int expLeft;

	private List<KnapsackPropData> _propReturn;

	private List<AttributeUpgradeItemData> _attributeUpgradeItemDatas;

	private WeaponPopupViewModel weaponPopupViewModel;

	private PropWindowViewModel propInfoViewModel;

	private bool _isMax;

	public Dictionary<int, string> SortTypeEnum = new Dictionary<int, string>
	{
		[1] = "默认排序",
		[2] = "稀有度排序",
		[3] = "等级排序"
	};

	private int autoSelectRarity;

	private string autoSelectText;

	private Dictionary<int, string> RarityLimit = new Dictionary<int, string>
	{
		[1] = "绿色",
		[2] = "蓝色及以下",
		[3] = "紫色及以下"
	};

	private List<TabItemNormalData> rarityLimitItemDataList;

	private TabItemNormalData curLimitItemData;

	private TabItemNormalData selectLimitItemData;

	private bool showRarityLimitView;

	private TabItemNormalData autoSelectData;

	private SimpleCommand upgradeCmd;

	private EquipExpItemDataNew _equipExpItemDataNew;

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

	public List<AttributeUpgradeItemData> AttributeUpgradeItemDatas
	{
		get
		{
			return _attributeUpgradeItemDatas;
		}
		private set
		{
			Set(ref _attributeUpgradeItemDatas, value, "AttributeUpgradeItemDatas");
		}
	}

	public List<EquipExpItemDataNew> EquipExpItemDataNews
	{
		get
		{
			return _equipExpItemDataNews;
		}
		private set
		{
			Set(ref _equipExpItemDataNews, value, "EquipExpItemDataNews");
		}
	}

	public string ShowCoin
	{
		get
		{
			return _showCoin;
		}
		private set
		{
			Set(ref _showCoin, value, "ShowCoin");
		}
	}

	public MoneyData MoneyData
	{
		get
		{
			return _moneyData;
		}
		private set
		{
			Set(ref _moneyData, value, "MoneyData");
		}
	}

	public int CurSortType
	{
		get
		{
			return _curSortType;
		}
		set
		{
			Set(ref _curSortType, value, "CurSortType");
			CurSortName = SortTypeEnum[_curSortType];
		}
	}

	public string CurSortName
	{
		get
		{
			return _curSortName;
		}
		set
		{
			Set(ref _curSortName, value, "CurSortName");
		}
	}

	public List<ItemResult> ItemChange
	{
		get
		{
			return _itemChange;
		}
		set
		{
			Set(ref _itemChange, value, "ItemChange");
		}
	}

	public List<long> EquipChange
	{
		get
		{
			return _equipChange;
		}
		set
		{
			Set(ref _equipChange, value, "EquipChange");
		}
	}

	public string WeaponEnumName
	{
		get
		{
			return _weaponEnumName;
		}
		set
		{
			Set(ref _weaponEnumName, value, "WeaponEnumName");
		}
	}

	public int AddLevel
	{
		get
		{
			return _addLevel;
		}
		set
		{
			Set(ref _addLevel, value, "AddLevel");
			ShowAddLevel = ((value > 0) ? $"+{value}" : "");
			IsMax = WeaponData.Level + value == WeaponData.MaxLevel;
		}
	}

	public string ShowAddLevel
	{
		get
		{
			return _showAddLevel;
		}
		set
		{
			Set(ref _showAddLevel, value, "ShowAddLevel");
		}
	}

	public string ShowExp
	{
		get
		{
			return _showExp;
		}
		set
		{
			Set(ref _showExp, value, "ShowExp");
		}
	}

	public int ExpPool
	{
		get
		{
			return _expPool;
		}
		set
		{
			Set(ref _expPool, value, "ExpPool");
			ShowAddExp = ((value > 0) ? $"+{value}" : "");
		}
	}

	public float CoinNeed
	{
		get
		{
			return _coinNeed;
		}
		set
		{
			value = ((value < 0f) ? 0f : value);
			Set(ref _coinNeed, value, "CoinNeed");
			ShowCoin = ((value > (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin)) ? $"<color=#fd624e>{value}</color>" : $"{value}");
			UpgradeCmd.Enabled = (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin) >= value;
		}
	}

	public string ShowAddExp
	{
		get
		{
			return _showAddExp;
		}
		set
		{
			Set(ref _showAddExp, value, "ShowAddExp");
		}
	}

	public bool IsMax
	{
		get
		{
			return _isMax;
		}
		set
		{
			Set(ref _isMax, value, "IsMax");
		}
	}

	public float CurExpProgress
	{
		get
		{
			return _curExpProgress;
		}
		private set
		{
			Set(ref _curExpProgress, value, "CurExpProgress");
		}
	}

	public float PreExpProgress
	{
		get
		{
			return _preExpProgress;
		}
		private set
		{
			Set(ref _preExpProgress, value, "PreExpProgress");
		}
	}

	public string AutoSelectText
	{
		get
		{
			return autoSelectText;
		}
		private set
		{
			Set(ref autoSelectText, value, "AutoSelectText");
		}
	}

	public bool ShowRarityLimitView
	{
		get
		{
			return showRarityLimitView;
		}
		private set
		{
			Set(ref showRarityLimitView, value, "ShowRarityLimitView");
		}
	}

	public int AutoSelectRarity
	{
		get
		{
			return autoSelectRarity;
		}
		set
		{
			Set(ref autoSelectRarity, value, "AutoSelectRarity");
			AutoSelectText = RarityLimit[autoSelectRarity];
		}
	}

	public TabItemNormalData AutoSelectData => autoSelectData;

	public List<TabItemNormalData> RarityLimitItemDataList => rarityLimitItemDataList;

	public TabItemNormalData SelectLimitItemData => selectLimitItemData;

	public InteractionRequest RefreshInfoRequest => _refreshInfoRequest;

	public InteractionRequest RefreshShowDataRequest => _refreshShowDataRequest;

	public SimpleCommand UpgradeCmd => upgradeCmd;

	public WeaponUpgradeViewModel(OptionBase parent, WeaponData weaponData, MoneyData moneyData)
	{
		base.parent = parent;
		_weaponData = weaponData;
		_equipExpItemDataNews = new List<EquipExpItemDataNew>();
		_refreshShowDataRequest = new InteractionRequest();
		_moneyData = moneyData;
		_knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		_expPool = 0;
		_coinNeed = 0f;
		_weaponEnumName = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
		_attributeUpgradeItemDatas = new List<AttributeUpgradeItemData>();
		_refreshInfoRequest = new InteractionRequest();
		_itemChange = new List<ItemResult>();
		_equipChange = new List<long>();
		_curExpProgress = (float)weaponData.Exp / (float)weaponData.MaxExp;
		_preExpProgress = 0f;
		_propReturn = new List<KnapsackPropData>();
		selectLimitItemData = new TabItemNormalData("", 0, this);
		upgradeCmd = new SimpleCommand(UpgradeOnClick);
		selectLimitItemData.SetCanOnClick(value: true);
		LoadExpItem();
		RefreshSortEquipExpItems(1);
		InitRarityLimitItemDataList();
		autoSelectData = new TabItemNormalData(this, "empty", -1, isSelected: false, "自动选择");
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is EquipExpItemDataNew equipExpItemDataNew)
		{
			EquipExpItemOnClick(equipExpItemDataNew);
			_equipExpItemDataNew = equipExpItemDataNew;
			equipExpItemDataNew.ActionName = "";
		}
		else if (obj is int num)
		{
			CurSortType = num;
			RefreshSortEquipExpItems(num);
		}
		else if (obj is WeaponPopupViewModel weaponPopupViewModel)
		{
			if (weaponPopupViewModel.WeaponData.IsLock && _equipExpItemDataNew.IsSelected)
			{
				EquipExpItemOnClick(_equipExpItemDataNew);
			}
			_equipExpItemDataNew.ChangeLock();
		}
		else if (obj is OptionArg optionArg)
		{
			if ("Close".Equals(optionArg.OptionName))
			{
				this.weaponPopupViewModel = null;
			}
		}
		else if (obj is PropWindowViewModel)
		{
			propInfoViewModel = null;
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			if (tabItemNormalData.ID == 0)
			{
				OpenRarityLimitView();
			}
			else if (tabItemNormalData.ID == -1)
			{
				AutoSelectOnClick();
			}
			else
			{
				SetRarityLimitData(tabItemNormalData);
			}
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		if (arg == null || (!(arg.Obj is PropWindowViewModel) && !(arg.Obj is WeaponPopupViewModel) && !(arg.Obj is ExpPropReturnViewModel)))
		{
			RefreshAll();
		}
	}

	public void RefreshAll()
	{
		LoadExpItem();
		ClearExpItem();
		CloseProp();
	}

	private void InitRarityLimitItemDataList()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		AutoSelectRarity = PlayerPrefs.GetInt($"_{uid}_weaponUpgrade_rarity", 1);
		rarityLimitItemDataList = new List<TabItemNormalData>();
		foreach (KeyValuePair<int, string> item in RarityLimit)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(item.Value, item.Key, this);
			tabItemNormalData.SetCanOnClick(value: true);
			rarityLimitItemDataList.Add(tabItemNormalData);
		}
		foreach (TabItemNormalData rarityLimitItemData in rarityLimitItemDataList)
		{
			if (rarityLimitItemData.ID == AutoSelectRarity)
			{
				SetRarityLimitData(rarityLimitItemData);
				break;
			}
		}
	}

	private void AutoSelectOnClick()
	{
		if (autoSelectData.IsSelected)
		{
			ClearExpItem();
			return;
		}
		if (IsMax)
		{
			Toast.ShowInfo("已达到最大等级");
		}
		else if (!AutoSelect())
		{
			Toast.ShowInfo("暂无满足条件的道具");
			return;
		}
		autoSelectData.Text = "全部清除";
		autoSelectData.IsSelected = true;
	}

	public void ClearExpItem()
	{
		foreach (EquipExpItemDataNew item in EquipExpItemDataNews)
		{
			if (item.ItemType == 1 && item.SelectedNum > 0)
			{
				ExpPool -= item.ProvideExp * item.SelectedNum;
				item.ClearNum();
			}
			else if (item.ItemType == 2 && item.IsSelected)
			{
				ExpPool -= item.ProvideExp;
				item.ClearNum();
			}
		}
		autoSelectData.IsSelected = false;
		autoSelectData.Text = "自动选择";
		GetTargetData();
	}

	private void SetRarityLimitData(TabItemNormalData tabItemNormalData)
	{
		curLimitItemData?.SetSelected(value: false);
		curLimitItemData = tabItemNormalData;
		curLimitItemData.SetSelected(value: true);
		AutoSelectRarity = tabItemNormalData.ID;
		CloseRarityLimitView();
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		PlayerPrefs.SetInt($"_{uid}_weaponUpgrade_rarity", AutoSelectRarity);
		selectLimitItemData.Text = tabItemNormalData.Text;
	}

	public void OpenRarityLimitView()
	{
		selectLimitItemData.IsSelected = true;
		ShowRarityLimitView = true;
	}

	public void CloseRarityLimitView()
	{
		selectLimitItemData.IsSelected = false;
		ShowRarityLimitView = false;
	}

	public void CloseProp()
	{
		CloseWeaponView();
		ClosePropView();
	}

	private void CloseWeaponView()
	{
		if (weaponPopupViewModel != null)
		{
			weaponPopupViewModel.Close();
			weaponPopupViewModel = null;
		}
	}

	private void ClosePropView()
	{
		if (propInfoViewModel != null)
		{
			propInfoViewModel.Close();
			propInfoViewModel = null;
		}
	}

	private void OpenProp(EquipExpItemDataNew itemData)
	{
		if (itemData.ItemType == 1)
		{
			CloseWeaponView();
			if (propInfoViewModel == null)
			{
				propInfoViewModel = new PropWindowViewModel(this, showOutsideMask: false, showOwnCount: true, allowSkipWindow: true, showOutsideMask2: true);
				propInfoViewModel.SetPosition(new Vector2(230f, 18f));
			}
			propInfoViewModel.RefreshData(itemData.PropData);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropPopupWindow), propInfoViewModel));
		}
		else if (itemData.ItemType == 2)
		{
			ClosePropView();
			if (weaponPopupViewModel == null)
			{
				weaponPopupViewModel = new WeaponPopupViewModel(this, itemData.WeaponData, showHeroInfo: false, 230f, 18f);
				openWindowRequest.Raise(new OpenViewArg(typeof(WeaponPopupWindow), weaponPopupViewModel));
			}
			else
			{
				weaponPopupViewModel.RefreshData(itemData.WeaponData);
			}
		}
	}

	private void UpgradeOnClick()
	{
		upgradeCmd.Enabled = false;
		ItemChange.Clear();
		EquipChange.Clear();
		foreach (EquipExpItemDataNew item in EquipExpItemDataNews)
		{
			if (item.ItemType == 1)
			{
				ItemChange.Add(new ItemResult
				{
					itemType = 1,
					itemId = item.PropData.Id,
					itemCount = item.SelectedNum
				});
			}
			else if (item.SelectedNum == 1)
			{
				EquipChange.Add(item.WeaponData.Uid);
			}
		}
		if (ExpPool == 0)
		{
			Toast.ShowInfo("请选择升级材料!");
			return;
		}
		if (CoinNeed > (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin))
		{
			Toast.ShowInfo("金币不足!");
			return;
		}
		LoadExpItemLeft(expLeft);
		if (_propReturn.Count > 0)
		{
			ExpPropReturnViewModel returnViewModel = new ExpPropReturnViewModel(this, _propReturn);
			openWindowRequest.Raise(new OpenViewArg(typeof(ExpPropReturnWindow), returnViewModel), delegate
			{
				if (returnViewModel.result)
				{
					UpLevel();
				}
				upgradeCmd.Enabled = true;
			});
		}
		else
		{
			UpLevel();
		}
	}

	private async void UpLevel()
	{
		int oldLevel = WeaponData.Level;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().EquipUpgrade(WeaponData, ItemChange, EquipChange, (int)CoinNeed);
		loading.Dispose();
		if (!num)
		{
			await UIHelper.AccountDisconnect();
		}
		else
		{
			ExpPool = 0;
			LoadExpItem();
			WeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(WeaponData.Uid);
			if (oldLevel < WeaponData.Level)
			{
				WeaponSuccessViewModel userData = new WeaponSuccessViewModel(WeaponData, WeaponUpMode.Upgrade, oldLevel);
				openWindowRequest.Raise(new OpenViewArg(typeof(WeaponSuccessView), userData), delegate
				{
					if (_propReturn.Count > 0)
					{
						PropGetViewModel userData2 = new PropGetViewModel(this, _propReturn);
						openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData2), delegate
						{
						});
						_propReturn.Clear();
					}
					parent?.ItemOnClick(this);
				});
			}
			ClearExpItem();
		}
		upgradeCmd.Enabled = true;
	}

	private async void EquipExpItemOnClick(EquipExpItemDataNew itemData)
	{
		if (itemData.ItemType == 2)
		{
			if (itemData.IsSelected)
			{
				CloseProp();
			}
			else
			{
				OpenProp(itemData);
			}
		}
		if (itemData.ItemType == 1 && !itemData.ActionName.Equals("PropRemove"))
		{
			if (itemData.IsSelected && propInfoViewModel != null)
			{
				if (itemData.PropData.Id != propInfoViewModel.Data.Id)
				{
					OpenProp(itemData);
				}
			}
			else
			{
				OpenProp(itemData);
			}
		}
		if (itemData.IsLock)
		{
			Toast.ShowInfo("武魂已锁定,需先解锁才能作为素材消耗");
			return;
		}
		if (itemData.ActionName.Equals("PropRemove"))
		{
			ExpPool -= itemData.ProvideExp;
			if (itemData.SelectedNum == 0)
			{
				ClosePropView();
			}
		}
		else if (IsMax)
		{
			if (itemData.ItemType == 1 || !itemData.IsSelected)
			{
				await Task.Delay(100);
				Toast.ShowInfo("已达到最大等级");
				return;
			}
			itemData.SetOnClick();
		}
		else
		{
			itemData.SetOnClick();
		}
		if (itemData.ActionName.Equals("PropAdd"))
		{
			ExpPool += itemData.ProvideExp;
		}
		else if (itemData.ActionName.Equals("EquipRemove"))
		{
			ExpPool -= itemData.ProvideExp;
		}
		else if (itemData.ActionName.Equals("EquipAdd"))
		{
			ExpPool += itemData.ProvideExp;
		}
		GetTargetData();
	}

	public void GetTargetData()
	{
		int num = ExpPool + WeaponData.Exp;
		int num2 = WeaponData.Level;
		int num3 = WeaponData.MaxExp;
		while (true)
		{
			if (num >= num3 && num2 < WeaponData.MaxLevel)
			{
				num -= num3;
				num2++;
				int weaponNeedGold = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, num2 + 1);
				if (weaponNeedGold != 0)
				{
					num3 = weaponNeedGold;
				}
			}
			else
			{
				if (num >= 0)
				{
					break;
				}
				num2--;
				num3 = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, num2 + 1);
				num += num3;
			}
		}
		expLeft = 0;
		if (num2 >= WeaponData.MaxLevel)
		{
			expLeft = num;
		}
		ShowExp = $"{WeaponData.Exp}/{WeaponData.MaxExp}";
		AddLevel = num2 - WeaponData.Level;
		CurExpProgress = (float)WeaponData.Exp / (float)WeaponData.MaxExp;
		PreExpProgress = ((_addLevel > 0) ? 1f : ((float)num / (float)num3));
		SetCoin(AddLevel, ExpPool);
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(WeaponData.Id);
		AttributeUpgradeItemDatas.Clear();
		if (dataRow != null)
		{
			for (int i = 0; i < WeaponData.EquipAttributeList.Count; i++)
			{
				float value = WeaponData.EquipAttributeList[i].BaseValue + (float)dataRow.AttributeGrow[i][WeaponData.Star] / 10000f * (float)AddLevel;
				AttributeUpgradeItemDatas.Add(new AttributeUpgradeItemData(WeaponData.EquipAttributeList[i], value));
			}
		}
		_refreshInfoRequest.Raise();
	}

	private void SetCoin(int addLevel, float exp)
	{
		CoinNeed = 0f;
		float num = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, WeaponData.Level + 1);
		float num2 = WeaponData.GetWeaponNeedExp(WeaponData.Rarity, WeaponData.Level + 1);
		float num3 = ((addLevel > 0) ? (num2 - (float)WeaponData.Exp) : exp);
		CoinNeed += num3 * num / num2;
		exp -= (float)(int)num3;
		if (addLevel < 0)
		{
			CoinNeed = (int)Math.Ceiling(CoinNeed);
			return;
		}
		for (int i = 2; i < addLevel; i++)
		{
			int weaponNeedGold = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, i + WeaponData.Level);
			exp -= (float)WeaponData.GetWeaponNeedExp(WeaponData.Rarity, i + WeaponData.Level);
			CoinNeed += weaponNeedGold;
		}
		if (addLevel == 1 && IsMax)
		{
			CoinNeed = (int)Math.Ceiling(CoinNeed);
			return;
		}
		float num4 = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, WeaponData.Level + addLevel);
		float num5 = WeaponData.GetWeaponNeedExp(WeaponData.Rarity, WeaponData.Level + addLevel);
		float num6 = (IsMax ? num5 : exp);
		if (num5 > 0f)
		{
			CoinNeed += num6 * num4 / num5;
		}
		CoinNeed = (int)Math.Ceiling(CoinNeed);
	}

	private void LoadExpItemLeft(int exp)
	{
		_propReturn.Clear();
		List<int> list = new List<int>();
		DRProp[] allDataRows = GameEntry.DataTable.GetDataTable<DRProp>().GetAllDataRows();
		foreach (DRProp dRProp in allDataRows)
		{
			foreach (int item in dRProp.UseType)
			{
				if (item == 9)
				{
					list.Add(dRProp.Id);
					break;
				}
			}
		}
		list.Sort((int a, int b) => -a.CompareTo(b));
		for (int num = 0; num < list.Count; num++)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataTable<DRProp>().GetDataRow(list[num]);
			int num2 = exp / dataRow.EX1;
			if (num2 > 0)
			{
				_propReturn.Add(KnapsackPropData.Create(list[num], num2));
			}
			exp -= dataRow.EX1 * num2;
		}
	}

	private bool AutoSelect()
	{
		int num = 0;
		int num2 = WeaponData.Level;
		int num3 = 0;
		while (num2 != WeaponData.MaxLevel)
		{
			num2++;
			int weaponNeedGold = WeaponData.GetWeaponNeedGold(WeaponData.Rarity, num2);
			num += weaponNeedGold;
		}
		num -= WeaponData.Exp;
		num -= ExpPool;
		List<EquipExpItemDataNew> list = new List<EquipExpItemDataNew>();
		foreach (EquipExpItemDataNew item in EquipExpItemDataNews)
		{
			if (item.ItemType == 1 && item.Rarity <= AutoSelectRarity)
			{
				list.Add(item);
			}
			else if (item.ItemType == 2 && item.Level == item.WeaponData.LvInit && item.Rarity <= AutoSelectRarity && !item.IsLock && item.SelectedNum == 0)
			{
				list.Add(item);
			}
		}
		list.Sort(new EquipExpItemNewSortByAutoSelected());
		for (int i = 0; i < list.Count; i++)
		{
			int num4 = 0;
			if (num <= list[i].GetProvideExpLeft())
			{
				num4 = num / list[i].ProvideExp;
				if (num % list[i].ProvideExp > 0)
				{
					num4++;
				}
				int num5 = AutoSelectExpItem(num4, list[i]);
				num -= num5;
			}
			else
			{
				num4 = list[i].GetNum();
				int num6 = AutoSelectExpItem(num4, list[i]);
				num -= num6;
			}
			num3 += num4;
			if (num <= 0)
			{
				break;
			}
		}
		GetTargetData();
		return num3 > 0;
	}

	private int AutoSelectExpItem(int num, EquipExpItemDataNew item)
	{
		item.SetSelected(num);
		ExpPool += item.ProvideExp * num;
		return item.ProvideExp * num;
	}

	public void LoadExpItem()
	{
		EquipExpItemDataNews.Clear();
		Dictionary<long, WeaponData> allWeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllWeaponData();
		Dictionary<long, int> heroHeldEquip = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroHeldEquip();
		foreach (KeyValuePair<long, WeaponData> item in allWeaponData)
		{
			if (!heroHeldEquip.ContainsKey(item.Key) && item.Key != WeaponData.Uid)
			{
				EquipExpItemDataNews.Add(new EquipExpItemDataNew(this, item.Value));
			}
		}
		foreach (KnapsackPropData displayProp in _knapsackViewModel.GetDisplayProps())
		{
			if (displayProp == null)
			{
				continue;
			}
			for (int i = 0; i < displayProp.UseType.Count; i++)
			{
				if (displayProp.UseType[i] == 3)
				{
					EquipExpItemDataNews.Add(new EquipExpItemDataNew(this, displayProp));
				}
			}
		}
		RefreshSortEquipExpItems(CurSortType);
		ExpPool = 0;
		GetTargetData();
		_refreshShowDataRequest.Raise();
	}

	private void RefreshSortEquipExpItems(int index)
	{
		switch (index)
		{
		case 1:
			EquipExpItemDataNews.Sort(new WeaponExpItemSortByProvide());
			break;
		case 2:
			EquipExpItemDataNews.Sort(new WeaponExpItemSortByRarity());
			break;
		case 3:
			EquipExpItemDataNews.Sort(new WeaponExpItemSortByLevel());
			break;
		}
		_refreshShowDataRequest.Raise();
	}

	public void RefreshData(WeaponData weaponData)
	{
		WeaponData = weaponData;
	}
}
