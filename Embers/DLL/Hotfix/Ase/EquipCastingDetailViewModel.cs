using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class EquipCastingDetailViewModel : OptionBase
{
	private EquipCastingItemData itemData;

	private List<CastingMaterialItemData> materialDataList;

	private InteractionRequest refreshMaterialRequest;

	private IKnapsackService knapsackService;

	public EquipCastingItemData ItemData
	{
		get
		{
			return itemData;
		}
		private set
		{
			Set(ref itemData, value, "ItemData");
		}
	}

	public List<CastingMaterialItemData> MaterialDataList
	{
		get
		{
			return materialDataList;
		}
		private set
		{
			Set(ref materialDataList, value, "MaterialDataList");
		}
	}

	public InteractionRequest RefreshMaterialRequest => refreshMaterialRequest;

	public EquipCastingDetailViewModel(OptionBase parent, EquipCastingItemData data)
	{
		base.parent = parent;
		itemData = data;
		materialDataList = new List<CastingMaterialItemData>();
		knapsackService = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		SetMaterialList(data);
		refreshMaterialRequest = new InteractionRequest();
	}

	public void SetEquipCastingItemData(EquipCastingItemData data)
	{
		ItemData = data;
		SetMaterialList(data);
		refreshMaterialRequest.Raise();
	}

	public void btnCreateEquip()
	{
		parent.ItemOnClick(this);
	}

	public async void ShowCastingInfo()
	{
		_ = ItemData;
	}

	private async void SetMaterialList(EquipCastingItemData data)
	{
		MaterialDataList.Clear();
		if (data.CastingDataBase.NeedMaterialId.Count != data.CastingDataBase.NeedMaterialNum.Count)
		{
			Toast.ShowInfo($"ID:{data.CastingDataBase.CastingId}的材料种类与数量不匹配");
			return;
		}
		for (int i = 0; i < data.CastingDataBase.NeedMaterialId.Count; i++)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(data.CastingDataBase.NeedMaterialId[i]);
			KnapsackPropData prop = knapsackService.GetKnapsackViewModel().GetProp(dataRow.Id, emptyCreate: true);
			MaterialDataList.Add(new CastingMaterialItemData(this, data.CastingDataBase.NeedMaterialNum[i], prop));
		}
	}
}
