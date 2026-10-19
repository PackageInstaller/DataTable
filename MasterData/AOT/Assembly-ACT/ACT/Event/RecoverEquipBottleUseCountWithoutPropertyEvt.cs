namespace ACT.Event;

public class RecoverEquipBottleUseCountWithoutPropertyEvt : BaseEventContent
{
	public int recoverCount;

	public override void ReleaseEvt()
	{
		recoverCount = 0;
		base.ReleaseEvt();
	}
}
