namespace ACT.Event;

public class SubMissionBluePrintCompleteEvt : BaseEventContent
{
	public int subMissionId;

	public int bluePrintId;

	public override void ReleaseEvt()
	{
		subMissionId = 0;
		bluePrintId = 0;
	}
}
