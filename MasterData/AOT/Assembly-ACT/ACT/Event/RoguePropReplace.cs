namespace ACT.Event;

public class RoguePropReplace : BaseEventContent
{
	public bool isCompleted;

	public int index;

	public int swuid;

	public int oldItemId;

	public int newItemId;

	public override void ReleaseEvt()
	{
		isCompleted = false;
		index = 0;
		swuid = 0;
		oldItemId = 0;
		newItemId = 0;
	}
}
