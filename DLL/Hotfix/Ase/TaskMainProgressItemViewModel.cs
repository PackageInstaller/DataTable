namespace Ase;

public class TaskMainProgressItemViewModel : OptionBase
{
	public int taskId;

	public bool isTimeLock;

	public string text;

	public bool isFinish;

	public TaskMainProgressItemViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnClick()
	{
		parent.ItemOnClick(this);
	}
}
