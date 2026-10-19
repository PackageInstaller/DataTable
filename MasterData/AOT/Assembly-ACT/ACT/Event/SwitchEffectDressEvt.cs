namespace ACT.Event;

public class SwitchEffectDressEvt : BaseEventContent
{
	public int roleId;

	public int requestEffectDressId;

	public int currentEffectDressId;

	public bool wear;

	public override void ReleaseEvt()
	{
		roleId = 0;
		requestEffectDressId = 0;
		currentEffectDressId = 0;
		wear = false;
	}
}
