namespace ACT.Event;

public class RogueBuyItem : BaseEventContent
{
	public bool isCompleted;

	public int id;

	public int swuid;

	public override void ReleaseEvt()
	{
		isCompleted = false;
		id = 0;
		swuid = 0;
	}
}
