namespace Ase;

public class StatusBuffItemViewModel : BuffItemViewModel
{
	private bool isExpand;

	private int index;

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

	public int Index
	{
		get
		{
			return index;
		}
		private set
		{
			Set(ref index, value, "Index");
		}
	}

	public StatusBuffItemViewModel(Buff buff, int index, OptionBase parent)
		: base(buff)
	{
		base.parent = parent;
		this.index = index;
		isExpand = false;
	}

	public StatusBuffItemViewModel()
	{
	}

	public void SetIndex(int idx)
	{
		Index = idx;
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
