using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ArmourEntryResetViewModel : OptionBase
{
	private bool isShowGamePlayView;

	private HeroModel heroModel;

	private ArmourData armourData;

	private MoneyData moneyData;

	private bool isShowHeroArmourTabs;

	private List<TabItemNormalData> armourTabDataList;

	private ArmourEnum armourEnum;

	private bool canUnLockEntry;

	private List<EntryItemData2> unLockEntryList;

	private List<EntryItemData2> curEntryList;

	private KnapsackItemViewModel iconItemData;

	private int costCoin;

	private SimpleCommand unLockEntryCmd;

	private SimpleCommand openRefreshEntryCmd;

	private string unlockBtnText;

	private InteractionRequest refreshUnLockEntryListRequest;

	private InteractionRequest refreshCurEntryListRequest;

	private InteractionRequest refreshArmourTabRequest;

	private SimpleCommand openAllEntryWindowCmd;

	private bool isShowEntryAllBtn;

	public bool IsShowGamePlayView
	{
		get
		{
			return isShowGamePlayView;
		}
		private set
		{
			Set(ref isShowGamePlayView, value, "IsShowGamePlayView");
		}
	}

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

	public int CostCoin
	{
		get
		{
			return costCoin;
		}
		private set
		{
			Set(ref costCoin, value, "CostCoin");
		}
	}

	public bool CanUnLockEntry
	{
		get
		{
			return canUnLockEntry;
		}
		private set
		{
			Set(ref canUnLockEntry, value, "CanUnLockEntry");
		}
	}

	public List<EntryItemData2> UnLockEntryList
	{
		get
		{
			return unLockEntryList;
		}
		private set
		{
			Set(ref unLockEntryList, value, "UnLockEntryList");
		}
	}

	public List<EntryItemData2> CurEntryList
	{
		get
		{
			return curEntryList;
		}
		private set
		{
			Set(ref curEntryList, value, "CurEntryList");
		}
	}

	public string UnlockBtnText
	{
		get
		{
			return unlockBtnText;
		}
		private set
		{
			Set(ref unlockBtnText, value, "UnlockBtnText");
		}
	}

	public ArmourEnum ArmourEnum => armourEnum;

	public List<TabItemNormalData> ArmourTabDataList => armourTabDataList;

	public bool IsShowHeroArmourTabs => isShowHeroArmourTabs;

	public InteractionRequest RefreshUnLockEntryListRequest => refreshUnLockEntryListRequest;

	public InteractionRequest RefreshCurEntryListRequest => refreshCurEntryListRequest;

	public InteractionRequest RefreshArmourTabRequest => refreshArmourTabRequest;

	public SimpleCommand UnLockEntryCmd => unLockEntryCmd;

	public SimpleCommand OpenRefreshEntryCmd => openRefreshEntryCmd;

	public SimpleCommand OpenAllEntryWindowCmd => openAllEntryWindowCmd;

	public bool IsShowEntryAllBtn
	{
		get
		{
			return isShowEntryAllBtn;
		}
		private set
		{
			Set(ref isShowEntryAllBtn, value, "IsShowEntryAllBtn");
		}
	}

	public ArmourEntryResetViewModel(OptionBase parent, HeroModel heroModel, ArmourData armourData, MoneyData moneyData)
	{
		base.parent = parent;
		this.heroModel = heroModel;
		this.moneyData = moneyData;
		unLockEntryList = new List<EntryItemData2>();
		curEntryList = new List<EntryItemData2>();
		armourTabDataList = new List<TabItemNormalData>();
		refreshUnLockEntryListRequest = new InteractionRequest();
		refreshCurEntryListRequest = new InteractionRequest();
		refreshArmourTabRequest = new InteractionRequest();
		unLockEntryCmd = new SimpleCommand(UnLockEntryOnClick);
		openRefreshEntryCmd = new SimpleCommand(OpenRefreshEntryOnClick);
		openAllEntryWindowCmd = new SimpleCommand(OpenAllEntryWindowOnClick);
		isShowEntryAllBtn = heroModel != null;
		SetArmourData(armourData);
	}

	private void OpenAllEntryWindowOnClick()
	{
		openAllEntryWindowCmd.Enabled = false;
		if (heroModel == null)
		{
			openAllEntryWindowCmd.Enabled = true;
			return;
		}
		ArmourEntryDetailViewModel userData = new ArmourEntryDetailViewModel(this, heroModel);
		parent.ItemOnClick(new OpenViewArg(typeof(ArmourEntryDetailWindow), userData));
		openAllEntryWindowCmd.Enabled = true;
	}

	private void CheckUnLockBtn()
	{
		if (CostCoin <= MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin))
		{
			unLockEntryCmd.Enabled = true;
			UnlockBtnText = "解锁";
		}
		else
		{
			unLockEntryCmd.Enabled = false;
			UnlockBtnText = "德拉塔不足";
		}
	}

	private void SetArmourTabDataList(HeroModel heroModel, int showArmourTabIndex)
	{
		if (heroModel == null)
		{
			isShowHeroArmourTabs = false;
			return;
		}
		isShowHeroArmourTabs = true;
		armourTabDataList.Clear();
		for (int i = 0; i < 5; i++)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(this, string.Empty, i);
			bool canOnClick = false;
			if (heroModel.Armours.ContainsKey(i) && heroModel.Armours[i] != null && heroModel.Armours[i].Level == this.heroModel.Armours[i].MaxLevel && heroModel.Armours[i].AdditionalEntryNum > 0)
			{
				canOnClick = true;
			}
			tabItemNormalData.SetCanOnClick(canOnClick);
			if (showArmourTabIndex == i)
			{
				tabItemNormalData.IsSelected = true;
			}
			armourTabDataList.Add(tabItemNormalData);
		}
	}

	private void ReSetArmourTabDataList(HeroModel heroModel, int showArmourTabIndex)
	{
		if (heroModel == null)
		{
			isShowHeroArmourTabs = false;
			return;
		}
		isShowHeroArmourTabs = true;
		for (int i = 0; i < armourTabDataList.Count; i++)
		{
			bool canOnClick = false;
			if (heroModel.Armours.ContainsKey(i) && heroModel.Armours[i] != null && heroModel.Armours[i].Level == this.heroModel.Armours[i].MaxLevel && heroModel.Armours[i].AdditionalEntryNum > 0)
			{
				canOnClick = true;
			}
			armourTabDataList[i].SetCanOnClick(canOnClick);
			if (showArmourTabIndex == i)
			{
				armourTabDataList[i].IsSelected = true;
			}
		}
	}

	private void SwitchArmourTab(TabItemNormalData armourTabData)
	{
		if (armourTabData == null || armourTabData.IsSelected || !armourTabData.CanOnClick)
		{
			return;
		}
		for (int i = 0; i < armourTabDataList.Count; i++)
		{
			if (armourTabDataList[i].CanOnClick)
			{
				armourTabDataList[i].IsSelected = armourTabData.ID == armourTabDataList[i].ID;
			}
		}
		armourEnum = (ArmourEnum)armourTabData.ID;
		parent.ItemOnClick(new OptionArg(this, "ChangeArmourTab"));
	}

	private void SetArmourData(ArmourData armourData)
	{
		ArmourData = armourData;
		armourEnum = armourData.ArmourEnum;
		SetArmourTabDataList(heroModel, (int)this.armourData.ArmourEnum);
		RefreshCostItem();
		CanUnLockEntry = armourData.AdditionalEntryNum != armourData.AdditionalEntryList.Count;
		SetUnLockEntryList();
		SetCurEntryList();
		CheckUnLockBtn();
		refreshUnLockEntryListRequest.Raise();
		refreshCurEntryListRequest.Raise();
	}

	private void RefreshCostItem()
	{
		DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(ArmourData.Id);
		CostCoin = dataRow.RefreshGold * ArmourData.AdditionalEntryNum;
	}

	public void RefreshData(ArmourData armourData)
	{
		ArmourData = armourData;
		SetUnLockEntryList();
		SetCurEntryList();
		RefreshCostItem();
		CanUnLockEntry = armourData.AdditionalEntryNum != armourData.AdditionalEntryList.Count;
		CheckUnLockBtn();
		ReSetArmourTabDataList(heroModel, (int)armourData.ArmourEnum);
		refreshUnLockEntryListRequest.Raise();
		refreshCurEntryListRequest.Raise();
		refreshArmourTabRequest.Raise();
	}

	private void SetUnLockEntryList()
	{
		UnLockEntryList.Clear();
		for (int i = 0; i < ArmourData.AdditionalEntryNum; i++)
		{
			UnLockEntryList.Add(new EntryItemData2(this, "需先解锁"));
		}
	}

	private void SetCurEntryList()
	{
		CurEntryList.Clear();
		foreach (EntryData additionalEntry in ArmourData.AdditionalEntryList)
		{
			EntryItemData2 item = new EntryItemData2(this, additionalEntry);
			CurEntryList.Add(item);
		}
	}

	private async void UnLockEntryOnClick()
	{
		unLockEntryCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().UnLockArmourEntry(ArmourData.Uid);
		loading.Dispose();
		if (num)
		{
			SetCurEntryList();
			CanUnLockEntry = false;
			RefreshCurEntryListRequest.Raise();
		}
		else
		{
			await UIHelper.AccountDisconnect();
		}
	}

	private void OpenRefreshEntryOnClick()
	{
		ArmourChangeEntryViewModel userData = new ArmourChangeEntryViewModel(this, armourData, heroModel);
		OpenViewArg obj = new OpenViewArg(typeof(ArmourChangeEntryWindow), userData);
		parent?.ItemOnClick(obj);
	}

	public void OpenGamePlayWindow()
	{
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, 2002);
		OpenViewArg obj = new OpenViewArg(typeof(GamePlayTipsWindow), userData);
		parent?.ItemOnClick(obj);
	}

	public void OpenAddEntryPreViewWindow()
	{
		DREntryStore[] dataRows = GameEntry.DataTable.GetDataRows((DREntryStore P) => P.StoreId == ArmourData.AddEntryStoreId);
		List<EntryItemData2> list = new List<EntryItemData2>();
		DREntryStore[] array = dataRows;
		for (int num = 0; num < array.Length; num++)
		{
			EntryData entryData = new EntryData(array[num].EntryId, 1);
			if (entryData.IsRealData)
			{
				list.Add(new EntryItemData2(this, entryData));
			}
		}
		AddEntryPreViewViewModel userData = new AddEntryPreViewViewModel(this, list);
		OpenViewArg obj = new OpenViewArg(typeof(AddEntryPreViewWindow), userData);
		parent?.ItemOnClick(obj);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				parent?.ItemOnClick(optionArg);
			}
		}
		else if (obj is TabItemNormalData armourTabData)
		{
			SwitchArmourTab(armourTabData);
		}
		else if (obj is ArmourChangeEntryViewModel)
		{
			parent?.ItemOnClick(new OptionArg(this, "RefreshData"));
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg obj2 = knapsackItemViewModel.OpenPopupWindow(this);
			parent.ItemOnClick(obj2);
		}
	}
}
