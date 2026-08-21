using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ArmourPopupViewModel : OptionBase
{
	private ArmourData armourData;

	private string type;

	private Vector2 showPos;

	private Vector2 entryInfoPos;

	private EquipWearerItemData equipWearerItemData;

	private List<AttributeItemData> attributeItemDataList;

	private List<EntryItemData> entryItemData;

	private InteractionRequest refreshDataRequest;

	private InteractionRequest<EntryItem> showEntryDetailRequest;

	private TabItemNormalData lockBtn;

	private bool _showOutsideMask = true;

	private bool _showOutsideMask2 = true;

	private bool _showLockBtn = true;

	public ArmourData ArmourData
	{
		get
		{
			return armourData ?? (armourData = ArmourData.CreateEmpty());
		}
		private set
		{
			Set(ref armourData, value, "ArmourData");
		}
	}

	public string Type
	{
		get
		{
			return type;
		}
		private set
		{
			Set(ref type, value, "Type");
		}
	}

	public List<EntryItemData> EntryItemData
	{
		get
		{
			return entryItemData;
		}
		set
		{
			Set(ref entryItemData, value, "EntryItemData");
		}
	}

	public List<AttributeItemData> AttributeItemDataList
	{
		get
		{
			return attributeItemDataList;
		}
		set
		{
			Set(ref attributeItemDataList, value, "AttributeItemDataList");
		}
	}

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

	public Vector2 EntryInfoPos
	{
		get
		{
			return entryInfoPos;
		}
		set
		{
			Set(ref entryInfoPos, value, "EntryInfoPos");
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

	public bool ShowOutsideMask2
	{
		get
		{
			return _showOutsideMask2;
		}
		set
		{
			Set(ref _showOutsideMask2, value, "ShowOutsideMask2");
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

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => showEntryDetailRequest;

	public InteractionRequest RefreshDataRequest => refreshDataRequest;

	public EquipWearerItemData EquipWearerItemData => equipWearerItemData;

	public TabItemNormalData LockBtn => lockBtn;

	public ArmourPopupViewModel()
	{
	}

	public ArmourPopupViewModel(OptionBase parent, bool showHeroInfo = false, float posX = 0f, float posY = 0f, bool showOutsideMask = true, bool showOutsideMask2 = false)
	{
		base.parent = parent;
		refreshDataRequest = new InteractionRequest();
		entryItemData = new List<EntryItemData>();
		attributeItemDataList = new List<AttributeItemData>();
		showEntryDetailRequest = new InteractionRequest<EntryItem>();
		ShowPos = new Vector2(posX, posY);
		InitTabBtn();
		equipWearerItemData = new EquipWearerItemData(0);
		RefreshHeroInfo();
		ShowOutsideMask = showOutsideMask;
		ShowOutsideMask2 = showOutsideMask2;
	}

	public ArmourPopupViewModel(OptionBase parent, ArmourData armourData, bool showHeroInfo = false, float posX = 0f, float posY = 0f, bool showOutsideMask = true, bool showOutsideMask2 = false)
	{
		base.parent = parent;
		refreshDataRequest = new InteractionRequest();
		entryItemData = new List<EntryItemData>();
		attributeItemDataList = new List<AttributeItemData>();
		showEntryDetailRequest = new InteractionRequest<EntryItem>();
		ShowPos = new Vector2(posX, posY);
		InitTabBtn();
		RefreshData(armourData, needRefresh: false);
		equipWearerItemData = new EquipWearerItemData(0);
		RefreshHeroInfo();
		ShowOutsideMask = showOutsideMask;
		ShowOutsideMask2 = showOutsideMask2;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				showEntryDetailRequest.Raise(optionArg.Obj as EntryItem);
				parent.ItemOnClick(optionArg);
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			SwitchTab(tabItemNormalData);
		}
	}

	private void InitTabBtn()
	{
		lockBtn = new TabItemNormalData(this, string.Empty);
	}

	private async void SwitchTab(TabItemNormalData tabItemNormalData)
	{
		if (tabItemNormalData.ID == 0)
		{
			int type = ((ArmourData.ArmourEnum == ArmourEnum.Rock) ? 16 : 2);
			Loading loading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ChangeLock(type, ArmourData.Uid);
			loading.Dispose();
			if (num)
			{
				LockBtn.SetSelected(!LockBtn.IsSelected);
				parent?.ItemOnClick(new OptionArg(this, "ChangeLock"));
			}
		}
	}

	private void RefreshHeroInfo()
	{
		int equipmentOwnerById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetEquipmentOwnerById(ArmourData.Uid);
		equipWearerItemData?.SetHeroId(equipmentOwnerById);
	}

	public void Hide()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		visibleRequest.Raise(context: false);
	}

	public void RefreshData(ArmourData data, bool needRefresh = true)
	{
		if (data == null)
		{
			visibleRequest.Raise(context: false);
			return;
		}
		ArmourData = data;
		lockBtn.IsSelected = ArmourData.IsLock;
		Type = UiConvert.Equip.ArmourEnum2Name[data.ArmourEnum];
		visibleRequest.Raise(context: true);
		EntryItemData.Clear();
		List<EntryData> allEntry = ArmourData.GetAllEntry();
		for (int i = 0; i < allEntry.Count; i++)
		{
			EntryItemData item = new EntryItemData(this, allEntry[i]);
			EntryItemData.Add(item);
		}
		int num = ArmourData.AdditionalEntryNum - ArmourData.AdditionalEntryList.Count;
		string text = ((ArmourData.Level == ArmourData.MaxLevel) ? "需要先解锁" : "满级后可解锁");
		for (int j = 0; j < num; j++)
		{
			EntryItemData.Add(new EntryItemData(this, text));
		}
		AttributeItemDataList.Clear();
		List<EquipAttribute> subAttribute = ArmourData.GetSubAttribute();
		for (int k = 0; k < subAttribute.Count; k++)
		{
			AttributeItemDataList.Add(new AttributeItemData(subAttribute[k]));
		}
		RefreshHeroInfo();
		if (needRefresh)
		{
			refreshDataRequest.Raise();
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}
}
