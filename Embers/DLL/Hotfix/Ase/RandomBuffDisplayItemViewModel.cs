namespace Ase;

public class RandomBuffDisplayItemViewModel : OptionBase
{
	private bool isExpand;

	private int index;

	private string buffName;

	private string buffIcon;

	private string buffDes;

	private bool curMaxLv;

	public string BuffName
	{
		get
		{
			return buffName;
		}
		private set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public string BuffIcon
	{
		get
		{
			return buffIcon;
		}
		private set
		{
			Set(ref buffIcon, value, "BuffIcon");
		}
	}

	public string BuffDes
	{
		get
		{
			return buffDes;
		}
		private set
		{
			Set(ref buffDes, value, "BuffDes");
		}
	}

	public bool IsExpand
	{
		get
		{
			return isExpand;
		}
		private set
		{
			Set(ref isExpand, value, "IsExpand");
		}
	}

	public bool CurMaxLv
	{
		get
		{
			return curMaxLv;
		}
		set
		{
			Set(ref curMaxLv, value, "CurMaxLv");
		}
	}

	public RandomBuffDisplayItemViewModel(DRTowerBuffUp drTowerBuffUp, OptionBase parent)
	{
		buffName = drTowerBuffUp.BuffName;
		buffIcon = drTowerBuffUp.BuffIcon;
		buffDes = drTowerBuffUp.BuffDes;
		base.parent = parent;
		isExpand = false;
	}

	public void ToggleExpand()
	{
		IsExpand = !IsExpand;
	}

	public void SetExpand(bool expand)
	{
		IsExpand = expand;
	}

	public void OnClick()
	{
		ToggleExpand();
		parent?.ItemOnClick(this);
	}
}
