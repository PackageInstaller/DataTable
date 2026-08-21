using System;
using UnityEngine;

namespace Ase;

public class KnapsackItemViewModel : OptionBase
{
	private bool _new;

	private bool _customTag;

	private PropDataBase _propDataBase;

	protected bool _isSelected;

	protected bool _isToggleOn;

	protected bool _isActive = true;

	private int _quality;

	private int _lev;

	protected int _ownerId;

	protected string _ownerIcon = "1104_Upgrade";

	public bool ShowOwner;

	public bool ShowName;

	public bool ShowOwnedAndRequiredCount;

	public bool ShowShortageState;

	private int exValue;

	private string exValueText;

	private string entryIcon;

	private bool _showArmourRank;

	private Color _armourRankColor;

	private string _armourRankText;

	private string _armourTypeIcon = "";

	public bool New
	{
		get
		{
			return _new;
		}
		set
		{
			Set(ref _new, value && _ownerId <= 0, "New");
		}
	}

	public bool CustomTag
	{
		get
		{
			return _customTag;
		}
		set
		{
			Set(ref _customTag, value, "CustomTag");
		}
	}

	public PropDataBase PropDataBase
	{
		get
		{
			_propDataBase = _propDataBase ?? new PropDataBase();
			return _propDataBase;
		}
		private set
		{
			Set(ref _propDataBase, value, "PropDataBase");
			if (value != null)
			{
				New = value.New;
			}
		}
	}

	public int Quality
	{
		get
		{
			return _quality;
		}
		set
		{
			Set(ref _quality, value, "Quality");
		}
	}

	public int Lev
	{
		get
		{
			return _lev;
		}
		set
		{
			Set(ref _lev, value, "Lev");
		}
	}

	public int OwnerId
	{
		get
		{
			return _ownerId;
		}
		protected set
		{
			Set(ref _ownerId, value, "OwnerId");
			New = New;
		}
	}

	public string OwnerIcon
	{
		get
		{
			return _ownerIcon;
		}
		set
		{
			Set(ref _ownerIcon, value, "OwnerIcon");
		}
	}

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public bool IsToggleOn
	{
		get
		{
			return _isToggleOn;
		}
		set
		{
			Set(ref _isToggleOn, value, "IsToggleOn");
		}
	}

	public bool IsActive
	{
		get
		{
			return _isActive;
		}
		set
		{
			Set(ref _isActive, value, "IsActive");
		}
	}

	public int ExValue
	{
		get
		{
			return exValue;
		}
		set
		{
			Set(ref exValue, value, "ExValue");
		}
	}

	public string ExValueText
	{
		get
		{
			return exValueText;
		}
		set
		{
			Set(ref exValueText, value, "ExValueText");
		}
	}

	public string EntryIcon
	{
		get
		{
			return entryIcon;
		}
		set
		{
			Set(ref entryIcon, value, "EntryIcon");
		}
	}

	public bool ShowArmourRank
	{
		get
		{
			return _showArmourRank;
		}
		set
		{
			Set(ref _showArmourRank, value, "ShowArmourRank");
		}
	}

	public Color ArmourRankColor
	{
		get
		{
			return _armourRankColor;
		}
		set
		{
			Set(ref _armourRankColor, value, "ArmourRankColor");
		}
	}

	public string ArmourRankText
	{
		get
		{
			return _armourRankText;
		}
		set
		{
			Set(ref _armourRankText, value, "ArmourRankText");
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

	public KnapsackItemViewModel()
	{
	}

	public KnapsackItemViewModel(OptionBase parent, bool showOwner = false, bool showName = false, bool showOwnedAndRequiredCount = false)
	{
		base.parent = parent;
		ShowOwner = showOwner;
		ShowName = showName;
		ShowOwnedAndRequiredCount = showOwnedAndRequiredCount;
	}

	public KnapsackItemViewModel(OptionBase parent, PropDataBase data, bool showOwner = false, bool showName = false, bool showOwnedAndRequiredCount = false)
	{
		base.parent = parent;
		ShowOwner = showOwner;
		ShowName = showName;
		ShowOwnedAndRequiredCount = showOwnedAndRequiredCount;
		ExValue = data?.ExValue ?? 0;
		Refresh(data);
	}

	public void Refresh(PropDataBase data)
	{
		PropDataBase = data;
		RefreshData();
	}

	private void RefreshData()
	{
		if (PropDataBase.PropTypeEnum == PropTypeEnum.Prop || PropDataBase.PropTypeEnum == PropTypeEnum.Coin || PropDataBase.PropTypeEnum == PropTypeEnum.AccountExp || PropDataBase.PropTypeEnum == PropTypeEnum.Energy || PropDataBase.PropTypeEnum == PropTypeEnum.GiftPack || PropDataBase.PropTypeEnum == PropTypeEnum.Passport || PropDataBase.PropTypeEnum == PropTypeEnum.HeroSkillSkinProp)
		{
			Quality = PropDataBase.Quality;
			SetOwnerId(0);
		}
		else if (PropDataBase.PropTypeEnum == PropTypeEnum.Equipment || PropDataBase.PropTypeEnum == PropTypeEnum.Weapon || PropDataBase.PropTypeEnum == PropTypeEnum.SuitBox)
		{
			EquipmentDataBase equipmentDataBase = (EquipmentDataBase)PropDataBase;
			Quality = equipmentDataBase.Rarity;
			Lev = equipmentDataBase.Level;
			PropDataBase.Amount = Lev;
			if (ShowOwner)
			{
				SetOwnerId(equipmentDataBase.GetOwnerId());
			}
			if (PropDataBase.PropTypeEnum == PropTypeEnum.SuitBox)
			{
				EntryIcon = "MainEntryIcon_0000_Rock";
				if (equipmentDataBase.EntryDataList.Count > 0)
				{
					EntryIcon = equipmentDataBase.EntryDataList[0].IconPath + "_Rock";
				}
				else
				{
					DRSuitbox drSuitbox = GameEntry.DataTable.GetDataRow<DRSuitbox>(equipmentDataBase.Id);
					if (drSuitbox != null)
					{
						DRSuitboxMainStore[] dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.StoreId == drSuitbox.BuffPool);
						if (dataRows != null && dataRows.Length == 1)
						{
							EntryData entryData = new EntryData(dataRows[0].EntryId, dataRows[0].EntryLv);
							EntryIcon = (entryData.IsRealData ? (entryData.IconPath + "_Rock") : "MainEntryIcon_0000_Rock");
						}
					}
				}
			}
		}
		else if (PropDataBase.PropTypeEnum == PropTypeEnum.Title)
		{
			Quality = 3;
		}
		else if (PropDataBase.PropTypeEnum == PropTypeEnum.HeadDecorate)
		{
			Quality = 3;
		}
		else
		{
			Quality = PropDataBase.Quality;
		}
		CustomTag = PropDataBase?.CustomTag ?? false;
		RefreshArmourRank();
	}

	protected void SetOwnerId(int ownerId)
	{
		OwnerId = ownerId;
		if (ownerId != 0)
		{
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(ownerId);
			if (heroById != null)
			{
				OwnerIcon = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, heroById);
				return;
			}
		}
		OwnerIcon = "";
	}

	protected void SetOwnerId(HeroModel heroModel)
	{
		if (heroModel == null)
		{
			OwnerId = 0;
			OwnerIcon = "";
		}
		else
		{
			OwnerId = heroModel.Id;
			OwnerIcon = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, heroModel);
		}
	}

	private void RefreshArmourRank()
	{
		if (PropDataBase == null || PropDataBase.Empty)
		{
			ShowArmourRank = false;
			return;
		}
		ArmourTypeIcon = "";
		if (PropDataBase is ArmourData armourData)
		{
			ShowArmourRank = true;
			ArmourRankColor = EquipSlotNew.RankBgColor(armourData.Rarity);
			ArmourRankText = $"R{armourData.Rank}";
		}
		else if (PropDataBase is PropData propData && propData.UseType.Contains(21))
		{
			DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(PropDataBase.Id);
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
			ArmourRankColor = EquipSlotNew.RankBgColor(dataRow2.Rarity);
			ArmourRankText = $"R{dataRow2.RankMin}";
			ArmourTypeIcon = $"ArmourEnum_{dataRow2.Position}";
		}
		else
		{
			ShowArmourRank = false;
		}
	}

	public virtual void OnClick()
	{
		if (base.Parent != null)
		{
			parent.ItemOnClick(this);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg && optionArg.Obj is ArmourPopupViewModel && optionArg.OptionName.Equals("Close"))
		{
			parent?.ItemOnClick(new OptionArg(this, "Close'"));
		}
	}

	public OpenViewArg OpenPopupWindow(OptionBase parent, Action callBack = null, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true, string groupName = "DEFAULT")
	{
		return PropHelper.OpenPopupWindow(PropDataBase, parent, callBack, showOutsideMask, showOwnCount, allowSkipWindow, groupName);
	}

	public override void Dispose()
	{
		base.Dispose();
		PropDataBase = null;
	}
}
