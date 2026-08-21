using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class WeaponUpStarViewModel : OptionBase
{
	private WeaponData _weaponData;

	private IKnapsackService _knapsackService;

	private List<CastingMaterialItemData> _materialItemDataList;

	private List<AttributeUpgradeItemData> _attributeUpgradeItemDataList;

	private List<AttributeItemData> attributeItemDataList;

	private string _showCoin;

	private int _targetLevel;

	private string _weaponEnumName;

	private InteractionRequest _refreshRequest;

	private InteractionRequest<EntryUpgradeItem> _showEntryDetailRequest;

	private InteractionRequest refreshMaterialRequest;

	private bool _showBtn;

	private string _btnText;

	private MoneyData moneyData;

	private bool showReturnMaterial;

	private SimpleCommand upStarCmd;

	private bool _isUpStar;

	private int _newMaxLevel;

	public List<CastingMaterialItemData> MaterialItemDataList
	{
		get
		{
			return _materialItemDataList;
		}
		private set
		{
			Set(ref _materialItemDataList, value, "MaterialItemDataList");
		}
	}

	public List<AttributeUpgradeItemData> AttributeUpgradeItemDataList
	{
		get
		{
			return _attributeUpgradeItemDataList;
		}
		private set
		{
			Set(ref _attributeUpgradeItemDataList, value, "AttributeUpgradeItemDataList");
		}
	}

	public List<AttributeItemData> AttributeItemDataList
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
			return _showCoin;
		}
		private set
		{
			Set(ref _showCoin, value, "ShowCoin");
		}
	}

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

	public bool IsUpStar
	{
		get
		{
			return _isUpStar;
		}
		private set
		{
			Set(ref _isUpStar, value, "IsUpStar");
		}
	}

	public int TargetLevel
	{
		get
		{
			return _targetLevel;
		}
		private set
		{
			Set(ref _targetLevel, value, "TargetLevel");
		}
	}

	public bool ShowBtn
	{
		get
		{
			return _showBtn;
		}
		private set
		{
			Set(ref _showBtn, value, "ShowBtn");
		}
	}

	public bool ShowReturnMaterial
	{
		get
		{
			return showReturnMaterial;
		}
		private set
		{
			Set(ref showReturnMaterial, value, "ShowReturnMaterial");
		}
	}

	public string BtnText
	{
		get
		{
			return _btnText;
		}
		private set
		{
			Set(ref _btnText, value, "BtnText");
		}
	}

	public string WeaponEnumName => _weaponEnumName;

	public InteractionRequest RefreshRequest => _refreshRequest;

	public InteractionRequest RefreshMaterialRequest => refreshMaterialRequest;

	public InteractionRequest<EntryUpgradeItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public SimpleCommand UpStarCmd => upStarCmd;

	public WeaponUpStarViewModel(OptionBase parent, WeaponData weaponData, MoneyData moneyData)
	{
		base.parent = parent;
		this.moneyData = moneyData;
		_knapsackService = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		_materialItemDataList = new List<CastingMaterialItemData>();
		_attributeUpgradeItemDataList = new List<AttributeUpgradeItemData>();
		attributeItemDataList = new List<AttributeItemData>();
		_refreshRequest = new InteractionRequest();
		refreshMaterialRequest = new InteractionRequest();
		_showEntryDetailRequest = new InteractionRequest<EntryUpgradeItem>();
		upStarCmd = new SimpleCommand(BtnUpStarOnClick);
		SetWeaponUpgradeData(weaponData);
		_weaponEnumName = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
	}

	public void Refresh(WeaponData weaponData)
	{
		SetWeaponUpgradeData(weaponData);
		_refreshRequest.Raise();
	}

	public void Refresh()
	{
		SetWeaponUpgradeData(WeaponData);
		refreshMaterialRequest.Raise();
	}

	private void SetWeaponUpgradeData(WeaponData weaponData)
	{
		IsUpStar = true;
		WeaponData = weaponData;
		ShowBtn = true;
		BtnText = "突破";
		ShowReturnMaterial = false;
		RefreshWeaponAttributeItemData();
		if (WeaponData.Star == 5)
		{
			IsUpStar = false;
			return;
		}
		if (WeaponData.Level != WeaponData.MaxLevel)
		{
			ItemOnClick(this);
			return;
		}
		DRWeaponStar dataRow = GameEntry.DataTable.GetDataTable<DRWeaponStar>().GetDataRow((DRWeaponStar p) => p.TargetStar == WeaponData.Star + 1 && p.WeaponId == WeaponData.Id);
		if (dataRow == null)
		{
			Toast.ShowError($"找不到ID:{WeaponData.Id}的武器升星配置");
			return;
		}
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		if (dataRow.AccountLv > level)
		{
			BtnText = $"需要传火等级{dataRow.AccountLv}";
			ShowBtn = false;
		}
		if (dataRow.NeedItem.Count != dataRow.ItemNum.Count)
		{
			Toast.ShowError($"武器ID:{WeaponData.Id}的材料数量不匹配");
			return;
		}
		MaterialItemDataList.Clear();
		for (int num = 0; num < dataRow.NeedItem.Count; num++)
		{
			KnapsackPropData prop = _knapsackService.GetKnapsackViewModel().GetProp(dataRow.NeedItem[num], emptyCreate: true);
			if (dataRow.ItemNum[num] > 0)
			{
				MaterialItemDataList.Add(new CastingMaterialItemData(this, dataRow.ItemNum[num], prop));
				if (dataRow.ItemNum[num] > prop.Amount)
				{
					ShowBtn = false;
				}
			}
		}
		AttributeUpgradeItemDataList.Clear();
		DRWeapon dataRow2 = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(WeaponData.Id);
		for (int num2 = 0; num2 < WeaponData.EquipAttributeList.Count; num2++)
		{
			float value = WeaponData.EquipAttributeList[num2].BaseValue + (float)dataRow2.AddAttack[num2][weaponData.Star + 1] / 10000f;
			AttributeUpgradeItemDataList.Add(new AttributeUpgradeItemData(WeaponData.EquipAttributeList[num2], value));
		}
		if (dataRow.NeedGold > MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin))
		{
			ShowCoin = "<color=#fd624e>" + dataRow.NeedGold + "</color>";
			ShowBtn = false;
		}
		else
		{
			ShowCoin = dataRow.NeedGold.ToString();
		}
		int num3 = 0;
		int i;
		for (i = 0; i <= WeaponData.Star + 1; i++)
		{
			DRWeaponGrade[] dataRows = GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRows((DRWeaponGrade p) => p.NeedStar == i && p.Quality == WeaponData.Rarity);
			num3 += dataRows.Length;
		}
		TargetLevel = num3;
		if (dataRow.ReturnItem.Count != dataRow.ReturnItemNum.Count)
		{
			return;
		}
		for (int num4 = 0; num4 < dataRow.ReturnItem.Count; num4++)
		{
			if (dataRow.ReturnItem[num4] != 0 && dataRow.ReturnItemNum[num4] != 0)
			{
				ShowReturnMaterial = true;
				break;
			}
		}
	}

	private void RefreshWeaponAttributeItemData()
	{
		AttributeItemDataList.Clear();
		foreach (EquipAttribute equipAttribute in WeaponData.EquipAttributeList)
		{
			AttributeItemDataList.Add(new AttributeItemData(equipAttribute));
		}
	}

	private async void BtnUpStarOnClick()
	{
		upStarCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().WeaponUpStar(WeaponData.Id, WeaponData.Uid);
		loading.Dispose();
		if (num)
		{
			WeaponData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(WeaponData.Uid);
			WeaponSuccessViewModel userData = new WeaponSuccessViewModel(WeaponData, WeaponUpMode.UpStar);
			openWindowRequest.Raise(new OpenViewArg(typeof(WeaponSuccessView), userData), delegate
			{
				upStarCmd.Enabled = true;
				OpenReturnWindow();
				parent?.ItemOnClick(this);
			});
		}
		else
		{
			await UIHelper.AccountDisconnect();
		}
	}

	private void OpenReturnWindow()
	{
		List<KnapsackPropData> knapsackPropDataList = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetKnapsackPropDataList();
		if (knapsackPropDataList.Count > 0)
		{
			PropGetViewModel userData = new PropGetViewModel(this, knapsackPropDataList);
			OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), userData);
			parent?.ItemOnClick(obj);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CastingMaterialItemData castingMaterialItemData)
		{
			parent?.ItemOnClick(new KnapsackItemViewModel(this, castingMaterialItemData.PropData));
		}
		else if (obj is OptionArg optionArg && optionArg.OptionName.Equals("OnShowEntryPanel"))
		{
			ShowEntryDetail((EntryUpgradeItem)optionArg.Obj);
		}
	}

	public void RefreshMaterial()
	{
		DRWeaponStar dataRow = GameEntry.DataTable.GetDataTable<DRWeaponStar>().GetDataRow((DRWeaponStar p) => p.TargetStar == WeaponData.Star + 1 && p.WeaponId == WeaponData.Id);
		if (dataRow == null)
		{
			return;
		}
		MaterialItemDataList.Clear();
		for (int num = 0; num < dataRow.NeedItem.Count; num++)
		{
			KnapsackPropData prop = _knapsackService.GetKnapsackViewModel().GetProp(dataRow.NeedItem[num], emptyCreate: true);
			if (dataRow.ItemNum[num] > 0)
			{
				MaterialItemDataList.Add(new CastingMaterialItemData(this, dataRow.ItemNum[num], prop));
				_ = dataRow.ItemNum[num];
				_ = prop.Amount;
			}
		}
		refreshMaterialRequest.Raise();
		if (dataRow.NeedGold > MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin))
		{
			ShowCoin = "<color=#fd624e>" + dataRow.NeedGold + "</color>";
		}
		else
		{
			ShowCoin = dataRow.NeedGold.ToString();
		}
	}

	private void ShowEntryDetail(EntryUpgradeItem entryItem)
	{
		entryItem._viewModel.SetSelect(isSelect: true);
		_showEntryDetailRequest.Raise(entryItem);
	}
}
