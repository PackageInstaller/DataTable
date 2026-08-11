using System;

namespace Ase;

public class WarehouseItemData : KnapsackItemViewModel
{
	private bool showSelectPanel;

	private int selectCount;

	private float selectCountFloat;

	private int selectCountMin;

	private int selectCountMax;

	private int changeCount;

	public bool ShowSelectPanel
	{
		get
		{
			return showSelectPanel;
		}
		set
		{
			Set(ref showSelectPanel, value, "ShowSelectPanel");
			base.New = false;
		}
	}

	public float SelectCountFloat
	{
		get
		{
			return selectCountFloat;
		}
		set
		{
			Set(ref selectCountFloat, value, "SelectCountFloat");
			int num = SelectCount;
			SelectCount = (int)Math.Floor(value);
			if (num != SelectCount)
			{
				OnSelectCountChanged(SelectCount - num);
			}
		}
	}

	public int SelectCount
	{
		get
		{
			return selectCount;
		}
		private set
		{
			Set(ref selectCount, value, "SelectCount");
		}
	}

	public int SelectCountMin
	{
		get
		{
			return selectCountMin;
		}
		set
		{
			Set(ref selectCountMin, value, "SelectCountMin");
		}
	}

	public int SelectCountMax
	{
		get
		{
			return selectCountMax;
		}
		set
		{
			Set(ref selectCountMax, value, "SelectCountMax");
		}
	}

	public int ChangeCount
	{
		get
		{
			return changeCount;
		}
		set
		{
			Set(ref changeCount, value, "ChangeCount");
		}
	}

	public WarehouseItemData()
	{
	}

	public WarehouseItemData(OptionBase parent, PropDataBase data)
		: base(parent, data)
	{
		SelectCountMin = 0;
		SelectCountMax = data.Amount;
	}

	public void SelectMin()
	{
		if (!ShowSelectPanel)
		{
			SelectCount = 1;
			selectCountFloat = 1f;
			ChangeCount = 0;
			ShowSelectPanel = true;
		}
		else
		{
			ChangeCount = SelectCount - 1;
			SelectCount = 1;
			selectCountFloat = 1f;
		}
	}

	public void SelectMax()
	{
		if (!ShowSelectPanel)
		{
			SelectCount = SelectCountMax;
			selectCountFloat = SelectCount;
			ChangeCount = 0;
			ShowSelectPanel = true;
		}
		else
		{
			ChangeCount = SelectCountMax - SelectCount;
			SelectCount = SelectCountMax;
			selectCountFloat = SelectCount;
		}
	}

	public void CancelSelect()
	{
		SelectCount = 0;
		selectCountFloat = 0f;
		ChangeCount = 0;
		ShowSelectPanel = false;
	}

	public void OnBtnAddClick()
	{
		if (SelectCountMax > SelectCount)
		{
			SelectCount++;
			selectCountFloat = SelectCount;
			OnSelectCountChanged(1);
		}
	}

	public void OnBtnDecClick()
	{
		if (SelectCountMin < SelectCount)
		{
			SelectCount--;
			selectCountFloat = SelectCount;
			OnSelectCountChanged(-1);
		}
	}

	private void OnSelectCountChanged(int changeCount)
	{
		ChangeCount = changeCount;
		if (changeCount != 0)
		{
			if (changeCount > 0)
			{
				parent?.ItemOnClick(new OptionArg(this, "AddSelect"));
			}
			else if (SelectCount <= 0)
			{
				parent?.ItemOnClick(new OptionArg(this, "RemoveSelect"));
			}
			else
			{
				parent?.ItemOnClick(new OptionArg(this, "DecSelect"));
			}
		}
	}

	public void OnPressUp()
	{
		selectCountFloat = SelectCount;
	}
}
