using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ArmourDetailViewModel : OptionBase
{
	private ArmourData armourData;

	private string armourEnumName;

	private string leftBtnText;

	private string rightBtnText;

	private List<AttributeItemData> attributeItemList;

	private List<EntryItemData> entryItemDataList;

	private InteractionRequest refreshDataRequest;

	private string actionName;

	private bool isChange;

	private bool isShow;

	private EquipWearerItemData equipWearerItemData;

	private TabItemNormalData lockBtn;

	private bool isRock;

	private Color rankBgColor;

	public int Type;

	private SimpleCommand leftBtnCmd;

	private SimpleCommand rightBtnCmd;

	public ArmourData ArmourData
	{
		get
		{
			return armourData;
		}
		set
		{
			Set(ref armourData, value, "ArmourData");
		}
	}

	public string ArmourEnumName
	{
		get
		{
			return armourEnumName;
		}
		set
		{
			Set(ref armourEnumName, value, "ArmourEnumName");
		}
	}

	public string LeftBtnText
	{
		get
		{
			return leftBtnText;
		}
		set
		{
			Set(ref leftBtnText, value, "LeftBtnText");
		}
	}

	public string RightBtnText
	{
		get
		{
			return rightBtnText;
		}
		set
		{
			Set(ref rightBtnText, value, "RightBtnText");
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

	public List<AttributeItemData> AttributeItemList
	{
		get
		{
			return attributeItemList;
		}
		set
		{
			Set(ref attributeItemList, value, "AttributeItemList");
		}
	}

	public string ActionName
	{
		get
		{
			return actionName;
		}
		set
		{
			Set(ref actionName, value, "ActionName");
		}
	}

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		set
		{
			Set(ref isShow, value, "IsShow");
		}
	}

	public bool IsRock
	{
		get
		{
			return isRock;
		}
		set
		{
			Set(ref isRock, value, "IsRock");
		}
	}

	public Color RankBgColor
	{
		get
		{
			return rankBgColor;
		}
		set
		{
			Set(ref rankBgColor, value, "RankBgColor");
		}
	}

	public TabItemNormalData LockBtn => lockBtn;

	public EquipWearerItemData EquipWearerItemData => equipWearerItemData;

	public InteractionRequest RefreshDataRequest => refreshDataRequest;

	public SimpleCommand LeftBtnCmd => leftBtnCmd;

	public SimpleCommand RightBtnCmd => rightBtnCmd;

	public ArmourDetailViewModel(OptionBase parent, ArmourData armourData)
	{
		base.parent = parent;
		this.armourData = armourData ?? ArmourData.CreateArmourData(93010101);
		isShow = armourData != null;
		entryItemDataList = new List<EntryItemData>();
		attributeItemList = new List<AttributeItemData>();
		refreshDataRequest = new InteractionRequest();
		leftBtnCmd = new SimpleCommand(LeftBtnOnclick);
		rightBtnCmd = new SimpleCommand(RightBtnOnclick);
		RefreshAttribute();
		RefreshEntry();
		InitTabBtn();
		RefreshHeroInfo();
		isRock = ArmourData.ArmourEnum == ArmourEnum.Rock;
		rankBgColor = EquipSlotNew.RankBgColor(ArmourData.Rarity);
	}

	private void InitTabBtn()
	{
		lockBtn = new TabItemNormalData(this, string.Empty);
		if (ArmourData != null)
		{
			lockBtn.IsSelected = ArmourData.IsLock;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				string optionName = ((ArmourData.GetOwnerId() == 0) ? "False" : "True");
				OptionArg obj2 = new OptionArg(optionArg, optionName);
				parent.ItemOnClick(obj2);
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			SwitchTab(tabItemNormalData);
		}
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
				ArmourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(ArmourData.Uid);
				LockBtn.IsSelected = ArmourData.IsLock;
			}
		}
	}

	public void RefreshData(ArmourData armourData)
	{
		if (armourData != null)
		{
			IsShow = true;
			ArmourData = armourData;
			RefreshData();
		}
		else
		{
			IsShow = false;
		}
		ReSetLeftCmd();
		ReSetRightCmd();
	}

	private void RefreshData()
	{
		IsRock = ArmourData.ArmourEnum == ArmourEnum.Rock || ArmourData.EquipmentEnum == EquipmentEnum.SuitBox;
		RankBgColor = EquipSlotNew.RankBgColor(ArmourData.Rarity);
		RightBtnText = (IsRock ? "改造" : "强化");
		lockBtn.IsSelected = ArmourData.IsLock;
		RefreshHeroInfo();
		RefreshAttribute();
		RefreshEntry();
		refreshDataRequest.Raise();
	}

	private void RefreshAttribute()
	{
		if (ArmourData != null)
		{
			AttributeItemList.Clear();
			for (int i = 0; i < ArmourData.GetSubAttribute().Count; i++)
			{
				AttributeItemList.Add(new AttributeItemData(ArmourData.GetSubAttribute()[i]));
			}
		}
	}

	private void RefreshEntry()
	{
		if (ArmourData == null)
		{
			return;
		}
		EntryItemDataList.Clear();
		List<EntryData> allEntry = ArmourData.GetAllEntry();
		for (int i = 0; i < allEntry.Count; i++)
		{
			if (allEntry[i].DrEntry != null)
			{
				EntryItemData entryItemData = new EntryItemData(this, allEntry[i]);
				entryItemData.Type = Type;
				if (ArmourData.ArmourEnum == ArmourEnum.Rock && i == 0)
				{
					entryItemData.IsMainEntry = true;
					entryItemData.EntryData.IsFixed = true;
					entryItemData.SetEntryTextType(1);
				}
				else
				{
					entryItemData.IsMainEntry = false;
				}
				EntryItemDataList.Add(entryItemData);
			}
		}
		int num = ArmourData.AdditionalEntryNum - ArmourData.AdditionalEntryList.Count;
		string text = ((ArmourData.Level == ArmourData.MaxLevel) ? "需要先解锁" : "满级后可解锁");
		for (int j = 0; j < num; j++)
		{
			EntryItemDataList.Add(new EntryItemData(this, text));
		}
	}

	public void RefreshHeroInfo()
	{
		int equipmentOwnerById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetEquipmentOwnerById(ArmourData.Uid);
		if (equipWearerItemData == null)
		{
			equipWearerItemData = new EquipWearerItemData(equipmentOwnerById);
		}
		else
		{
			equipWearerItemData.SetHeroId(equipmentOwnerById);
		}
	}

	private void LeftBtnOnclick()
	{
		leftBtnCmd.Enabled = false;
		ActionName = (isChange ? "Equip" : "Remove");
		parent.ItemOnClick(this);
	}

	private void RightBtnOnclick()
	{
		rightBtnCmd.Enabled = false;
		ActionName = "OpenCultureWindow";
		parent.ItemOnClick(this);
	}

	public void ReSetLeftCmd()
	{
		leftBtnCmd.Enabled = true;
	}

	public void ReSetRightCmd()
	{
		rightBtnCmd.Enabled = true;
	}

	public void SetFunction(bool isChange, string funcBtnText)
	{
		this.isChange = isChange;
		LeftBtnText = funcBtnText;
	}
}
