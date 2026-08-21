using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ArmourUpgradeViewModel : OptionBase
{
	private ArmourData _armourData;

	private AttributeUpgradeItemData attributeUpgradeItemData;

	private List<AttributeUpgradeItemData> attributeItemDataList;

	private InteractionRequest<EntryItem> _showEntryDetailRequest;

	private IEquipmentService _equipmentService;

	private bool _isMax;

	private bool isRealMax;

	private MoneyData _moneyData;

	private InteractionRequest _refreshInfoRequest;

	public string ActionName = "";

	private int addLevel;

	private string addLevelText;

	private int expPool;

	private string addExpText;

	private string curExpText;

	private float curExpFillAmount;

	private float preExpFillAmount;

	private int upLevelMax;

	private string settingText;

	private string settingBtnText;

	private string autoSelectBtnText;

	private int autoSelectRarity;

	private int upLimit;

	private bool isOpenUpLimit;

	private bool isAutoSelect;

	private List<ItemResult> itemChange;

	private List<long> armourChange;

	private int expLeft;

	private List<KnapsackPropData> propReturn;

	private string showCoin;

	private float coinNeed;

	private int curSortType;

	private string curSortName;

	public Dictionary<int, string> SortTypeEnum = new Dictionary<int, string>
	{
		[1] = "默认排序",
		[2] = "稀有度排序",
		[3] = "等级排序"
	};

	private EquipExpItemDataNew curEquipExpItemData;

	private List<EquipExpItemDataNew> equipExpItemDataList;

	private ArmourPopupViewModel armourPopupViewModel;

	private PropWindowViewModel propInfoViewModel;

	private KnapsackViewModel knapsackViewModel;

	private InteractionRequest refreshExpItemListRequest;

	public ArmourData ArmourData
	{
		get
		{
			return _armourData;
		}
		private set
		{
			Set(ref _armourData, value, "ArmourData");
		}
	}

	public AttributeUpgradeItemData AttributeUpgradeItemData
	{
		get
		{
			return attributeUpgradeItemData;
		}
		private set
		{
			Set(ref attributeUpgradeItemData, value, "AttributeUpgradeItemData");
		}
	}

	public List<AttributeUpgradeItemData> AttributeItemDataList
	{
		get
		{
			return attributeItemDataList;
		}
		private set
		{
			Set(ref attributeItemDataList, value, "AttributeItemDataList");
		}
	}

	public string ShowCoin
	{
		get
		{
			return showCoin;
		}
		private set
		{
			Set(ref showCoin, value, "ShowCoin");
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

	private int ExpPool
	{
		get
		{
			return expPool;
		}
		set
		{
			Set(ref expPool, value, "ExpPool");
			AddExpText = ((value > 0) ? $"+{value}" : "");
		}
	}

	public List<EquipExpItemDataNew> EquipExpItemDataList
	{
		get
		{
			return equipExpItemDataList;
		}
		set
		{
			Set(ref equipExpItemDataList, value, "EquipExpItemDataList");
		}
	}

	public List<ItemResult> ItemChange
	{
		get
		{
			return itemChange;
		}
		set
		{
			Set(ref itemChange, value, "ItemChange");
		}
	}

	public List<long> ArmourChange
	{
		get
		{
			return armourChange;
		}
		set
		{
			Set(ref armourChange, value, "ArmourChange");
		}
	}

	public int CurSortType
	{
		get
		{
			return curSortType;
		}
		set
		{
			Set(ref curSortType, value, "CurSortType");
			CurSortName = SortTypeEnum[curSortType];
		}
	}

	public string CurSortName
	{
		get
		{
			return curSortName;
		}
		set
		{
			Set(ref curSortName, value, "CurSortName");
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

	public bool IsRealMax
	{
		get
		{
			return isRealMax;
		}
		set
		{
			Set(ref isRealMax, value, "IsRealMax");
		}
	}

	public float CoinNeed
	{
		get
		{
			return coinNeed;
		}
		set
		{
			value = ((value < 0f) ? 0f : value);
			Set(ref coinNeed, value, "CoinNeed");
			ShowCoin = ((value > (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin)) ? $"<color=#fd624e>{value}</color>" : $"{value}");
		}
	}

	public int AddLevel
	{
		get
		{
			return addLevel;
		}
		private set
		{
			Set(ref addLevel, value, "AddLevel");
			AddLevelText = ((value > 0) ? $"<color=#fd624e>+{value}</color>" : "");
			IsMax = ArmourData.Level + value == ArmourData.MaxLevel;
		}
	}

	public string AddLevelText
	{
		get
		{
			return addLevelText;
		}
		private set
		{
			Set(ref addLevelText, value, "AddLevelText");
		}
	}

	public string AddExpText
	{
		get
		{
			return addExpText;
		}
		private set
		{
			Set(ref addExpText, value, "AddExpText");
		}
	}

	public string CurExpText
	{
		get
		{
			return curExpText;
		}
		private set
		{
			Set(ref curExpText, value, "CurExpText");
		}
	}

	public float CurExpFillAmount
	{
		get
		{
			return curExpFillAmount;
		}
		private set
		{
			Set(ref curExpFillAmount, value, "CurExpFillAmount");
		}
	}

	public float PreExpFillAmount
	{
		get
		{
			return preExpFillAmount;
		}
		private set
		{
			Set(ref preExpFillAmount, value, "PreExpFillAmount");
		}
	}

	public bool IsOpenUpLimit
	{
		get
		{
			return isOpenUpLimit;
		}
		private set
		{
			Set(ref isOpenUpLimit, value, "IsOpenUpLimit");
		}
	}

	public string SettingText
	{
		get
		{
			return settingText;
		}
		private set
		{
			Set(ref settingText, value, "SettingText");
		}
	}

	public string SettingBtnText
	{
		get
		{
			return settingBtnText;
		}
		private set
		{
			Set(ref settingBtnText, value, "SettingBtnText");
		}
	}

	public string AutoSelectBtnText
	{
		get
		{
			return autoSelectBtnText;
		}
		private set
		{
			Set(ref autoSelectBtnText, value, "AutoSelectBtnText");
		}
	}

	public InteractionRequest RefreshInfoRequest => _refreshInfoRequest;

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public InteractionRequest RefreshExpItemListRequest => refreshExpItemListRequest;

	public ArmourUpgradeViewModel(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		_armourData = armourData;
		_moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		attributeItemDataList = new List<AttributeUpgradeItemData>();
		_refreshInfoRequest = new InteractionRequest();
		_showEntryDetailRequest = new InteractionRequest<EntryItem>();
		refreshExpItemListRequest = new InteractionRequest();
		equipExpItemDataList = new List<EquipExpItemDataNew>();
		itemChange = new List<ItemResult>();
		armourChange = new List<long>();
		propReturn = new List<KnapsackPropData>();
		IsMax = ArmourData.Level == ArmourData.MaxLevel;
		IsRealMax = ArmourData.Level == ArmourData.MaxLevel;
		RefreshAutoRule();
		LoadExpItem();
		CoinNeed = 0f;
		ExpPool = 0;
		GetTargetData();
		RefreshSortEquipExpItems(1);
		SetAutoSelect(value: true);
	}

	public void OpenDecompose()
	{
		parent?.ItemOnClick(new OptionArg(null, "OpenArmourFilterWindow"));
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is ArmourPopupViewModel armourPopupViewModel)
			{
				if (optionArg.OptionName.Equals("ChangeLock"))
				{
					if (armourPopupViewModel.ArmourData.IsLock && curEquipExpItemData.IsSelected)
					{
						EquipExpItemOnClick(curEquipExpItemData);
					}
					curEquipExpItemData.ChangeLock();
				}
				else if (optionArg.OptionName.Equals("Close"))
				{
					this.armourPopupViewModel = null;
				}
			}
			else if (optionArg.Obj is PropOperationViewModel && optionArg.OptionName == "PropOperated")
			{
				LoadExpItem();
			}
		}
		else if (obj is EquipExpItemDataNew equipExpItemDataNew)
		{
			EquipExpItemOnClick(equipExpItemDataNew);
			curEquipExpItemData = equipExpItemDataNew;
			equipExpItemDataNew.ActionName = "";
		}
		else if (obj is ArmourAutoSelectRuleViewModel)
		{
			RefreshAutoRule();
		}
		else if (obj is int num)
		{
			CurSortType = num;
			RefreshSortEquipExpItems(num);
		}
		else if (obj is PropWindowViewModel)
		{
			propInfoViewModel = null;
		}
		else if (obj is ArmourPopupViewModel)
		{
			this.armourPopupViewModel = null;
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		if (arg == null || (!(arg.Obj is PropWindowViewModel) && !(arg.Obj is ArmourPopupViewModel) && !(arg.Obj is ExpPropReturnViewModel) && !(arg.Obj is ArmourAutoSelectRuleViewModel)))
		{
			LoadExpItem();
			AllDelete();
		}
	}

	private void RefreshAutoRule()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		autoSelectRarity = PlayerPrefs.GetInt($"_{uid}_armourUpgrade_rarity", 1);
		upLimit = PlayerPrefs.GetInt($"_{uid}_armourUpgrade_upLimit", 0);
		IsOpenUpLimit = upLimit == 1;
		CheckUpLevelMax();
	}

	public void OpenArmourSelectRuleWindow()
	{
		ArmourAutoSelectRuleViewModel userData = new ArmourAutoSelectRuleViewModel(this, autoSelectRarity, upLimit);
		OpenViewArg obj = new OpenViewArg(typeof(ArmourAutoSelectRuleWindow), userData);
		parent?.ItemOnClick(obj);
	}

	private async void EquipExpItemOnClick(EquipExpItemDataNew itemData)
	{
		if (itemData.ItemType == 3)
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
			Toast.ShowInfo("明饰已锁定,需先解锁才能作为素材消耗");
			return;
		}
		if (itemData.ActionName.Equals("PropRemove"))
		{
			ExpPool -= itemData.ProvideExp;
			if (itemData.SelectedNum == 0)
			{
				ClosePropView();
			}
			if (ExpPool <= 0)
			{
				SetAutoSelect(value: true);
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
			if (ExpPool <= 0)
			{
				SetAutoSelect(value: true);
			}
		}
		else if (itemData.ActionName.Equals("EquipAdd"))
		{
			ExpPool += itemData.ProvideExp;
		}
		GetTargetData();
	}

	private void LoadExpItem()
	{
		EquipExpItemDataList.Clear();
		Dictionary<long, ArmourData> allArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetAllArmourData();
		Dictionary<long, int> heroHeldEquip = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroHeldEquip();
		foreach (KeyValuePair<long, ArmourData> item in allArmourData)
		{
			if (!heroHeldEquip.ContainsKey(item.Key) && item.Key != ArmourData.Uid && item.Value.ArmourEnum != ArmourEnum.Rock)
			{
				EquipExpItemDataList.Add(new EquipExpItemDataNew(this, item.Value));
			}
		}
		foreach (KnapsackPropData displayProp in knapsackViewModel.GetDisplayProps())
		{
			if (displayProp == null)
			{
				continue;
			}
			for (int i = 0; i < displayProp.UseType.Count; i++)
			{
				if (displayProp.UseType[i] == 2)
				{
					EquipExpItemDataList.Add(new EquipExpItemDataNew(this, displayProp));
				}
			}
		}
		RefreshSortEquipExpItems(CurSortType);
	}

	private void RefreshSortEquipExpItems(int curSortType)
	{
		switch (curSortType)
		{
		case 1:
			EquipExpItemDataList.Sort(new EquipExpItemDataNewSortByExp());
			break;
		case 2:
			EquipExpItemDataList.Sort(new EquipExpItemDataNewSortByRarity());
			break;
		case 3:
			EquipExpItemDataList.Sort(new EquipExpItemDataNewSortByLevel());
			break;
		}
		refreshExpItemListRequest.Raise();
	}

	public void CloseProp()
	{
		CloseArmourView();
		ClosePropView();
	}

	private void CloseArmourView()
	{
		if (armourPopupViewModel != null)
		{
			armourPopupViewModel.Close();
			armourPopupViewModel = null;
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

	private async void OpenProp(EquipExpItemDataNew itemData)
	{
		if (itemData.ItemType == 1)
		{
			CloseArmourView();
			if (propInfoViewModel == null)
			{
				propInfoViewModel = new PropWindowViewModel(this, showOutsideMask: false, showOwnCount: true, allowSkipWindow: true, showOutsideMask2: true);
				propInfoViewModel.SetPosition(new Vector2(230f, 18f));
			}
			propInfoViewModel.RefreshData(itemData.PropData);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropPopupWindow), propInfoViewModel));
		}
		else if (itemData.ItemType == 3)
		{
			ClosePropView();
			if (armourPopupViewModel == null)
			{
				armourPopupViewModel = new ArmourPopupViewModel(this, itemData.ArmourData, showHeroInfo: false, 230f, 18f, showOutsideMask: false, showOutsideMask2: true);
				armourPopupViewModel.EntryInfoPos = new Vector2(-60f, -71f);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupWindow), armourPopupViewModel));
			}
			else
			{
				armourPopupViewModel.RefreshData(itemData.ArmourData);
			}
		}
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		_showEntryDetailRequest.Raise(entryItem);
	}

	public async void UpgradeOnClick()
	{
		ItemChange.Clear();
		ArmourChange.Clear();
		foreach (EquipExpItemDataNew equipExpItemData in EquipExpItemDataList)
		{
			if (equipExpItemData.ItemType == 1)
			{
				ItemChange.Add(new ItemResult
				{
					itemType = 1,
					itemId = equipExpItemData.PropData.Id,
					itemCount = equipExpItemData.SelectedNum
				});
			}
			else if (equipExpItemData.SelectedNum == 1)
			{
				ArmourChange.Add(equipExpItemData.ArmourData.Uid);
			}
		}
		if (ExpPool == 0)
		{
			Toast.ShowInfo("请选择升级材料!");
			return;
		}
		if (CoinNeed > (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin))
		{
			Toast.ShowInfo("德拉塔不足!");
			return;
		}
		LoadExpItemLeft(expLeft);
		if (propReturn.Count > 0)
		{
			ExpPropReturnViewModel returnViewModel = new ExpPropReturnViewModel(this, propReturn);
			openWindowRequest.Raise(new OpenViewArg(typeof(ExpPropReturnWindow), returnViewModel), delegate
			{
				if (returnViewModel.result)
				{
					UpLevelShow(ItemChange, ArmourChange);
				}
			});
		}
		else
		{
			UpLevelShow(ItemChange, ArmourChange);
		}
	}

	private async void UpLevelShow(List<ItemResult> itemChange, List<long> armourChange)
	{
		int oldLevel = ArmourData.Level;
		Dictionary<int, float> oldAttributeDataDic = new Dictionary<int, float>();
		foreach (EquipAttribute item in ArmourData.GetSubAttribute())
		{
			oldAttributeDataDic.Add(item.Id, item.BaseValue);
		}
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().EquipUpgrade(ArmourData, itemChange, armourChange, (int)CoinNeed);
		loading.Dispose();
		if (!num)
		{
			await UIHelper.AccountDisconnect();
		}
		else
		{
			ExpPool = 0;
			LoadExpItem();
			ArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(ArmourData.Uid);
			if (oldLevel < ArmourData.Level)
			{
				ArmourSuccessViewModel userData = new ArmourSuccessViewModel(ArmourData, oldAttributeDataDic, oldLevel);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourSuccessView), userData), delegate
				{
					if (propReturn.Count > 0)
					{
						PropGetViewModel userData2 = new PropGetViewModel(this, propReturn);
						OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), userData2);
						parent?.ItemOnClick(obj);
						propReturn.Clear();
					}
				});
			}
			CoinNeed = 0f;
			AddLevel = 0;
			ActionName = "LevelUp";
			if (ArmourData.Level == ArmourData.MaxLevel)
			{
				ActionName = "LevelMax";
				IsMax = true;
				IsRealMax = true;
			}
			SetAutoSelect(value: true);
		}
		parent?.ItemOnClick(this);
		GetTargetData();
	}

	private void LoadExpItemLeft(int exp)
	{
		propReturn.Clear();
		List<int> list = new List<int>();
		DRProp[] allDataRows = GameEntry.DataTable.GetDataTable<DRProp>().GetAllDataRows();
		foreach (DRProp dRProp in allDataRows)
		{
			foreach (int item in dRProp.UseType)
			{
				if (item == 8)
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
				propReturn.Add(KnapsackPropData.Create(list[num], num2));
			}
			exp -= dataRow.EX1 * num2;
		}
	}

	private void CheckUpLevelMax()
	{
		if (IsOpenUpLimit)
		{
			upLevelMax = 3 - ArmourData.Level % 3 + ArmourData.Level;
			SettingText = $"本次升级上限: +{upLevelMax}";
			string text = UiConvert.Equip.EquipRarity2Name[autoSelectRarity];
			SettingBtnText = ((autoSelectRarity >= 2) ? (text + "及以下") : text);
		}
		else
		{
			upLevelMax = ArmourData.MaxLevel;
			string text2 = UiConvert.Equip.EquipRarity2Name[autoSelectRarity];
			SettingBtnText = ((autoSelectRarity >= 2) ? (text2 + "及以下") : text2);
		}
	}

	private void GetTargetData()
	{
		CheckUpLevelMax();
		int num = ExpPool + ArmourData.Exp;
		int num2 = ArmourData.Level;
		int num3 = ArmourData.MaxExp;
		while (true)
		{
			if (num >= num3 && num2 < ArmourData.MaxLevel)
			{
				num -= num3;
				num2++;
				int armourExp = ArmourData.GetArmourExp(ArmourData.Rarity, num2 + 1, ArmourData.Rank);
				if (armourExp != 0)
				{
					num3 = armourExp;
				}
			}
			else
			{
				if (num >= 0)
				{
					break;
				}
				num2--;
				num3 = ArmourData.GetArmourExp(ArmourData.Rarity, num2 + 1, ArmourData.Rank);
				num += num3;
			}
		}
		expLeft = 0;
		if (num2 >= ArmourData.MaxLevel)
		{
			expLeft = num;
		}
		CurExpText = $"{ArmourData.Exp}/{ArmourData.MaxExp}";
		AddLevel = num2 - ArmourData.Level;
		CurExpFillAmount = (float)ArmourData.Exp / (float)ArmourData.MaxExp;
		PreExpFillAmount = ((AddLevel > 0) ? 1f : ((float)num / (float)num3));
		SetCoin(AddLevel, ExpPool);
		DREquipment drEquipment = GameEntry.DataTable.GetDataTable<DREquipment>().GetDataRow((DREquipment p) => p.TypeId == ArmourData.TypeId && p.RankMin == ArmourData.Rank);
		if (ArmourData.GetMainAttribute() != null)
		{
			for (int num4 = 0; num4 < drEquipment.DefenseAttribute.Count; num4++)
			{
				if (ArmourData.GetMainAttribute().Id == drEquipment.DefenseAttribute[num4])
				{
					float value = ((float)drEquipment.DefenseBase[num4] + (float)((AddLevel + ArmourData.Level) * drEquipment.DefenseGrow[num4])) / 10000f;
					attributeUpgradeItemData = new AttributeUpgradeItemData(ArmourData.GetMainAttribute(), value);
					break;
				}
			}
		}
		else
		{
			Toast.ShowError($"明饰ID:{ArmourData.Id}的主属性:{ArmourData.GetMainAttribute()?.Id}与表格数据不相符");
		}
		if (attributeUpgradeItemData == null)
		{
			Toast.ShowError($"明饰ID:{ArmourData.Id}的主属性:{ArmourData.GetMainAttribute()?.Id}与表格数据不相符");
		}
		int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.ArmourGetAttribute, 3);
		int num5 = num2 / constantConfigInt - ArmourData.Level / constantConfigInt;
		AttributeItemDataList.Clear();
		List<EquipAttribute> subAttribute = ArmourData.GetSubAttribute();
		DRAttributeStore[] dataRows = GameEntry.DataTable.GetDataRows((DRAttributeStore p) => p.StoreId == drEquipment.AttributeStore);
		for (int num6 = 0; num6 < subAttribute.Count; num6++)
		{
			for (int num7 = 0; num7 < dataRows.Length; num7++)
			{
				if (subAttribute[num6].Id == dataRows[num7].AttributeId)
				{
					float value2 = subAttribute[num6].BaseValue + (float)num5 * dataRows[num7].AttributeGrow / 10000f;
					AttributeUpgradeItemData item = new AttributeUpgradeItemData(subAttribute[num6], value2);
					attributeItemDataList.Add(item);
				}
			}
		}
		_refreshInfoRequest.Raise();
	}

	private void SetCoin(int addLevel, int exp)
	{
		CoinNeed = 0f;
		float num = ArmourData.GetArmourNeedGold(ArmourData.Rarity, ArmourData.Level + 1, ArmourData.Rank);
		float num2 = ArmourData.GetArmourExp(ArmourData.Rarity, ArmourData.Level + 1, ArmourData.Rank);
		float num3 = ((addLevel > 0) ? (num2 - (float)ArmourData.Exp) : ((float)exp));
		CoinNeed += num3 * num / num2;
		exp -= (int)num3;
		if (addLevel < 0)
		{
			CoinNeed = (int)Math.Ceiling(CoinNeed);
			return;
		}
		for (int i = 2; i <= addLevel; i++)
		{
			int armourNeedGold = ArmourData.GetArmourNeedGold(ArmourData.Rarity, i + ArmourData.Level, ArmourData.Rank);
			exp -= ArmourData.GetArmourExp(ArmourData.Rarity, i + ArmourData.Level, ArmourData.Rank);
			CoinNeed += armourNeedGold;
		}
		if (addLevel == 1 && IsMax)
		{
			CoinNeed = (int)Math.Ceiling(CoinNeed);
			return;
		}
		float num4 = ArmourData.GetArmourNeedGold(ArmourData.Rarity, ArmourData.Level + addLevel + 1, ArmourData.Rank);
		float num5 = ArmourData.GetArmourExp(ArmourData.Rarity, ArmourData.Level + addLevel + 1, ArmourData.Rank);
		float num6 = (IsMax ? num5 : ((float)exp));
		if (num5 > 0f)
		{
			CoinNeed += num6 * num4 / num5;
		}
		CoinNeed = (int)Math.Ceiling(CoinNeed);
	}

	public void AutoSelect()
	{
		if (isAutoSelect)
		{
			AutoAdd();
		}
		else
		{
			AllDelete();
		}
	}

	public override void OnOpen()
	{
		base.OnOpen();
		ExpPool = 0;
		LoadExpItem();
		CoinNeed = 0f;
		AddLevel = 0;
		ActionName = "LevelUp";
		if (ArmourData.Level == ArmourData.MaxLevel)
		{
			ActionName = "LevelMax";
			IsMax = true;
			IsRealMax = true;
		}
		AllDelete();
	}

	public void AllDelete()
	{
		foreach (EquipExpItemDataNew equipExpItemData in EquipExpItemDataList)
		{
			if (equipExpItemData.ItemType == 1 && equipExpItemData.SelectedNum > 0)
			{
				ExpPool -= equipExpItemData.ProvideExp * equipExpItemData.SelectedNum;
				equipExpItemData.ClearNum();
			}
			else if (equipExpItemData.ItemType == 3 && equipExpItemData.IsSelected)
			{
				ExpPool -= equipExpItemData.ProvideExp;
				equipExpItemData.ClearNum();
			}
		}
		GetTargetData();
		SetAutoSelect(value: true);
	}

	private void AutoAdd()
	{
		int num = 0;
		int num2 = ArmourData.Level;
		if (num2 >= upLevelMax || AddLevel + ArmourData.Level >= upLevelMax)
		{
			Toast.ShowInfo("已达到设定的最大等级");
			SetAutoSelect(value: false);
			return;
		}
		while (num2 != upLevelMax)
		{
			num2++;
			int armourExp = ArmourData.GetArmourExp(ArmourData.Rarity, num2, ArmourData.Rank);
			num += armourExp;
		}
		num -= ArmourData.Exp;
		num -= ExpPool;
		if (num <= 0)
		{
			return;
		}
		List<EquipExpItemDataNew> list = new List<EquipExpItemDataNew>();
		foreach (EquipExpItemDataNew equipExpItemData in EquipExpItemDataList)
		{
			if (equipExpItemData.ItemType == 1 && equipExpItemData.Rarity <= autoSelectRarity)
			{
				list.Add(equipExpItemData);
			}
			else if (equipExpItemData.ItemType == 3 && equipExpItemData.Level == 0 && equipExpItemData.Rarity <= autoSelectRarity && !equipExpItemData.IsLock && equipExpItemData.SelectedNum == 0)
			{
				list.Add(equipExpItemData);
			}
		}
		list.Sort(new EquipExpItemNewSortByAutoSelected());
		for (int i = 0; i < list.Count; i++)
		{
			int num3 = 0;
			if (num <= list[i].GetProvideExpLeft())
			{
				num3 = num / list[i].ProvideExp;
				if (num % list[i].ProvideExp > 0)
				{
					num3++;
				}
				list[i].SetSelected(num3);
				ExpPool += list[i].ProvideExp * num3;
				num -= list[i].ProvideExp * num3;
			}
			else
			{
				num3 = list[i].GetNum();
				list[i].SetSelected(num3);
				ExpPool += list[i].ProvideExp * num3;
				num -= list[i].ProvideExp * num3;
			}
			if (num <= 0)
			{
				break;
			}
		}
		if (list.Count == 0)
		{
			Toast.ShowInfo("无满足条件的明饰");
		}
		if (ExpPool != 0)
		{
			SetAutoSelect(value: false);
			GetTargetData();
		}
	}

	private void SetAutoSelect(bool value)
	{
		AutoSelectBtnText = (value ? "自动选择" : "全部清除");
		isAutoSelect = value;
	}

	public void RefreshArmour(ArmourData armourData)
	{
		ArmourData = armourData;
		GetTargetData();
	}
}
