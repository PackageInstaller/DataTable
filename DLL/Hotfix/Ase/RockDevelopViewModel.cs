using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class RockDevelopViewModel : OptionBase
{
	private ArmourData armourData;

	private List<TabItemNormalData> rockMaterialList;

	private List<RockResultItemData> rockResultItemDataList;

	private InteractionRequest refreshRockResultRequest;

	private InteractionRequest closeEffectRequest;

	private bool showPopup;

	private int costCoin;

	private string costCoinText;

	private SimpleCommand developCmd;

	private SimpleCommand gamePlayCmd;

	private SimpleCommand heroAllEntryDetailCmd;

	private string developText;

	private string costMaterialIcon;

	private string costMaterialText;

	private MoneyData moneyData;

	private int curMaterialId;

	private Color rankBgColor;

	private string entryImgPath;

	private bool showResultInfo;

	private string entryNumText;

	private string entryLevelMaxText;

	private int entryNumMax;

	private int entryLevelMax;

	private RockPopupViewModel rockPopupViewModel;

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

	public string DevelopText
	{
		get
		{
			return developText;
		}
		private set
		{
			Set(ref developText, value, "DevelopText");
		}
	}

	public string CostCoinText
	{
		get
		{
			return costCoinText;
		}
		private set
		{
			Set(ref costCoinText, value, "CostCoinText");
		}
	}

	public string CostMaterialIcon
	{
		get
		{
			return costMaterialIcon;
		}
		private set
		{
			Set(ref costMaterialIcon, value, "CostMaterialIcon");
		}
	}

	public string CostMaterialText
	{
		get
		{
			return costMaterialText;
		}
		private set
		{
			Set(ref costMaterialText, value, "CostMaterialText");
		}
	}

	public bool ShowResultInfo
	{
		get
		{
			return showResultInfo;
		}
		private set
		{
			Set(ref showResultInfo, value, "ShowResultInfo");
		}
	}

	public string EntryNumText
	{
		get
		{
			return entryNumText;
		}
		private set
		{
			Set(ref entryNumText, value, "EntryNumText");
		}
	}

	public string EntryLevelMaxText
	{
		get
		{
			return entryLevelMaxText;
		}
		private set
		{
			Set(ref entryLevelMaxText, value, "EntryLevelMaxText");
		}
	}

	public bool ShowPopup
	{
		get
		{
			return showPopup;
		}
		private set
		{
			Set(ref showPopup, value, "ShowPopup");
		}
	}

	public List<TabItemNormalData> RockMaterialList
	{
		get
		{
			return rockMaterialList;
		}
		private set
		{
			Set(ref rockMaterialList, value, "RockMaterialList");
		}
	}

	public List<RockResultItemData> RockResultItemDataList
	{
		get
		{
			return rockResultItemDataList;
		}
		private set
		{
			Set(ref rockResultItemDataList, value, "RockResultItemDataList");
		}
	}

	public SimpleCommand DevelopCmd => developCmd;

	public SimpleCommand GamePlayCmd => gamePlayCmd;

	public SimpleCommand HeroAllEntryDetailCmd => heroAllEntryDetailCmd;

	public InteractionRequest RefreshRockResultRequest => refreshRockResultRequest;

	public InteractionRequest CloseEffectRequest => closeEffectRequest;

	public MoneyData MoneyData => moneyData;

	public Color RankBgColor => rankBgColor;

	public string EntryImgPath => entryImgPath;

	public RockPopupViewModel RockPopupViewModel => rockPopupViewModel;

	public RockDevelopViewModel(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		refreshRockResultRequest = new InteractionRequest();
		closeEffectRequest = new InteractionRequest();
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		this.armourData = armourData;
		rockPopupViewModel = new RockPopupViewModel(this, this.armourData);
		rockPopupViewModel.SetShowTotalEntryLevel(show: true);
		rockPopupViewModel.LoadDefaultEntry();
		LoadRockMaterial();
		rockResultItemDataList = new List<RockResultItemData>();
		developCmd = new SimpleCommand(DevelopOnClick);
		gamePlayCmd = new SimpleCommand(OpenGamePlayWindow);
		heroAllEntryDetailCmd = new SimpleCommand(OpenHeroAllEntryWindow);
		rankBgColor = EquipSlotNew.RankBgColor(armourData.Rarity);
		entryImgPath = armourData.EntryDataList[0].IconPath + "_Rock";
		DRSuitbox dataRow = GameEntry.DataTable.GetDataRow<DRSuitbox>(ArmourData.Id);
		if (dataRow != null)
		{
			entryNumMax = dataRow.MaxType;
			entryLevelMax = dataRow.MaxLevel;
		}
		RefreshText();
	}

	private void RefreshText()
	{
		EntryNumText = ((ArmourData.AdditionalEntryList.Count >= entryNumMax) ? $"词条槽位:<color=#FF0000>{ArmourData.AdditionalEntryList.Count}</color>/{entryNumMax}" : $"词条槽位:{ArmourData.AdditionalEntryList.Count}/{entryNumMax}");
		EntryLevelMaxText = ((GetArmourEntryLevel() >= entryLevelMax) ? $"词条等级上限:<color=#FF0000>{GetArmourEntryLevel()}</color>/{entryLevelMax}" : $"词条等级上限:{GetArmourEntryLevel()}/{entryLevelMax}");
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			SetMaterialResult(tabItemNormalData.ID);
			refreshRockResultRequest.Raise();
			ShowResultInfo = true;
			parent?.ItemOnClick(new OptionArg(this, "ClosePopup"));
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.Obj is RockDevelopSelectViewModel)
			{
				if ("Success".Equals(optionArg.OptionName))
				{
					RefreshData();
					parent?.ItemOnClick(new OptionArg(this, "Refresh"));
				}
			}
			else if (optionArg.Obj is RockPopupViewModel)
			{
				if ("Hide".Equals(optionArg.OptionName))
				{
					ShowPopup = false;
				}
				else if ("ChangeLock".Equals(optionArg.OptionName))
				{
					parent?.ItemOnClick(new OptionArg(this, "ChangeLock"));
				}
			}
		}
	}

	private void LoadRockMaterial()
	{
		rockMaterialList = new List<TabItemNormalData>();
		DRProp[] allDataRows = GameEntry.DataTable.GetDataTable<DRProp>().GetAllDataRows();
		foreach (DRProp dRProp in allDataRows)
		{
			foreach (int item in dRProp.UseType)
			{
				if (item == 14)
				{
					TabItemNormalData tabItemNormalData = new TabItemNormalData(this, dRProp.Icon, dRProp.Id);
					tabItemNormalData.SetColor(GetMaterialColor(dRProp.Quality));
					rockMaterialList.Add(tabItemNormalData);
				}
			}
		}
	}

	public void RefreshData()
	{
		ArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(ArmourData.Uid);
		Clear();
		RefreshText();
		rockPopupViewModel.RefreshArmourData();
	}

	private string GetMaterialColor(int rarity)
	{
		return rarity switch
		{
			3 => "#bda8ff", 
			4 => "#ffd78d", 
			_ => "#637aa4", 
		};
	}

	private void SetMaterialResult(int propId, bool refresh = false)
	{
		if (curMaterialId != propId || refresh)
		{
			curMaterialId = propId;
			SetMaterialState(propId);
			RockResultItemDataList.Clear();
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propId);
			int eX = dataRow.EX1;
			CostMaterialIcon = dataRow.Icon;
			for (int i = 0; i < eX; i++)
			{
				RockResultItemData item = new RockResultItemData(this, 1, "改造结果之一");
				RockResultItemDataList.Add(item);
			}
			if (eX == 3)
			{
				RockResultItemDataList[0].SetExText("提升已有词条等级");
			}
			if (ArmourData.AdditionalEntryList.Count >= entryNumMax)
			{
				RockResultItemDataList.Add(new RockResultItemData(this, 2, "词条槽位已满,改造产生新的词条时会替换已有词条"));
			}
			if (GetArmourEntryLevel() >= entryLevelMax)
			{
				RockResultItemDataList.Add(new RockResultItemData(this, 2, "词条等级上限已满,本次改造必定会导致某个已有词条等级下降"));
			}
			DRSuitboxCoin dataRow2 = GameEntry.DataTable.GetDataRow((DRSuitboxCoin p) => p.Rarity == propId);
			if (dataRow2 != null)
			{
				costCoin = dataRow2.Coin;
				long moneyCount = MoneyDefinition.GetMoneyCount((RoleMoneyEnum)propId);
				long moneyCount2 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin);
				bool flag = moneyCount >= 1;
				bool flag2 = moneyCount2 >= costCoin;
				CostMaterialText = (flag ? $"{1}" : $"<color=#FF0000>{1}</color>");
				CostCoinText = (flag2 ? $"{costCoin}" : $"<color=#FF0000>{costCoin}</color>");
				developCmd.Enabled = flag & flag2;
				DevelopText = ((flag & flag2) ? "改造" : "道具不足");
			}
		}
	}

	private void SetMaterialState(int id)
	{
		foreach (TabItemNormalData rockMaterial in rockMaterialList)
		{
			rockMaterial.IsSelected = rockMaterial.ID == id;
		}
	}

	public void Clear()
	{
		curMaterialId = 0;
		ShowResultInfo = false;
		foreach (TabItemNormalData rockMaterial in rockMaterialList)
		{
			rockMaterial.IsSelected = false;
		}
		ShowPopup = false;
		closeEffectRequest.Raise();
	}

	private void OpenGamePlayWindow()
	{
		gamePlayCmd.Enabled = false;
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, 2001);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
		gamePlayCmd.Enabled = true;
	}

	private void OpenHeroAllEntryWindow()
	{
		heroAllEntryDetailCmd.Enabled = false;
		int ownerId = ArmourData.GetOwnerId();
		if (ownerId != 0)
		{
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
			ArmourEntryDetailViewModel userData = new ArmourEntryDetailViewModel(this, heroById);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourEntryDetailWindow), userData), delegate
			{
				heroAllEntryDetailCmd.Enabled = true;
			});
		}
		else
		{
			heroAllEntryDetailCmd.Enabled = true;
		}
	}

	private async void DevelopOnClick()
	{
		DevelopCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().MakeSuitBox(armourData.Uid, curMaterialId, armourData.AdditionalEntryList, costCoin);
		loading.Dispose();
		if (num)
		{
			Dictionary<int, List<RockDevelopEntryItemData>> developEntryDic = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetDevelopEntryDic();
			List<RockPopupViewModel> list = new List<RockPopupViewModel>();
			foreach (int key in developEntryDic.Keys)
			{
				RockPopupViewModel rockPopupViewModel = new RockPopupViewModel(this, armourData);
				rockPopupViewModel.LoadDevelopEntry(developEntryDic[key], key);
				list.Add(rockPopupViewModel);
			}
			RockPopupViewModel rockPopupViewModel2 = new RockPopupViewModel(this, armourData);
			rockPopupViewModel2.LoadDefaultEntry();
			list.Sort((RockPopupViewModel p1, RockPopupViewModel p2) => (p1.Index != p2.Index) ? p1.Index.CompareTo(p2.Index) : 0);
			RockDevelopSelectViewModel userData = new RockDevelopSelectViewModel(this, rockPopupViewModel2, list);
			openWindowRequest.Raise(new OpenViewArg(typeof(RockDevelopSelectWindow), userData), delegate
			{
				DevelopCmd.Enabled = true;
			});
		}
		else
		{
			await UIHelper.AccountDisconnect();
			DevelopCmd.Enabled = true;
		}
	}

	public void OpenRockDetailView()
	{
		ShowPopup = true;
	}

	private int GetArmourEntryLevel()
	{
		int num = 0;
		foreach (EntryData additionalEntry in ArmourData.AdditionalEntryList)
		{
			num += additionalEntry.CurLevel;
		}
		return num;
	}
}
