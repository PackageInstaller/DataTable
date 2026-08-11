#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class CMSortItemViewModel : OptionBase
{
	private string icon;

	private string name;

	private int dropTypeId;

	private bool isSelect;

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public int DropTypeId => dropTypeId;

	public CMSortItemViewModel()
	{
	}

	public CMSortItemViewModel(OptionBase parant, int dropTypeId)
	{
		parent = parant;
		SetDropId(dropTypeId);
	}

	public void SetDropId(int dropTypeId)
	{
		this.dropTypeId = dropTypeId;
		DRDropMaterial dataRow = GameEntry.DataTable.GetDataRow<DRDropMaterial>(dropTypeId);
		if (dataRow == null)
		{
			if (this.dropTypeId != 0)
			{
				Log.Error($"DropMaterial表找不到Id为{this.dropTypeId}的数据！");
			}
		}
		else
		{
			Icon = dataRow.Icon;
			Name = dataRow.Name;
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void OnSelect()
	{
		parent.ItemOnClick(this);
	}
}
