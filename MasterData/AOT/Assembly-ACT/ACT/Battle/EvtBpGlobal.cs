namespace ACT.Battle;

public class EvtBpGlobal : BaseEvt
{
	public object eventData;

	public override void Reset()
	{
		eventData = null;
	}
}
