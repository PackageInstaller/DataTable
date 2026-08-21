using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PropExchangeViewModel : OptionBase
{
	private bool initilized;

	private object exchangeData;

	private SimpleCommand confirmCmd;

	private int useCount;

	private int useCountMin;

	private int useCountMax;

	private bool sliderEnable = true;

	private bool canAdd;

	private bool canDec;

	private int quotaNum;

	private int leftExc;

	private string limitExchangeText;

	private string nameAndCount;

	private string rarityColorBg = "";

	private bool showArmourRank;

	private string armourRankText;

	private string _armourTypeIcon = "";

	private bool showWeaponType;

	private string weaponTypeIcon = "";

	private string weaponTypeText = "";

	private string weaponRefineText = "";

	private PropDataBase propData;

	private string propDesc;

	private bool showDisableMsg;

	private string disableMsg;

	private bool enableConfirm = true;

	private string singleConsumeIcon1 = "";

	private string singleConsumeIcon2 = "";

	private string singleConsumeCount1;

	private string singleConsumeCount2;

	private string multiConsumeIcon1 = "";

	private string multiConsumeIcon2 = "";

	private string multiConsumeCount1;

	private string multiConsumeCount2;

	private int curSchemeTabIndex;

	private TabItemData schemeTab0;

	private int cashPrice;

	private TabItemData schemeTab1;

	private ExchangeConsumeScheme consumeSchemeType;

	private List<List<PropDataBase>> consumeSchemes = new List<List<PropDataBase>>();

	private SimpleCommand openWeaponPreviewCmd;

	private List<PropPackItemViewModel> propPackItemViewModelList;

	public TabItemData SchemeTab0 => schemeTab0;

	public int CashPrice => cashPrice;

	public TabItemData SchemeTab1 => schemeTab1;

	public SimpleCommand OpenWeaponPreviewCmd => openWeaponPreviewCmd;

	public bool Initilized
	{
		get
		{
			return initilized;
		}
		set
		{
			Set(ref initilized, value, "Initilized");
		}
	}

	public object ExchangeData => exchangeData;

	public ExchangeConsumeScheme ConsumeSchemeType
	{
		get
		{
			return consumeSchemeType;
		}
		private set
		{
			Set(ref consumeSchemeType, value, "ConsumeSchemeType");
		}
	}

	public int CurSchemeTabIndex => curSchemeTabIndex;

	public List<List<PropDataBase>> ConsumeSchemes => consumeSchemes;

	public string LimitExchangeText
	{
		get
		{
			return limitExchangeText;
		}
		set
		{
			Set(ref limitExchangeText, value, "LimitExchangeText");
		}
	}

	public string NameAndCount
	{
		get
		{
			return nameAndCount;
		}
		set
		{
			Set(ref nameAndCount, value, "NameAndCount");
		}
	}

	public string RarityColorBg
	{
		get
		{
			return rarityColorBg;
		}
		set
		{
			Set(ref rarityColorBg, value, "RarityColorBg");
		}
	}

	public bool ShowArmourRank
	{
		get
		{
			return showArmourRank;
		}
		set
		{
			Set(ref showArmourRank, value, "ShowArmourRank");
		}
	}

	public string ArmourRankText
	{
		get
		{
			return armourRankText;
		}
		set
		{
			Set(ref armourRankText, value, "ArmourRankText");
		}
	}

	public string ArmourTypeIcon
	{
		get
		{
			return _armourTypeIcon;
		}
		set
		{
			Set(ref _armourTypeIcon, value, "ArmourTypeIcon");
		}
	}

	public bool ShowWeaponType
	{
		get
		{
			return showWeaponType;
		}
		set
		{
			Set(ref showWeaponType, value, "ShowWeaponType");
		}
	}

	public string WeaponTypeIcon
	{
		get
		{
			return weaponTypeIcon;
		}
		set
		{
			Set(ref weaponTypeIcon, value, "WeaponTypeIcon");
		}
	}

	public string WeaponTypeText
	{
		get
		{
			return weaponTypeText;
		}
		set
		{
			Set(ref weaponTypeText, value, "WeaponTypeText");
		}
	}

	public string WeaponRefineText
	{
		get
		{
			return weaponRefineText;
		}
		set
		{
			Set(ref weaponRefineText, value, "WeaponRefineText");
		}
	}

	public string PropDesc
	{
		get
		{
			return propDesc;
		}
		set
		{
			Set(ref propDesc, value.Replace("\\n", "\n"), "PropDesc");
		}
	}

	public PropDataBase PropData
	{
		get
		{
			return propData;
		}
		set
		{
			Set(ref propData, value, "PropData");
			NameAndCount = ((value.Amount > 1) ? $"{value.Name} x{value.Amount}" : value.Name);
			int rarity = value.GetRarity();
			RarityColorBg = $"shop_prop_{rarity}";
			RefreshWeaponInfo(value);
			RefreshArmourRank(value);
			RefreshDescription();
		}
	}

	public bool EnableConfirm
	{
		get
		{
			return enableConfirm;
		}
		set
		{
			Set(ref enableConfirm, value, "EnableConfirm");
		}
	}

	public bool ShowDisableMsg
	{
		get
		{
			return showDisableMsg;
		}
		set
		{
			Set(ref showDisableMsg, value, "ShowDisableMsg");
		}
	}

	public string DisableMsg
	{
		get
		{
			return disableMsg;
		}
		set
		{
			Set(ref disableMsg, value, "DisableMsg");
		}
	}

	public string SingleConsumeIcon1
	{
		get
		{
			return singleConsumeIcon1;
		}
		set
		{
			Set(ref singleConsumeIcon1, value, "SingleConsumeIcon1");
		}
	}

	public string SingleConsumeIcon2
	{
		get
		{
			return singleConsumeIcon2;
		}
		set
		{
			Set(ref singleConsumeIcon2, value, "SingleConsumeIcon2");
		}
	}

	public string MultiConsumeIcon1
	{
		get
		{
			return multiConsumeIcon1;
		}
		set
		{
			Set(ref multiConsumeIcon1, value, "MultiConsumeIcon1");
		}
	}

	public string MultiConsumeIcon2
	{
		get
		{
			return multiConsumeIcon2;
		}
		set
		{
			Set(ref multiConsumeIcon2, value, "MultiConsumeIcon2");
		}
	}

	public string SingleConsumeCount1
	{
		get
		{
			return singleConsumeCount1;
		}
		set
		{
			Set(ref singleConsumeCount1, value, "SingleConsumeCount1");
		}
	}

	public string SingleConsumeCount2
	{
		get
		{
			return singleConsumeCount2;
		}
		set
		{
			Set(ref singleConsumeCount2, value, "SingleConsumeCount2");
		}
	}

	public string MultiConsumeCount1
	{
		get
		{
			return multiConsumeCount1;
		}
		set
		{
			Set(ref multiConsumeCount1, value, "MultiConsumeCount1");
		}
	}

	public string MultiConsumeCount2
	{
		get
		{
			return multiConsumeCount2;
		}
		set
		{
			Set(ref multiConsumeCount2, value, "MultiConsumeCount2");
		}
	}

	public int UseCount
	{
		get
		{
			return useCount;
		}
		set
		{
			Set(ref useCount, value, "UseCount");
			CanAdd = UseCount < UseCountMax;
			CanDec = UseCountMin > 0 && UseCount > UseCountMin;
			RefreshConsumeCount();
		}
	}

	public bool SliderEnable
	{
		get
		{
			return sliderEnable;
		}
		set
		{
			Set(ref sliderEnable, value, "SliderEnable");
		}
	}

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		private set
		{
			Set(ref canAdd, value, "CanAdd");
		}
	}

	public bool CanDec
	{
		get
		{
			return canDec;
		}
		private set
		{
			Set(ref canDec, value, "CanDec");
		}
	}

	public int UseCountMin
	{
		get
		{
			return useCountMin;
		}
		set
		{
			Set(ref useCountMin, value, "UseCountMin");
		}
	}

	public int UseCountMax
	{
		get
		{
			return useCountMax;
		}
		set
		{
			Set(ref useCountMax, value, "UseCountMax");
		}
	}

	public ICommand ConfirmCmd => confirmCmd;

	public List<PropPackItemViewModel> PropPackItemViewModelList => propPackItemViewModelList;

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemData tabItemData)
		{
			SetCurSchemeTab(tabItemData.TabIndex);
		}
		else if (obj is PropPackItemViewModel propPackItemViewModel)
		{
			OpenViewArg obj2 = propPackItemViewModel.OpenPopupWindow(parent);
			parent?.ItemOnClick(obj2);
		}
	}

	public PropExchangeViewModel()
	{
	}

	public PropExchangeViewModel(OptionBase parent)
	{
		base.parent = parent;
		confirmCmd = new SimpleCommand(Confirm);
		openWeaponPreviewCmd = new SimpleCommand(OpenWeaponPreview);
		schemeTab0 = new TabItemData(this, 0);
		schemeTab1 = new TabItemData(this, 1);
	}

	public void SetData(ShopExcData shopExcData)
	{
		exchangeData = shopExcData;
		consumeSchemes = shopExcData.ConsumeSchemes;
		PropData = shopExcData.Prop;
		quotaNum = shopExcData.QuotaNum;
		leftExc = shopExcData.LeftExc;
		LimitExchangeText = ((quotaNum > 0) ? $"可兑换{leftExc}/{quotaNum}" : string.Empty);
		cashPrice = shopExcData.CashPriceCount;
		if (consumeSchemes.Count > 1 && consumeSchemes[0].Count > 0 && consumeSchemes[1].Count > 0)
		{
			PropDataBase propDataBase = consumeSchemes[0][0];
			PropDataBase propDataBase2 = consumeSchemes[1][0];
			ConsumeSchemeType = ExchangeConsumeScheme.Multiple;
			MultiConsumeIcon1 = propDataBase.Icon;
			MultiConsumeIcon2 = propDataBase2.Icon;
		}
		else if (consumeSchemes.Count > 0 && consumeSchemes[0].Count > 0)
		{
			PropDataBase propDataBase3 = consumeSchemes[0][0];
			SingleConsumeIcon1 = propDataBase3.Icon;
			if (consumeSchemes[0].Count > 1)
			{
				ConsumeSchemeType = ExchangeConsumeScheme.Combined;
				PropDataBase propDataBase4 = consumeSchemes[0][1];
				SingleConsumeIcon2 = propDataBase4.Icon;
			}
			else
			{
				ConsumeSchemeType = ExchangeConsumeScheme.Single;
			}
		}
		else
		{
			ConsumeSchemeType = ExchangeConsumeScheme.None;
		}
		RefreshConsumeInfo();
		RefreshMsgAndConfirmState();
		if (PropData.PropTypeEnum == PropTypeEnum.GiftPack)
		{
			LoadPackInfo();
		}
	}

	public void SetData(HomeShopExcData shopExcData)
	{
		exchangeData = shopExcData;
		consumeSchemes = shopExcData.ConsumeSchemes;
		PropData = shopExcData.Prop;
		quotaNum = shopExcData.QuotaNum;
		leftExc = shopExcData.LeftExc;
		LimitExchangeText = ((quotaNum > 0) ? $"可兑换{leftExc}/{quotaNum}" : string.Empty);
		cashPrice = shopExcData.CashPriceCount;
		if (consumeSchemes.Count > 1 && consumeSchemes[0].Count > 0 && consumeSchemes[1].Count > 0)
		{
			PropDataBase propDataBase = consumeSchemes[0][0];
			PropDataBase propDataBase2 = consumeSchemes[1][0];
			ConsumeSchemeType = ExchangeConsumeScheme.Multiple;
			MultiConsumeIcon1 = propDataBase.Icon;
			MultiConsumeIcon2 = propDataBase2.Icon;
		}
		else if (consumeSchemes.Count > 0 && consumeSchemes[0].Count > 0)
		{
			PropDataBase propDataBase3 = consumeSchemes[0][0];
			SingleConsumeIcon1 = propDataBase3.Icon;
			if (consumeSchemes[0].Count > 1)
			{
				ConsumeSchemeType = ExchangeConsumeScheme.Combined;
				PropDataBase propDataBase4 = consumeSchemes[0][1];
				SingleConsumeIcon2 = propDataBase4.Icon;
			}
			else
			{
				ConsumeSchemeType = ExchangeConsumeScheme.Single;
			}
		}
		else
		{
			ConsumeSchemeType = ExchangeConsumeScheme.None;
		}
		RefreshConsumeInfo();
		RefreshMsgAndConfirmState();
		if (PropData.PropTypeEnum == PropTypeEnum.GiftPack)
		{
			LoadPackInfo();
		}
	}

	public void SetCurSchemeTab(int index)
	{
		schemeTab0.IsSelected = index == 0;
		schemeTab1.IsSelected = index == 1;
		curSchemeTabIndex = index;
		RefreshConsumeInfo();
		RefreshMsgAndConfirmState();
	}

	private void RefreshConsumeInfo()
	{
		if (consumeSchemeType == ExchangeConsumeScheme.Single)
		{
			UseCountMax = CalSliderMax(consumeSchemes[0][0].Id, consumeSchemes[0][0].Amount, leftExc);
		}
		else if (consumeSchemeType == ExchangeConsumeScheme.Combined)
		{
			int a = CalSliderMax(consumeSchemes[0][0].Id, consumeSchemes[0][0].Amount, leftExc);
			int b = CalSliderMax(consumeSchemes[0][1].Id, consumeSchemes[0][1].Amount, leftExc);
			UseCountMax = Mathf.Min(a, b);
		}
		else if (consumeSchemeType == ExchangeConsumeScheme.Multiple)
		{
			UseCountMax = CalSliderMax(consumeSchemes[curSchemeTabIndex][0].Id, consumeSchemes[curSchemeTabIndex][0].Amount, leftExc);
		}
		if (UseCountMax == 1)
		{
			UseCountMin = 0;
			UseCount = UseCountMax;
			SliderEnable = false;
		}
		else if (UseCountMax <= 0)
		{
			UseCountMin = 0;
			UseCountMax = 0;
			UseCount = 0;
			SliderEnable = false;
		}
		else
		{
			UseCountMin = 1;
			UseCount = UseCountMin;
			SliderEnable = true;
		}
	}

	private void RefreshConsumeCount()
	{
		int num = ((UseCount <= 0) ? 1 : UseCount);
		if (ConsumeSchemeType == ExchangeConsumeScheme.Single)
		{
			int propOwnedCount = PropHelper.GetPropOwnedCount(consumeSchemes[0][0].Id);
			int num2 = consumeSchemes[0][0].Amount * num;
			string arg = ((propOwnedCount >= num2) ? "#DAD2CD" : "#ff8a7a");
			SingleConsumeCount1 = $"<color={arg}>{num2}</color>";
		}
		else if (ConsumeSchemeType == ExchangeConsumeScheme.Combined)
		{
			int propOwnedCount2 = PropHelper.GetPropOwnedCount(consumeSchemes[0][0].Id);
			int num3 = consumeSchemes[0][0].Amount * num;
			int propOwnedCount3 = PropHelper.GetPropOwnedCount(consumeSchemes[0][1].Id);
			int num4 = consumeSchemes[0][1].Amount * num;
			string arg2 = ((propOwnedCount2 >= num3) ? "#DAD2CD" : "#ff8a7a");
			string arg3 = ((propOwnedCount3 >= num4) ? "#DAD2CD" : "#ff8a7a");
			SingleConsumeCount1 = $"<color={arg2}>{num3}</color>";
			SingleConsumeCount2 = $"<color={arg3}>{num4}</color>";
		}
		else if (ConsumeSchemeType == ExchangeConsumeScheme.Multiple)
		{
			int propOwnedCount4 = PropHelper.GetPropOwnedCount(consumeSchemes[0][0].Id);
			int num5 = consumeSchemes[0][0].Amount * num;
			int propOwnedCount5 = PropHelper.GetPropOwnedCount(consumeSchemes[1][0].Id);
			int num6 = consumeSchemes[1][0].Amount * num;
			string arg4 = ((propOwnedCount4 >= num5) ? "#DAD2CD" : "#ff8a7a");
			string arg5 = ((propOwnedCount5 >= num6) ? "#DAD2CD" : "#ff8a7a");
			schemeTab0.TextNormal = $"<color={arg4}>{num5}</color>";
			schemeTab0.TextSelected = schemeTab0.TextNormal;
			schemeTab1.TextNormal = $"<color={arg5}>{num6}</color>";
			schemeTab1.TextSelected = schemeTab1.TextNormal;
		}
	}

	private void RefreshDescription()
	{
		if (PropData == null || PropData.Empty)
		{
			return;
		}
		if (PropData is PropData propData && propData.UseType.Contains(21))
		{
			DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(PropData.Id);
			if (dataRow != null)
			{
				PropDesc = PropData.Description + " \n\n " + ArmourCustomDefinition.GetDescription(dataRow, "#dad2cd", "#9a9998");
			}
		}
		else
		{
			PropDesc = PropData.Description;
		}
	}

	private void RefreshArmourRank(PropDataBase data)
	{
		ArmourTypeIcon = "";
		if (data is ArmourData armourData)
		{
			ShowArmourRank = true;
			ArmourRankText = $"R{armourData.Rank}";
		}
		else if (data is PropData propData && propData.UseType.Contains(21))
		{
			DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(propData.Id);
			if (dataRow == null || dataRow.Equipments.Count <= 0)
			{
				ShowArmourRank = false;
				return;
			}
			DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(dataRow.Equipments[0]);
			if (dataRow2 == null)
			{
				ShowArmourRank = false;
				return;
			}
			ShowArmourRank = true;
			ArmourRankText = $"R{dataRow2.RankMin}";
			ArmourTypeIcon = $"ArmourEnum_{dataRow2.Position}";
		}
		else
		{
			ShowArmourRank = false;
		}
	}

	private void RefreshWeaponInfo(PropDataBase data)
	{
		if (data is ArmourData)
		{
			ShowWeaponType = false;
		}
		else if (data is WeaponData weaponData)
		{
			ShowWeaponType = true;
			WeaponTypeIcon = $"WeaponEnum_{(int)weaponData.WeaponEnum}";
			WeaponTypeText = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
			WeaponRefineText = $"精炼{weaponData.WeaponRefine}阶效果";
			PropDesc = weaponData.EffectDesc;
		}
		else
		{
			ShowWeaponType = false;
		}
	}

	private void RefreshMsgAndConfirmState()
	{
		if (quotaNum > 0 && leftExc <= 0)
		{
			DisableMsg = "已售空";
			ShowDisableMsg = true;
			EnableConfirm = false;
		}
		else if (UseCountMax <= 0 && cashPrice == 0)
		{
			DisableMsg = "道具不足";
			ShowDisableMsg = true;
			EnableConfirm = false;
		}
		else
		{
			ShowDisableMsg = false;
			EnableConfirm = true;
		}
	}

	private int CalSliderMax(int propId, int countExcNeed, int leftExc)
	{
		int propOwnedCount = PropHelper.GetPropOwnedCount(propId);
		if (propOwnedCount < countExcNeed)
		{
			return 0;
		}
		if (quotaNum >= 0 && propOwnedCount >= countExcNeed * leftExc)
		{
			return leftExc;
		}
		return propOwnedCount / countExcNeed;
	}

	public async void Confirm()
	{
		confirmCmd.Enabled = false;
		parent.ItemOnClick(new OptionArg(this, "OnConfirmExc"));
	}

	public void OpenWeaponPreview()
	{
		openWeaponPreviewCmd.Enabled = false;
		WeaponPreviewViewModel weaponPreviewViewModel = null;
		if (propData != null)
		{
			weaponPreviewViewModel = ((!(propData is WeaponData weaponData)) ? new WeaponPreviewViewModel(parent, propData.Id) : new WeaponPreviewViewModel(parent, weaponData));
		}
		if (weaponPreviewViewModel != null)
		{
			parent?.ItemOnClick(new OpenViewArg(typeof(WeaponPreviewWindow), weaponPreviewViewModel, "Default", isOpenWindow: true, "DEFAULT", delegate
			{
				openWeaponPreviewCmd.Enabled = true;
			}));
		}
		else
		{
			openWeaponPreviewCmd.Enabled = true;
		}
	}

	public void OnEnable()
	{
		confirmCmd.Enabled = true;
	}

	public void AddProp()
	{
		if (UseCount < UseCountMax)
		{
			UseCount++;
		}
	}

	public void DecProp()
	{
		if (UseCount > UseCountMin)
		{
			UseCount--;
		}
	}

	private void LoadPackInfo()
	{
		DRPacks dataRow = GameEntry.DataTable.GetDataRow<DRPacks>(PropData.Id);
		if (dataRow != null)
		{
			int chooseType = dataRow.ChooseType;
			int chooseNUM = dataRow.ChooseNUM;
			SetTipText(chooseType, chooseNUM);
			propPackItemViewModelList = new List<PropPackItemViewModel>();
			DRPacksInclude[] dataRows = GameEntry.DataTable.GetDataRows((DRPacksInclude p) => p.PacksID == PropData.Id);
			foreach (DRPacksInclude dRPacksInclude in dataRows)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dRPacksInclude.IncludeType, dRPacksInclude.IncludeID, dRPacksInclude.IncludeNUM);
				propDataBase.ExValue = dRPacksInclude.Id;
				PropPackItemViewModel item = new PropPackItemViewModel(this, propDataBase);
				propPackItemViewModelList.Add(item);
			}
		}
		else
		{
			Toast.ShowError($"礼包ID:{PropData.Id}的表数据丢失");
		}
	}

	private void SetTipText(int packType, int chooseNum)
	{
		switch (packType)
		{
		case 1:
			PropDesc = "<color=#FF961D>可获得</color>奖励内容";
			break;
		case 2:
			PropDesc = $"从下方奖励<color=#FF961D>选择获得</color>{chooseNum}种";
			break;
		case 3:
			PropDesc = $"<color=#FF961D>随机获得</color>下方奖励的{chooseNum}种";
			break;
		}
	}

	public void Hide()
	{
		visibleRequest.Raise(context: false);
	}
}
