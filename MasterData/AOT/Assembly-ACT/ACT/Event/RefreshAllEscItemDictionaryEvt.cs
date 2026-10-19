namespace ACT.Event;

public class RefreshAllEscItemDictionaryEvt : BaseEventContent
{
	public int systemId;

	public EscItem escItem;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		systemId = 0;
		escItem = null;
	}
}
