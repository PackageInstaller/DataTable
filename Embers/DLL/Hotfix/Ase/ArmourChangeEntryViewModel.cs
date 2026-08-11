using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class ArmourChangeEntryViewModel : OptionBase
{
	private MoneyData moneyData;

	private long armourUid;

	private string tip;

	private KnapsackItemViewModel propItemData;

	private KnapsackItemViewModel coinItemData;

	private List<EntryItemData2> backUpEntryList;

	private List<EntryItemData2> curEntryList;

	private List<EntryItemData2> exchangeEntryList;

	private InteractionRequest refreshBackUpEntryRequest;

	private InteractionRequest refreshCurEntryRequest;

	private InteractionRequest<EntryItemData> openEntryPanelRequest;

	private SimpleCommand resetEntryCommand;

	private EntryItemData2 lastEntry;

	private EntryItemData2 selectedBackUpEntry;

	private bool isShowSelected;

	private bool isShowEntryAllBtn;

	private SimpleCommand openAllEntryWindowCmd;

	private HeroModel heroModel;

	private SimpleCommand openEntryPreViewCmd;

	private bool needDelay;

	public List<EntryItemData2> BackUpEntryList
	{
		get
		{
			return backUpEntryList;
		}
		private set
		{
			Set(ref backUpEntryList, value, "BackUpEntryList");
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

	public List<EntryItemData2> ExchangeEntryList
	{
		get
		{
			return exchangeEntryList;
		}
		private set
		{
			Set(ref exchangeEntryList, value, "ExchangeEntryList");
		}
	}

	public EntryItemData2 SelectedBackUpEntry
	{
		get
		{
			return selectedBackUpEntry;
		}
		private set
		{
			Set(ref selectedBackUpEntry, value, "SelectedBackUpEntry");
		}
	}

	public bool IsShowSelected
	{
		get
		{
			return isShowSelected;
		}
		private set
		{
			Set(ref isShowSelected, value, "IsShowSelected");
		}
	}

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

	public MoneyData MoneyData => moneyData;

	public string Tip => tip;

	public KnapsackItemViewModel PropItemData => propItemData;

	public KnapsackItemViewModel CoinItemData => coinItemData;

	public InteractionRequest RefreshBackUpEntryRequest => refreshBackUpEntryRequest;

	public InteractionRequest RefreshCurEntryRequest => refreshCurEntryRequest;

	public SimpleCommand ResetEntryCommand => resetEntryCommand;

	public SimpleCommand OpenAllEntryWindowCmd => openAllEntryWindowCmd;

	public SimpleCommand OpenEntryPreViewCmd => openEntryPreViewCmd;

	public InteractionRequest<EntryItemData> OpenEntryPanelRequest => openEntryPanelRequest;

	private ArmourData ArmourData()
	{
		return Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>()?.GetArmourById(armourUid);
	}

	public ArmourChangeEntryViewModel(OptionBase parent, ArmourData armourData, HeroModel heroModel = null)
	{
		base.parent = parent;
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		armourUid = armourData.Uid;
		tip = $"(最多存放{ArmourData()?.BackUpEntryCount}个备用词条)";
		backUpEntryList = new List<EntryItemData2>();
		curEntryList = new List<EntryItemData2>();
		exchangeEntryList = new List<EntryItemData2>();
		refreshBackUpEntryRequest = new InteractionRequest();
		refreshCurEntryRequest = new InteractionRequest();
		resetEntryCommand = new SimpleCommand(ReSetEntryOnClick);
		openEntryPanelRequest = new InteractionRequest<EntryItemData>();
		DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(ArmourData()?.Id ?? 0);
		KnapsackPropData data = KnapsackPropData.Create(dataRow.RefreshItem, dataRow.RefreshNum);
		propItemData = new KnapsackItemViewModel(this, data);
		propItemData.ShowShortageState = true;
		KnapsackPropData data2 = KnapsackPropData.Create(9001, dataRow.RefreshGold);
		coinItemData = new KnapsackItemViewModel(this, data2);
		coinItemData.ShowShortageState = true;
		SetEntryList();
		selectedBackUpEntry = new EntryItemData2(this, "Empty");
		resetEntryCommand.Enabled = false;
		this.heroModel = heroModel;
		isShowEntryAllBtn = heroModel != null;
		openAllEntryWindowCmd = new SimpleCommand(OpenAllEntryWindowOnClick);
		openEntryPreViewCmd = new SimpleCommand(OpenEntryPreViewOnClick);
		needDelay = false;
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
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourEntryDetailWindow), userData), delegate
		{
			openAllEntryWindowCmd.Enabled = true;
		});
	}

	private void OpenEntryPreViewOnClick()
	{
		DREntryStore[] dataRows = GameEntry.DataTable.GetDataRows((DREntryStore P) => P.StoreId == ArmourData()?.AddEntryStoreId);
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
		openWindowRequest.Raise(new OpenViewArg(typeof(AddEntryPreViewWindow), userData));
	}

	public void OpenEntryGamePlayView()
	{
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, 2002);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
	}

	private void SetEntryList()
	{
		BackUpEntryList.Clear();
		CurEntryList.Clear();
		ExchangeEntryList.Clear();
		ArmourData armourData = ArmourData();
		if (armourData == null)
		{
			return;
		}
		foreach (EntryData item in armourData.BackUpEntryPool)
		{
			EntryItemData2 entryItemData = new EntryItemData2(this, item, showDetail: false);
			entryItemData.SetExActionName("UseEntry");
			entryItemData.NeedShowEntryPanel = false;
			BackUpEntryList.Add(entryItemData);
		}
		foreach (EntryData additionalEntry in armourData.AdditionalEntryList)
		{
			int entryId = additionalEntry.DrEntry.EntryId;
			int level = additionalEntry.DrEntry.Level;
			EntryData entryData = new EntryData(entryId, level);
			EntryItemData2 entryItemData2 = new EntryItemData2(this, entryData, showDetail: false);
			entryItemData2.SetExActionName("ShowEntryPanel");
			entryItemData2.NeedShowSelected = false;
			CurEntryList.Add(entryItemData2);
		}
		foreach (EntryData additionalEntry2 in armourData.AdditionalEntryList)
		{
			EntryItemData2 entryItemData3 = new EntryItemData2(this, additionalEntry2, showDetail: false);
			entryItemData3.SetExActionName("ExChangeEntry");
			ExchangeEntryList.Add(entryItemData3);
		}
	}

	public void CloseExChangeView()
	{
		IsShowSelected = false;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is EntryItemData2 entryItemData)
			{
				if (optionArg.OptionName.Equals("Selected"))
				{
					SelectedEntryItemData(entryItemData);
				}
				else if (optionArg.OptionName.Equals("UseEntry"))
				{
					IsShowSelected = true;
				}
				else if (optionArg.OptionName.Equals("ExChangeEntry"))
				{
					CheckExChangeEntry(entryItemData);
				}
				else if (optionArg.OptionName.Equals("ShowEntryPanel"))
				{
					ShowEntryDetail(entryItemData);
				}
			}
			else if (optionArg.Obj is EntryExChangeViewModel entryExChangeViewModel && optionArg.OptionName.Equals("Confirm"))
			{
				SendExChangeEntry(entryExChangeViewModel.CurEntryIndex, entryExChangeViewModel.ExchangeEntryIndex);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg context = knapsackItemViewModel.OpenPopupWindow(this);
			openWindowRequest.Raise(context);
		}
		RefreshItemState();
	}

	private void RefreshItemState()
	{
		KnapsackPropData data = KnapsackPropData.Create(propItemData.PropDataBase.Id, propItemData.PropDataBase.Amount);
		propItemData.Refresh(data);
		KnapsackPropData data2 = KnapsackPropData.Create(coinItemData.PropDataBase.Id, coinItemData.PropDataBase.Amount);
		coinItemData.Refresh(data2);
		RefreshResetBtnState();
	}

	private void RefreshResetBtnState()
	{
		bool flag = BackUpEntryList != null && BackUpEntryList.Exists((EntryItemData2 p) => p.IsSelected);
		resetEntryCommand.Enabled = flag && MoneyDefinition.GetMoneyCount(RoleMoneyEnum.ArmourMaterial) >= propItemData.PropDataBase.Amount && MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin) >= CoinItemData.PropDataBase.Amount;
	}

	private void ShowEntryDetail(EntryItemData2 entryItemData2)
	{
		int entryId = entryItemData2.EntryData.DrEntry.EntryId;
		int level = entryItemData2.EntryData.DrEntry.Level;
		EntryItemData entryItemData3 = new EntryItemData(new EntryData(entryId, level));
		EntryItemData entryItemByHero = GetEntryItemByHero(entryItemData3);
		openEntryPanelRequest.Raise(entryItemByHero);
	}

	private EntryItemData GetEntryItemByHero(EntryItemData entryItemData)
	{
		entryItemData.EntryData.IsRealData = true;
		if (heroModel != null)
		{
			List<EntryData> allEntry = heroModel.GetAllEntry();
			for (int i = 0; i < allEntry.Count; i++)
			{
				if (allEntry[i].DrEntry.EntryId == entryItemData.EntryData.DrEntry.EntryId)
				{
					return new EntryItemData(this, allEntry[i]);
				}
			}
		}
		return entryItemData;
	}

	private async void SelectedEntryItemData(EntryItemData2 entryItemData2)
	{
		if (!entryItemData2.IsSelected)
		{
			if (lastEntry != null)
			{
				lastEntry.IsSelected = false;
			}
			entryItemData2.IsSelected = true;
			lastEntry = entryItemData2;
			selectedBackUpEntry.ReSetData(entryItemData2.EntryData);
			if (needDelay)
			{
				await Task.Delay(500);
			}
			RefreshResetBtnState();
		}
	}

	private void CheckExChangeEntry(EntryItemData2 data)
	{
		if (!IsShowSelected)
		{
			return;
		}
		data.SetChoose(value: true);
		int num = -1;
		for (int i = 0; i < ExchangeEntryList.Count; i++)
		{
			if (ExchangeEntryList[i].IsChoose)
			{
				num = i;
				break;
			}
		}
		data.SetChoose(value: false);
		int num2 = -1;
		for (int j = 0; j < BackUpEntryList.Count; j++)
		{
			if (BackUpEntryList[j].IsSelected)
			{
				num2 = j;
				break;
			}
		}
		if (num2 != -1 && num != -1)
		{
			EntryExChangeViewModel userData = new EntryExChangeViewModel(this, data.EntryData, num, SelectedBackUpEntry.EntryData, num2);
			GameEntry.UI.OpenWindow<EntryExChangeWindow>("Equipment/EntryExChangeWindow", userData);
		}
	}

	private async void SendExChangeEntry(int curEntryIndex, int backUpEntryIndex)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ResetArmourEntry(armourUid, curEntryIndex, backUpEntryIndex, 1);
		loading.Dispose();
		if (!num)
		{
			await UIHelper.AccountDisconnect();
		}
		else
		{
			Toast.ShowInfo("更换词条成功");
			IsShowSelected = false;
			resetEntryCommand.Enabled = false;
			SetEntryList();
			refreshBackUpEntryRequest.Raise();
			refreshCurEntryRequest.Raise();
			CurEntryList[curEntryIndex].PlayUIParticle();
		}
		resetEntryCommand.Enabled = false;
	}

	private async void ReSetEntryOnClick()
	{
		if (IsShowSelected)
		{
			return;
		}
		resetEntryCommand.Enabled = false;
		int index = -1;
		for (int i = 0; i < BackUpEntryList.Count; i++)
		{
			if (BackUpEntryList[i].IsSelected)
			{
				index = i;
			}
		}
		if (index == -1)
		{
			resetEntryCommand.Enabled = true;
			return;
		}
		needDelay = true;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ResetArmourEntry(armourUid, 0, index, 2);
		loading.Dispose();
		if (!num)
		{
			await UIHelper.AccountDisconnect();
		}
		else
		{
			SetEntryList();
			refreshBackUpEntryRequest.Raise();
			refreshCurEntryRequest.Raise();
			ItemOnClick(new OptionArg(BackUpEntryList[index], "Selected"));
			foreach (EntryItemData2 backUpEntry in BackUpEntryList)
			{
				backUpEntry.HideUIParticle();
			}
			BackUpEntryList[index].PlayAnimation();
			BackUpEntryList[index].PlayUIParticle();
			RefreshItemState();
		}
		needDelay = false;
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
