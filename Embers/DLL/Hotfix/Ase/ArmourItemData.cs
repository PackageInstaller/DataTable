using UnityEngine;

namespace Ase;

public class ArmourItemData : KnapsackItemViewModel
{
	private ArmourData data;

	private Color lockFrameColor;

	private Color lockBgColor;

	private string entryIconPath;

	private int flag;

	private int conditionCount;

	private bool isInCurrentPresetSlot;

	public ArmourData Data
	{
		get
		{
			return data;
		}
		set
		{
			Set(ref data, value, "Data");
		}
	}

	public int Flag
	{
		get
		{
			return flag;
		}
		set
		{
			Set(ref flag, value, "Flag");
		}
	}

	public int ConditionCount
	{
		get
		{
			return conditionCount;
		}
		set
		{
			Set(ref conditionCount, value, "ConditionCount");
		}
	}

	public string EntryIconPath => entryIconPath;

	public Color LockFrameColor => lockFrameColor;

	public Color LockBgColor => lockBgColor;

	public bool IsInCurrentPresetSlot
	{
		get
		{
			return isInCurrentPresetSlot;
		}
		set
		{
			Set(ref isInCurrentPresetSlot, value, "IsInCurrentPresetSlot");
		}
	}

	public ArmourItemData(OptionBase parent, ArmourData data, int heroId = 0, bool isActive = false)
		: base(parent, data)
	{
		this.data = data;
		base.New = data.New;
		SetOwnerId(heroId);
		ShowOwner = true;
		base.IsActive = isActive;
		lockFrameColor = ArmourLockFrameColor(data.Rarity);
		lockBgColor = ArmourLockBgColor(data.Rarity);
		entryIconPath = ((data.GetAllEntry().Count <= 0) ? "empty" : (data.GetAllEntry()[0].IconPath + "_Rock"));
	}

	public void RefreshOwnerInfo()
	{
		if (Data == null || Data.Empty)
		{
			SetOwnerId(0);
			return;
		}
		int ownerId = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetEquipmentOwnerById(Data.Uid) ?? 0;
		SetOwnerId(ownerId);
	}

	public static Color ArmourLockBgColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 0:
			htmlString = "#3c3c3c";
			break;
		case 1:
			htmlString = "#1e3942";
			break;
		case 2:
			htmlString = "#232c4c";
			break;
		case 3:
			htmlString = "#312944";
			break;
		case 4:
			htmlString = "#4a2519";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public static Color ArmourLockFrameColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 0:
			htmlString = "#d7d7d7";
			break;
		case 1:
			htmlString = "#c6e3d4";
			break;
		case 2:
			htmlString = "#e6ecff";
			break;
		case 3:
			htmlString = "#e6ecff";
			break;
		case 4:
			htmlString = "#fbd295";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}
}
