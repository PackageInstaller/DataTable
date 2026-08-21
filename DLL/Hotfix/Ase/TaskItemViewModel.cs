namespace Ase;

public class TaskItemViewModel : OptionBase
{
	private TaskDataViewModel data;

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

	public override void ItemOnClick(object obj)
	{
	}

	public TaskItemViewModel()
	{
	}

	public TaskItemViewModel(OptionBase parent, TaskDataViewModel data)
	{
		base.parent = parent;
		SetData(data);
	}

	public void SetData(TaskDataViewModel data)
	{
		Data = data;
	}

	public void OnClick()
	{
		parent.ItemOnClick(this);
	}
}
