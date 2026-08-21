using System;
using UnityEngine;

namespace Ase;

public class DrawCardRecordItemViewModel : OptionBase
{
	private string itemType;

	private string itemName;

	private Color itemColor;

	private string poolType;

	private string callTime;

	public string ItemType => itemType;

	public string ItemName => itemName;

	public Color ItemColor => itemColor;

	public string PoolType => poolType;

	public string CallTime => callTime;

	public DrawCardRecordItemViewModel(DrawCardRecordInfo drawCardRecordInfo)
	{
		if (drawCardRecordInfo.itemType == 5)
		{
			LoadWeaponConfig(drawCardRecordInfo);
		}
		else
		{
			LoadHeroConfig(drawCardRecordInfo);
		}
		DRDrawCardInfo dataRow = GameEntry.DataTable.GetDataTable<DRDrawCardInfo>().GetDataRow(drawCardRecordInfo.poolId);
		if (dataRow != null)
		{
			poolType = dataRow.CardName;
		}
		DateTime dateTime = new DateTime(1970, 1, 1).AddSeconds(drawCardRecordInfo.callTime);
		callTime = (dateTime + TimeSpan.FromHours(8.0)).ToString("yyyy-MM-dd HH:mm:ss");
	}

	private void LoadHeroConfig(DrawCardRecordInfo drawCardRecordInfo)
	{
		itemType = "角色";
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataTable<DRHeroInfo>().GetDataRow(drawCardRecordInfo.itemId);
		if (dataRow != null)
		{
			SetColor(dataRow.Rarity);
			itemName = dataRow.Name;
		}
	}

	private void LoadWeaponConfig(DrawCardRecordInfo drawCardRecordInfo)
	{
		itemType = "武魂";
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(drawCardRecordInfo.itemId);
		if (dataRow != null)
		{
			itemName = dataRow.Name;
			SetColor(dataRow.Rarity);
		}
	}

	private void SetColor(int rarity)
	{
		string htmlString = "";
		switch (rarity)
		{
		case 2:
			htmlString = "#ffffff";
			break;
		case 3:
			htmlString = "#ffa8f4";
			break;
		case 4:
			htmlString = "#ffc821";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		itemColor = color;
	}
}
