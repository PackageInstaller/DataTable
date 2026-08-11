using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardChooseItemViewModel : OptionBase
{
	private string objPath;

	private string framePath;

	private string frameMask;

	private bool isSelected;

	private int index;

	private int type;

	private string itemName;

	private string typeImg;

	private string typeName;

	private string tageName;

	private string tageType;

	private Color tagNameColor;

	private Color tagTypeColor;

	private DrawCardItemInfo drawCardItemInfo;

	private List<DrawCardTagItemData> drawCardTagItemDataList;

	private bool showDark;

	private InteractionRequest refreshSizeRequest;

	private string moveAction;

	public string ObjPath
	{
		get
		{
			return objPath;
		}
		private set
		{
			Set(ref objPath, value, "ObjPath");
		}
	}

	public string FramePath
	{
		get
		{
			return framePath;
		}
		private set
		{
			Set(ref framePath, value, "FramePath");
		}
	}

	public string FrameMask
	{
		get
		{
			return frameMask;
		}
		private set
		{
			Set(ref frameMask, value, "FrameMask");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public int Index => index;

	public int Type => type;

	public DrawCardItemInfo DrawCardItemInfo => drawCardItemInfo;

	public string ItemName
	{
		get
		{
			return itemName;
		}
		private set
		{
			Set(ref itemName, value, "ItemName");
		}
	}

	public string TypeImg
	{
		get
		{
			return typeImg;
		}
		private set
		{
			Set(ref typeImg, value, "TypeImg");
		}
	}

	public string TypeName
	{
		get
		{
			return typeName;
		}
		private set
		{
			Set(ref typeName, value, "TypeName");
		}
	}

	public List<DrawCardTagItemData> DrawCardTagItemDataList
	{
		get
		{
			return drawCardTagItemDataList;
		}
		private set
		{
			Set(ref drawCardTagItemDataList, value, "DrawCardTagItemDataList");
		}
	}

	public bool ShowDark
	{
		get
		{
			return showDark;
		}
		private set
		{
			Set(ref showDark, value, "ShowDark");
		}
	}

	public string MoveAction => moveAction;

	public InteractionRequest RefreshSizeRequest => refreshSizeRequest;

	public DrawCardChooseItemViewModel(OptionBase parent, DrawCardItemInfo drawCardItemInfo, int index)
	{
		base.parent = parent;
		this.index = index;
		refreshSizeRequest = new InteractionRequest();
		this.drawCardItemInfo = drawCardItemInfo;
		isSelected = false;
		objPath = drawCardItemInfo.PrefabPath;
		type = DrawCardItemInfo.Type;
		DrawCardTagItemDataList = new List<DrawCardTagItemData>();
		if (Type == 5)
		{
			LoadWeaponConfig();
		}
		else
		{
			LoadHeroConfig();
		}
		showDark = false;
	}

	public void Select()
	{
		parent?.ItemOnClick(new OptionArg(this, "Select"));
	}

	public void Confirm()
	{
		parent?.ItemOnClick(new OptionArg(this, "Confirm"));
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
		ShowDark = !value;
	}

	public void Move(string moveAction)
	{
		this.moveAction = moveAction;
		refreshSizeRequest.Raise();
	}

	private void LoadWeaponConfig()
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(DrawCardItemInfo.Id);
		if (dataRow == null)
		{
			Toast.ShowError($"Id:{DrawCardItemInfo.Id}的武魂数据未找到!");
			return;
		}
		ItemName = dataRow.Name;
		TypeImg = $"WeaponIcon_{(int)dataRow.WeaponEnum}";
		TypeName = UiConvert.Equip.WeaponEnum2Name[dataRow.WeaponEnum];
		if (dataRow.Tag.Count != dataRow.TagColor.Count)
		{
			Toast.ShowError("武魂Tag数量/颜色不匹配");
			return;
		}
		for (int i = 0; i < dataRow.Tag.Count; i++)
		{
			DrawCardTagItemDataList.Add(new DrawCardTagItemData(this, dataRow.Tag[i], dataRow.TagColor[i]));
		}
	}

	private void LoadHeroConfig()
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataTable<DRHeroInfo>().GetDataRow(DrawCardItemInfo.Id);
		if (dataRow == null)
		{
			Toast.ShowError($"Id:{DrawCardItemInfo.Id}的英雄数据未找到!");
			return;
		}
		ItemName = dataRow.Name;
		TypeImg = $"hero_attr_{(int)dataRow.HeroAttributeEnum}";
		TypeName = UiConvert.Hero.Attribute2Name[dataRow.HeroAttributeEnum];
		if (dataRow.Tag.Count != dataRow.TagColor.Count)
		{
			Toast.ShowError("英雄Tag数量/颜色不匹配");
			return;
		}
		for (int i = 0; i < dataRow.Tag.Count; i++)
		{
			DrawCardTagItemDataList.Add(new DrawCardTagItemData(this, dataRow.Tag[i], dataRow.TagColor[i]));
		}
	}
}
