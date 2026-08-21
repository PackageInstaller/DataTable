#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class DrawCardOptionalViewModel : OptionBase
{
	private string itemName;

	private string itemDesc;

	private int poolId;

	private List<DrawCardOptionalItemData> itemDataList;

	private List<TabItemNormalData> tagList;

	private SimpleCommand btnConfirmCmd;

	private DrawCardOptionalItemData selecteCard;

	private InteractionRequest refreshTagRequest;

	private int index;

	public string ItemName
	{
		get
		{
			return itemName;
		}
		set
		{
			Set(ref itemName, value, "ItemName");
		}
	}

	public string ItemDesc
	{
		get
		{
			return itemDesc;
		}
		set
		{
			Set(ref itemDesc, value, "ItemDesc");
		}
	}

	public List<DrawCardOptionalItemData> ItemDataList
	{
		get
		{
			return itemDataList;
		}
		set
		{
			Set(ref itemDataList, value, "ItemDataList");
		}
	}

	public List<TabItemNormalData> TagList
	{
		get
		{
			return tagList;
		}
		set
		{
			Set(ref tagList, value, "TagList");
		}
	}

	public int Index => index;

	public SimpleCommand BtnConfirmCmd => btnConfirmCmd;

	public InteractionRequest RefreshTagRequest => refreshTagRequest;

	public DrawCardOptionalViewModel(OptionBase parent, int poolId, int id)
	{
		base.parent = parent;
		btnConfirmCmd = new SimpleCommand(BtnConfirmOnClick);
		refreshTagRequest = new InteractionRequest();
		this.poolId = poolId;
		itemDataList = new List<DrawCardOptionalItemData>();
		tagList = new List<TabItemNormalData>();
		LoadOptionalInfo();
		for (int i = 0; i < ItemDataList.Count; i++)
		{
			if (ItemDataList[i].ItemId == id)
			{
				index = i;
				DrawCardOptionalItemOnclick(ItemDataList[i]);
			}
		}
		if (id == 0 && ItemDataList.Count > 0)
		{
			DrawCardOptionalItemOnclick(ItemDataList[0]);
		}
	}

	private void LoadOptionalInfo()
	{
		DRChoose dataRow = GameEntry.DataTable.GetDataRow((DRChoose p) => p.CardId == poolId);
		if (dataRow == null || dataRow.Option.Count != dataRow.Type.Count)
		{
			Toast.ShowError($"自选卡池{poolId}数据配置错误");
			return;
		}
		for (int num = 0; num < dataRow.Option.Count; num++)
		{
			DrawCardOptionalItemData item = new DrawCardOptionalItemData(this, dataRow.Option[num], dataRow.Type[num]);
			itemDataList.Add(item);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is DrawCardOptionalItemData drawCardOptionalItemData)
		{
			DrawCardOptionalItemOnclick(drawCardOptionalItemData);
			refreshTagRequest.Raise();
		}
		else if (obj is OptionArg { Obj: DrawCardOptionalItemData obj2 } optionArg && optionArg.OptionName.Equals("OpenPreview"))
		{
			OpenPreview(obj2);
		}
	}

	private void OpenPreview(DrawCardOptionalItemData drawCardOptionalItemData)
	{
		if (!btnConfirmCmd.Enabled)
		{
			return;
		}
		btnConfirmCmd.Enabled = false;
		try
		{
			if (drawCardOptionalItemData.ItemType == 4)
			{
				HeroCultivatePreviewViewModel userData = new HeroCultivatePreviewViewModel(this, drawCardOptionalItemData.ItemId, 0);
				openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivatePreviewWindow), userData), delegate
				{
					btnConfirmCmd.Enabled = true;
				});
			}
			else if (drawCardOptionalItemData.ItemType == 5)
			{
				WeaponPreviewViewModel userData2 = new WeaponPreviewViewModel(this, drawCardOptionalItemData.ItemId);
				openWindowRequest.Raise(new OpenViewArg(typeof(WeaponPreviewWindow), userData2), delegate
				{
					btnConfirmCmd.Enabled = true;
				});
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开预览界面发生异常！" + ex.Message + "/" + ex.StackTrace);
			btnConfirmCmd.Enabled = true;
		}
	}

	private void DrawCardOptionalItemOnclick(DrawCardOptionalItemData drawCardOptionalItemData)
	{
		if (selecteCard != null)
		{
			selecteCard.IsSelected = false;
		}
		selecteCard = drawCardOptionalItemData;
		selecteCard.IsSelected = true;
		SetInfo();
		SetTag();
	}

	private void SetInfo()
	{
		if (selecteCard != null)
		{
			ItemName = selecteCard.ItemName;
			ItemDesc = FormattedEffectText();
		}
	}

	private string FormattedEffectText()
	{
		if (selecteCard.ItemType == 4)
		{
			return selecteCard.ItemDesc.Replace("\\n", "\n");
		}
		if (selecteCard.ItemType == 5)
		{
			List<object> list = new List<object>();
			foreach (List<float> item in selecteCard.EffectValue)
			{
				if (item != null && item.Count > 0)
				{
					list.Add(item[0]);
				}
			}
			return string.Format(selecteCard.WeaponEffectDesc, list.ToArray());
		}
		return "";
	}

	private void SetTag()
	{
		if (selecteCard != null)
		{
			TagList = selecteCard.TagList;
		}
	}

	private async void BtnConfirmOnClick()
	{
		btnConfirmCmd.Enabled = false;
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ChooseOptionalHero(poolId, selecteCard.ItemId))
			{
				parent?.ItemOnClick(selecteCard);
				btnConfirmCmd.Enabled = true;
				Close();
			}
			else
			{
				btnConfirmCmd.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			Log.Error($"选择发生异常！{poolId} {ex.Message}/{ex.StackTrace}");
		}
		finally
		{
			btnConfirmCmd.Enabled = true;
		}
	}

	public override void Close()
	{
		if (btnConfirmCmd.Enabled)
		{
			btnConfirmCmd.Enabled = false;
			base.Close();
		}
	}
}
