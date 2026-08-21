namespace Ase;

public class PermitTaskItemViewModel : OptionBase
{
	private CopyPermitData data;

	public CopyPermitData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public PermitTaskItemViewModel()
	{
	}

	public PermitTaskItemViewModel(OptionBase parent, CopyPermitData data)
	{
		base.parent = parent;
		Data = data;
	}

	public void RefreshData(CopyPermitData data)
	{
		Data = data;
	}

	public void OnGoto()
	{
		parent.ItemOnClick(this);
	}
}
