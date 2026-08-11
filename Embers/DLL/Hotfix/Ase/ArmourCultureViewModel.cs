using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class ArmourCultureViewModel : OptionBase
{
	private ArmourData armourData;

	private ArmourUpgradeViewModel armourUpgradeViewModel;

	private ArmourAffixRefreshViewModel armourAffixRefreshViewModel;

	private ArmourEntryResetViewModel armourEntryResetViewModel;

	private bool isOpeningArmourFilterWindow;

	private InteractionRequest<EntryItemData> showEntryDetailRequest;

	private InteractionRequest refreshArmourShowRequest;

	private InteractionRequest refreshMoneyViewRequest;

	private ArmourPopupViewModel armourPopupViewModel;

	private MoneyData moneyData;

	private HeroModel heroModel;

	private HeroModel curHeroModel;

	private TabItemNormalData armourDetailBtn;

	private TabItemNormalData armourUpgradeBtn;

	private TabItemNormalData armourAffixRefreshBtn;

	private TabItemNormalData armourEntryResetBtn;

	private bool isShowArmourObj;

	private float _windowMaskLeftTime;

	public float WindowMaskLeftTime
	{
		get
		{
			return _windowMaskLeftTime;
		}
		set
		{
			Set(ref _windowMaskLeftTime, value, "WindowMaskLeftTime");
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

	public ArmourUpgradeViewModel ArmourUpgradeViewModel
	{
		get
		{
			return armourUpgradeViewModel;
		}
		private set
		{
			Set(ref armourUpgradeViewModel, value, "ArmourUpgradeViewModel");
		}
	}

	public ArmourAffixRefreshViewModel ArmourAffixRefreshViewModel => armourAffixRefreshViewModel;

	public ArmourEntryResetViewModel ArmourEntryResetViewModel
	{
		get
		{
			return armourEntryResetViewModel;
		}
		private set
		{
			Set(ref armourEntryResetViewModel, value, "ArmourEntryResetViewModel");
		}
	}

	public bool IsShowArmourObj
	{
		get
		{
			return isShowArmourObj;
		}
		private set
		{
			Set(ref isShowArmourObj, value, "IsShowArmourObj");
		}
	}

	public TabItemNormalData ArmourDetailBtn => armourDetailBtn;

	public TabItemNormalData ArmourUpgradeBtn => armourUpgradeBtn;

	public TabItemNormalData ArmourAffixRefreshBtn => armourAffixRefreshBtn;

	public TabItemNormalData ArmourEntryResetBtn => armourEntryResetBtn;

	public ArmourPopupViewModel ArmourPopupViewModel => armourPopupViewModel;

	public MoneyData MoneyData => moneyData;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => showEntryDetailRequest;

	public InteractionRequest RefreshArmourShowRequest => refreshArmourShowRequest;

	public InteractionRequest RefreshMoneyViewRequest => refreshMoneyViewRequest;

	public ArmourCultureViewModel(OptionBase parent, ArmourData armourData, HeroModel heroModel = null, HeroModel curHeroModel = null, bool needOpenDetail = false)
	{
		base.parent = parent;
		this.armourData = armourData;
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		this.heroModel = heroModel;
		this.curHeroModel = curHeroModel;
		armourUpgradeViewModel = new ArmourUpgradeViewModel(this, this.armourData);
		armourAffixRefreshViewModel = new ArmourAffixRefreshViewModel(this, this.armourData);
		armourEntryResetViewModel = new ArmourEntryResetViewModel(this, heroModel, armourData, moneyData);
		armourPopupViewModel = new ArmourPopupViewModel(this, ArmourData, showHeroInfo: true, -81f, 12f, showOutsideMask: false);
		showEntryDetailRequest = new InteractionRequest<EntryItemData>();
		refreshArmourShowRequest = new InteractionRequest();
		refreshMoneyViewRequest = new InteractionRequest();
		isShowArmourObj = false;
		InitTabData(needOpenDetail);
	}

	private void InitTabData(bool needOpenDetail)
	{
		armourDetailBtn = new TabItemNormalData(this, string.Empty);
		armourUpgradeBtn = new TabItemNormalData(this, string.Empty, 1);
		armourAffixRefreshBtn = new TabItemNormalData(this, string.Empty, 2);
		armourEntryResetBtn = new TabItemNormalData(this, string.Empty, 3);
		CheckCanEntryReset();
		TabItemNormalData tabItemNormalData = armourDetailBtn;
		if (!needOpenDetail)
		{
			if (armourUpgradeBtn.IsShow)
			{
				tabItemNormalData = armourUpgradeBtn;
			}
			else if (armourEntryResetBtn.IsShow)
			{
				tabItemNormalData = armourEntryResetBtn;
			}
			else if (armourAffixRefreshBtn.IsShow)
			{
				tabItemNormalData = armourAffixRefreshBtn;
			}
		}
		SwitchTab(tabItemNormalData);
	}

	private void CheckCanEntryReset()
	{
		if (ArmourData.ArmourEnum == ArmourEnum.Rock)
		{
			armourUpgradeBtn.IsShow = false;
			armourAffixRefreshBtn.IsShow = false;
			armourEntryResetBtn.IsShow = false;
		}
		else
		{
			armourEntryResetBtn.IsShow = ArmourData.AdditionalEntryNum > 0 && ArmourData.Level == ArmourData.MaxLevel;
			armourAffixRefreshBtn.IsShow = true;
			armourUpgradeBtn.IsShow = ArmourData.AdditionalEntryNum <= 0 || ArmourData.Level != ArmourData.MaxLevel;
		}
	}

	private async void SwitchTab(TabItemNormalData tabItemNormalData)
	{
		if (tabItemNormalData != null && !tabItemNormalData.IsSelected)
		{
			armourDetailBtn.IsSelected = tabItemNormalData.ID == armourDetailBtn.ID;
			if (armourDetailBtn.IsSelected)
			{
				armourPopupViewModel.RefreshData(ArmourData);
			}
			armourUpgradeBtn.IsSelected = tabItemNormalData.ID == armourUpgradeBtn.ID;
			if (armourUpgradeBtn.IsSelected)
			{
				armourUpgradeViewModel.OnOpen();
			}
			armourAffixRefreshBtn.IsSelected = tabItemNormalData.ID == armourAffixRefreshBtn.ID;
			armourAffixRefreshViewModel.SetVisible(tabItemNormalData.ID == armourAffixRefreshBtn.ID);
			armourEntryResetBtn.IsSelected = tabItemNormalData.ID == armourEntryResetBtn.ID;
			IsShowArmourObj = tabItemNormalData.ID == armourDetailBtn.ID || tabItemNormalData.ID == armourAffixRefreshBtn.ID || tabItemNormalData.ID == armourEntryResetBtn.ID;
			await UniTask.Delay(100);
			armourUpgradeViewModel?.CloseProp();
			refreshMoneyViewRequest.Raise();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ArmourUpgradeViewModel armourUpgradeViewModel)
		{
			RefreshArmour(ArmourData);
			if (armourUpgradeViewModel.ActionName.Equals("LevelMax"))
			{
				CheckCanEntryReset();
				if (armourEntryResetBtn.IsShow)
				{
					SwitchTab(armourEntryResetBtn);
				}
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			SwitchTab(tabItemNormalData);
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.OptionName.Equals("UpdateWindowMaskTime") && optionArg.Obj is float newLeftTime)
			{
				UpdateWindowMaskLeftTime(newLeftTime);
			}
			else if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				if (optionArg.Obj is EntryItem entryItem)
				{
					ShowEntryDetail(entryItem.ViewModel);
				}
				else if (optionArg.Obj is EntryItem2 entryItem2)
				{
					ShowEntryDetail(entryItem2.ViewModel);
				}
			}
			else if (optionArg.OptionName.Equals("ChangeArmourTab"))
			{
				ChangeArmour(armourEntryResetViewModel.ArmourEnum);
			}
			else if (optionArg.OptionName.Equals("RefreshData"))
			{
				RefreshArmour();
			}
			else
			{
				if (!optionArg.OptionName.Equals("OpenArmourFilterWindow"))
				{
					return;
				}
				object obj2 = optionArg.Obj;
				ArmourAffixRefreshViewModel armourAffixRefreshVm = obj2 as ArmourAffixRefreshViewModel;
				if (armourAffixRefreshVm != null)
				{
					OpenArmourFilterWindow(new List<long> { armourAffixRefreshVm.ArmourData.Uid }, delegate
					{
						armourAffixRefreshVm.OpenWindowRst.Enabled = true;
					});
				}
			}
		}
	}

	private async void OpenArmourFilterWindow(List<long> blockList = null, Action cb = null)
	{
		if (isOpeningArmourFilterWindow)
		{
			return;
		}
		List<KnapsackItemViewModel> armourItems = ArmourFilterDataUtil.BuildArmourItemsForDecomposeWindow(this, out var hasDecomposeable, KnapsackDefinition.WarehouseScreenType.Rarity, blockList);
		if (armourItems.Count <= 0 || !hasDecomposeable)
		{
			Toast.ShowInfo("当前没有可分解的装备");
			cb?.Invoke();
			return;
		}
		isOpeningArmourFilterWindow = true;
		ArmourFilterViewModel armourFilterViewModel = new ArmourFilterViewModel(this, armourItems, await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetEquipmentDecomposePreferences(EquipmentEnum.Armour));
		armourFilterViewModel.SetBlockList(blockList);
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourFilterWindow), armourFilterViewModel), delegate
		{
			isOpeningArmourFilterWindow = false;
			cb?.Invoke();
		});
	}

	private void ChangeArmour(ArmourEnum armourEnum)
	{
		ArmourData armourData = heroModel.Armours[(int)armourEnum];
		ArmourData = armourData;
		RefreshArmour(ArmourData);
	}

	private void ShowEntryDetail(EntryItemData entryItemData)
	{
		entryItemData.SetSelect(isSelect: true);
		entryItemData.Type = 1;
		EntryItemData entryItemByHero = GetEntryItemByHero(entryItemData);
		showEntryDetailRequest.Raise(entryItemByHero);
	}

	private void ShowEntryDetail(EntryItemData2 entryItemData2)
	{
		int entryId = entryItemData2.EntryData.DrEntry.EntryId;
		int level = entryItemData2.EntryData.DrEntry.Level;
		EntryItemData entryItemData3 = new EntryItemData(new EntryData(entryId, level));
		EntryItemData entryItemByHero = GetEntryItemByHero(entryItemData3);
		entryItemByHero.Type = 2;
		showEntryDetailRequest.Raise(entryItemByHero);
	}

	private EntryItemData GetEntryItemByHero(EntryItemData entryItemData)
	{
		entryItemData.EntryData.IsRealData = true;
		if (curHeroModel != null && curHeroModel.Id == ArmourData.GetOwnerId())
		{
			List<EntryData> allEntry = heroModel.GetAllEntry();
			for (int i = 0; i < allEntry.Count; i++)
			{
				if (allEntry[i].DrEntry.EntryId == entryItemData.EntryData.DrEntry.EntryId)
				{
					entryItemData.AllLevel = allEntry[i].CurLevel;
					return entryItemData;
				}
			}
		}
		return entryItemData;
	}

	private void RefreshArmour(ArmourData data = null)
	{
		if (data == null)
		{
			ArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(ArmourData.Uid);
		}
		armourUpgradeViewModel?.RefreshArmour(ArmourData);
		armourPopupViewModel?.RefreshData(ArmourData);
		armourAffixRefreshViewModel?.RefreshArmour(ArmourData);
		ArmourEntryResetViewModel?.RefreshData(ArmourData);
		RefreshArmourShowRequest.Raise();
	}

	private void UpdateWindowMaskLeftTime(float newLeftTime)
	{
		if (!(WindowMaskLeftTime >= newLeftTime))
		{
			WindowMaskLeftTime = newLeftTime;
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		ArmourUpgradeViewModel?.CloseProp();
		base.Close();
	}
}
