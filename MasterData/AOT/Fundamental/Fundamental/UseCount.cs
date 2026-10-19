namespace Fundamental;

public struct UseCount
{
	public int count;

	public ActionList<bool> onChange;

	public void Init()
	{
		onChange = new ActionList<bool>();
	}

	public void Add()
	{
		count++;
		if (count > 0)
		{
			onChange?.Invoke(arg: true);
		}
	}

	public void Remove()
	{
		count--;
		if (count == 0)
		{
			onChange?.Invoke(arg: false);
		}
	}
}
