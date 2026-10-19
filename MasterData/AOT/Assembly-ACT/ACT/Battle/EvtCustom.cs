namespace ACT.Battle;

public class EvtCustom : BaseEvt
{
	public string eventId;

	public override void Reset()
	{
		eventId = null;
	}
}
