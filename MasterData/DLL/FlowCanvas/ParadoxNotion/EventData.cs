namespace ParadoxNotion;

public class EventData
{
	public string name { get; private set; }

	public object value => GetValue();

	protected virtual object GetValue()
	{
		return null;
	}

	public EventData(string name)
	{
		this.name = name;
	}
}
public class EventData<T> : EventData
{
	public new T value { get; private set; }

	protected override object GetValue()
	{
		return value;
	}

	public EventData(string name, T value)
		: base(name)
	{
		this.value = value;
	}
}
