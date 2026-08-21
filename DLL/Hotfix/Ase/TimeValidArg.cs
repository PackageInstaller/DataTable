namespace Ase;

public class TimeValidArg
{
	public bool isValid;

	public long leftSecond;

	public TimeEventType eventType;

	public TimeValidArg()
	{
		eventType = TimeEventType.NotInit;
	}

	public void SetEventType(TimeEventType eventType, long left = 0L)
	{
		this.eventType = eventType;
		leftSecond = left;
		switch (eventType)
		{
		case TimeEventType.None:
			isValid = true;
			break;
		case TimeEventType.GoingOn:
			isValid = true;
			break;
		case TimeEventType.End:
			isValid = false;
			break;
		case TimeEventType.NotStart:
			isValid = false;
			break;
		}
	}
}
