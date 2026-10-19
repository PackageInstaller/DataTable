namespace ACT.Battle;

public class EvtCharacterVisible : BaseEvt
{
	public bool visible;

	public override void Reset()
	{
		visible = false;
	}
}
