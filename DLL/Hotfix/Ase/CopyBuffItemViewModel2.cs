using GameFramework.Runtime;

namespace Ase;

public class CopyBuffItemViewModel2 : ViewModelBase
{
	private string desc = "";

	private bool isActive;

	private bool isSelect;

	public string Desc
	{
		get
		{
			return desc;
		}
		set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public bool IsActive
	{
		get
		{
			return isActive;
		}
		set
		{
			Set(ref isActive, value, "IsActive");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
