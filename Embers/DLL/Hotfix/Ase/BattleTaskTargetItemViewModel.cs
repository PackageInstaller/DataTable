namespace Ase;

public class BattleTaskTargetItemViewModel : OptionBase
{
	private BattleTaskTargetViewModel battleTaskTargetViewModel;

	private int index;

	private TaskDataViewModel data;

	private bool hasChild;

	private bool clickTrackUI;

	public BattleTaskTargetViewModel BattleTaskTargetViewModel
	{
		get
		{
			return battleTaskTargetViewModel;
		}
		private set
		{
			Set(ref battleTaskTargetViewModel, value, "BattleTaskTargetViewModel");
		}
	}

	public TaskDataViewModel Data
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

	public int Index
	{
		get
		{
			return index;
		}
		set
		{
			index = value;
		}
	}

	public bool HasChild
	{
		get
		{
			return hasChild;
		}
		set
		{
			hasChild = value;
		}
	}

	public bool ClickTrackUI
	{
		get
		{
			return clickTrackUI;
		}
		set
		{
			Set(ref clickTrackUI, value, "ClickTrackUI");
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (parent != null)
		{
			parent.ItemOnClick(obj);
		}
	}

	public BattleTaskTargetItemViewModel()
	{
	}

	public BattleTaskTargetItemViewModel(OptionBase parent, TaskDataViewModel data)
	{
		base.parent = parent;
		this.data = data;
		BattleTaskTargetViewModel = (BattleTaskTargetViewModel)base.parent;
	}

	public void ClickTaskDirUIBtn()
	{
		battleTaskTargetViewModel.ClickTaskDirUIBtn();
	}
}
