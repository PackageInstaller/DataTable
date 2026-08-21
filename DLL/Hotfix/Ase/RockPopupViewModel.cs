using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class RockPopupViewModel : OptionBase
{
	private Vector2 showPos;

	private bool _showOutsideMask = true;

	private bool _showLockBtn = true;

	private ArmourData armourData;

	private string entryIconPath;

	private List<RockDevelopEntryItemData> developEntryItemDataList = new List<RockDevelopEntryItemData>();

	private List<EntryItemData> entryItemDataList = new List<EntryItemData>();

	private int titleType;

	private int index;

	private bool isSelect;

	private TabItemNormalData lockBtn;

	private InteractionRequest refreshEntryRequest = new InteractionRequest();

	private InteractionRequest getPositionXRequest = new InteractionRequest();

	private InteractionRequest<EntryItemData> showEntryDetailRequest = new InteractionRequest<EntryItemData>();

	private InteractionRequest hideEntryDetailRequest = new InteractionRequest();

	private EntryItemData entryItemData;

	private float positionX;

	private EquipWearerItemData equipWearerItemData;

	private bool showTotalEntryLevel;

	public Vector2 ShowPos
	{
		get
		{
			return showPos;
		}
		set
		{
			Set(ref showPos, value, "ShowPos");
		}
	}

	public bool ShowOutsideMask
	{
		get
		{
			return _showOutsideMask;
		}
		set
		{
			Set(ref _showOutsideMask, value, "ShowOutsideMask");
		}
	}

	public bool ShowLockBtn
	{
		get
		{
			return _showLockBtn;
		}
		set
		{
			Set(ref _showLockBtn, value, "ShowLockBtn");
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

	public string EntryIconPath
	{
		get
		{
			return entryIconPath;
		}
		set
		{
			Set(ref entryIconPath, value, "EntryIconPath");
		}
	}

	public List<RockDevelopEntryItemData> DevelopEntryItemDataList
	{
		get
		{
			return developEntryItemDataList;
		}
		set
		{
			Set(ref developEntryItemDataList, value, "DevelopEntryItemDataList");
		}
	}

	public List<EntryItemData> EntryItemDataList
	{
		get
		{
			return entryItemDataList;
		}
		set
		{
			Set(ref entryItemDataList, value, "EntryItemDataList");
		}
	}

	public int TitleType
	{
		get
		{
			return titleType;
		}
		set
		{
			Set(ref titleType, value, "TitleType");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public int Index => index;

	public InteractionRequest RefreshEntryRequest => refreshEntryRequest;

	public InteractionRequest<EntryItemData> ShowEntryDetailRequest => showEntryDetailRequest;

	public InteractionRequest HideEntryDetailRequest => hideEntryDetailRequest;

	public float PositionX => positionX;

	public EntryItemData EntryItemData => entryItemData;

	public InteractionRequest GetPositionXRequest => getPositionXRequest;

	public TabItemNormalData LockBtn => lockBtn;

	public EquipWearerItemData EquipWearerItemData => equipWearerItemData;

	public RockPopupViewModel()
	{
	}

	public RockPopupViewModel(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		this.armourData = armourData;
		entryIconPath = ResolveEntryIconPath(this.armourData);
		lockBtn = new TabItemNormalData(this, "", 0, armourData.IsLock);
		equipWearerItemData = new EquipWearerItemData(0);
		RefreshHeroInfo();
	}

	public RockPopupViewModel(OptionBase parent, Vector2 pos, bool showOutsideMask = true)
	{
		base.parent = parent;
		ShowPos = pos;
		ShowOutsideMask = showOutsideMask;
		armourData = ArmourData.CreateEmpty();
		lockBtn = new TabItemNormalData(this, "");
		LoadDefaultEntry();
		entryIconPath = ResolveEntryIconPath(armourData);
		equipWearerItemData = new EquipWearerItemData(0);
		RefreshHeroInfo();
	}

	public void RefreshData(ArmourData armourData)
	{
		ArmourData = armourData;
		LoadDefaultEntry();
		EntryIconPath = ResolveEntryIconPath(ArmourData);
		lockBtn.IsSelected = armourData.IsLock;
		refreshEntryRequest.Raise();
		RefreshHeroInfo();
	}

	public void SetShowTotalEntryLevel(bool show)
	{
		showTotalEntryLevel = show;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				entryItemData?.SetSelect(isSelect: false);
				getPositionXRequest.Raise();
				if (optionArg.Obj is EntryItem entryItem)
				{
					entryItemData = entryItem.ViewModel;
				}
				else
				{
					entryItemData = (EntryItemData)optionArg.Obj;
				}
				entryItemData.SetSelect(isSelect: true);
				if (showTotalEntryLevel)
				{
					showEntryDetailRequest.Raise(GetEntryItemByHero(entryItemData));
				}
				else
				{
					showEntryDetailRequest.Raise(entryItemData);
				}
				parent?.ItemOnClick(new OptionArg(this, "OnShowEntryPanel"));
			}
		}
		else if (obj is TabItemNormalData { ID: 0 })
		{
			ChangeLock();
		}
	}

	private EntryItemData GetEntryItemByHero(EntryItemData entryItemData)
	{
		if (ArmourData == null || ArmourData.Empty)
		{
			return entryItemData;
		}
		int ownerId = ArmourData.GetOwnerId();
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
		entryItemData.EntryData.IsRealData = true;
		if (!heroById.IsNullOrEmpty())
		{
			List<EntryData> allEntry = heroById.GetAllEntry();
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

	private async void ChangeLock()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ChangeLock(16, ArmourData.Uid);
		loading.Dispose();
		if (num)
		{
			LockBtn.SetSelected(!LockBtn.IsSelected);
			parent?.ItemOnClick(new OptionArg(this, "ChangeLock"));
		}
	}

	public void ChangeLockState()
	{
		LockBtn.IsSelected = ArmourData.IsLock;
	}

	private string ResolveEntryIconPath(ArmourData data)
	{
		if (data == null)
		{
			return "MainEntryIcon_0000_Rock";
		}
		if (data.EntryDataList != null && data.EntryDataList.Count > 0 && data.EntryDataList[0] != null)
		{
			return data.EntryDataList[0].IconPath + "_Rock";
		}
		DRSuitbox drSuitbox = GameEntry.DataTable.GetDataRow<DRSuitbox>(data.Id);
		if (drSuitbox != null)
		{
			DRSuitboxMainStore[] dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.StoreId == drSuitbox.BuffPool);
			if (dataRows != null && dataRows.Length == 1)
			{
				EntryData entryData = new EntryData(dataRows[0].EntryId, dataRows[0].EntryLv);
				if (entryData.IsRealData)
				{
					return entryData.IconPath + "_Rock";
				}
			}
		}
		return "MainEntryIcon_0000_Rock";
	}

	public void LoadDefaultEntry()
	{
		EntryItemDataList.Clear();
		foreach (EntryData entryData in ArmourData.EntryDataList)
		{
			EntryItemData entryItemData = new EntryItemData(this, entryData);
			entryItemData.SetEntryTextType(1);
			entryItemData.IsMainEntry = true;
			EntryItemDataList.Add(entryItemData);
		}
		foreach (EntryData additionalEntry in ArmourData.AdditionalEntryList)
		{
			EntryItemDataList.Add(new EntryItemData(this, additionalEntry));
		}
	}

	public void RefreshArmourData()
	{
		ArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(ArmourData.Uid);
		LoadDefaultEntry();
		refreshEntryRequest.Raise();
	}

	public void CloseEffect()
	{
		foreach (EntryItemData entryItemData in EntryItemDataList)
		{
			entryItemData.CloseEffect();
		}
	}

	public void PlayNewEntryEffect()
	{
		Dictionary<int, int> oldEntryDic = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetOldEntryDic();
		for (int i = 0; i < EntryItemDataList.Count; i++)
		{
			oldEntryDic.TryGetValue(EntryItemDataList[i].EntryData.DrEntry.EntryId, out var value);
			int effectIndex = 0;
			if (value == 0)
			{
				effectIndex = 1;
			}
			else if (EntryItemDataList[i].EntryData.CurLevel > value)
			{
				effectIndex = 2;
			}
			else if (EntryItemDataList[i].EntryData.CurLevel < value)
			{
				effectIndex = 3;
			}
			EntryItemDataList[i].SetEffectIndex(effectIndex);
		}
		foreach (EntryItemData entryItemData in EntryItemDataList)
		{
			entryItemData.PlayEffect();
		}
	}

	public void LoadDevelopEntry(List<RockDevelopEntryItemData> developEntryList, int index = -1)
	{
		developEntryItemDataList = developEntryList;
		developEntryList[0].SetEntryTextType(1);
		foreach (RockDevelopEntryItemData developEntryItemData in developEntryItemDataList)
		{
			developEntryItemData.SetParent(this);
		}
		this.index = index;
		titleType = GetRockPopupTitle(developEntryList);
	}

	private int GetRockPopupTitle(List<RockDevelopEntryItemData> developEntryList)
	{
		foreach (RockDevelopEntryItemData developEntry in developEntryList)
		{
			if (developEntry.IsNewEntry)
			{
				return 2;
			}
		}
		return 1;
	}

	public void SetSelect(bool select)
	{
		IsSelect = select;
	}

	public void Hide()
	{
		parent?.ItemOnClick(new OptionArg(this, "Hide"));
	}

	public void SelectOnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "Select"));
	}

	public void SetPositionX(float originalX)
	{
		positionX = ((originalX <= 0f) ? (originalX + 805f) : (originalX - 235f));
	}

	private void RefreshHeroInfo()
	{
		int equipmentOwnerById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetEquipmentOwnerById(ArmourData.Uid);
		equipWearerItemData?.SetHeroId(equipmentOwnerById);
	}
}
