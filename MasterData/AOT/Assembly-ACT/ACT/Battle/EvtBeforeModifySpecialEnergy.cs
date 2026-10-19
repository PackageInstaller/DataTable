namespace ACT.Battle;

public class EvtBeforeModifySpecialEnergy : BaseEvt
{
	public float value;

	public override void Reset()
	{
		value = 0f;
	}
}
