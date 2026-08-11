using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyMaterialSortViewModel : OptionBase
{
	private int dropGroup;

	private bool isMaterialSort;

	private int sortMaterialType;

	private CMSortItemViewModel item1;

	private CMSortItemViewModel item2;

	private List<KnapsackItemViewModel> dropProps;

	private List<CMSortItemViewModel> sortItemList;

	private InteractionRequest<string> optRequest;

	private CMSortItemViewModel curSortItem;

	public List<KnapsackItemViewModel> DropProps => dropProps;

	public List<CMSortItemViewModel> SortItemList => sortItemList;

	public bool IsMaterialSort
	{
		get
		{
			return isMaterialSort;
		}
		set
		{
			Set(ref isMaterialSort, value, "IsMaterialSort");
		}
	}

	public int SortMaterialType
	{
		get
		{
			return sortMaterialType;
		}
		set
		{
			Set(ref sortMaterialType, value, "SortMaterialType");
		}
	}

	public CMSortItemViewModel Item1 => item1;

	public CMSortItemViewModel Item2 => item2;

	public IInteractionRequest OptRequest => optRequest;

	public CopyMaterialSortViewModel()
	{
	}

	public CopyMaterialSortViewModel(OptionBase parent)
	{
		base.parent = parent;
		sortItemList = new List<CMSortItemViewModel>();
		dropProps = new List<KnapsackItemViewModel>();
		optRequest = new InteractionRequest<string>();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CMSortItemViewModel cMSortItemViewModel)
		{
			curSortItem.SetSelect(isSelect: false);
			curSortItem = cMSortItemViewModel;
			SetDropGoods(cMSortItemViewModel.DropTypeId);
			item2.SetDropId(cMSortItemViewModel.DropTypeId);
			optRequest.Raise("RefreshItems");
			curSortItem.SetSelect(isSelect: true);
		}
		else
		{
			parent.ItemOnClick(obj);
		}
	}

	public void OnConfirm()
	{
		item1.SetDropId(item2.DropTypeId);
		sortMaterialType = item2.DropTypeId;
		parent.ItemOnClick(item1);
		optRequest.Raise("Close");
	}

	public void OnCancel()
	{
		item2.SetDropId(item1.DropTypeId);
		SetDropGoods(item1.DropTypeId);
		SortMaterialType = item1.DropTypeId;
		if (curSortItem.DropTypeId != SortMaterialType)
		{
			curSortItem.SetSelect(isSelect: false);
		}
		for (int i = 0; i < sortItemList.Count; i++)
		{
			if (sortItemList[i].DropTypeId == sortMaterialType)
			{
				curSortItem = sortItemList[i];
				curSortItem.SetSelect(isSelect: true);
			}
		}
		optRequest.Raise("Close");
	}

	public void SetSortGroup(int drops)
	{
		dropGroup = drops;
		DRCopyDrop[] dataRows = GameEntry.DataTable.GetDataRows((DRCopyDrop p) => p.RewardGroupId == drops);
		sortItemList.Clear();
		if (dataRows != null)
		{
			bool flag = false;
			for (int num = 0; num < dataRows.Length; num++)
			{
				if (dataRows[num].DropeType > 0 && !flag)
				{
					IsMaterialSort = true;
					SortMaterialType = dataRows[num].DropeType;
					flag = true;
				}
				CMSortItemViewModel cMSortItemViewModel = new CMSortItemViewModel(this, dataRows[num].DropeType);
				sortItemList.Add(cMSortItemViewModel);
				if (cMSortItemViewModel.DropTypeId == sortMaterialType)
				{
					cMSortItemViewModel.SetSelect(isSelect: true);
					curSortItem = cMSortItemViewModel;
				}
			}
		}
		item1 = new CMSortItemViewModel(this, SortMaterialType);
		item2 = new CMSortItemViewModel(this, SortMaterialType);
		SetDropGoods(SortMaterialType);
	}

	public void SetMaterial(int materialType)
	{
		for (int i = 0; i < sortItemList.Count; i++)
		{
			if (sortItemList[i].DropTypeId == materialType)
			{
				ItemOnClick(sortItemList[i]);
				item1.SetDropId(item2.DropTypeId);
				sortMaterialType = item2.DropTypeId;
			}
		}
	}

	public void SetDropGoods(int materialType)
	{
		dropProps.Clear();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == dropGroup && p.DropeType == materialType);
		if (dataRow == null || dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
		{
			return;
		}
		for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
		{
			if (PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]) != null)
			{
				dropProps.Add(new KnapsackItemViewModel(this, PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num])));
			}
		}
	}
}
