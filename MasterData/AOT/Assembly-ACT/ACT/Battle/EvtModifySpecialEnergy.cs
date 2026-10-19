using ACT.Battle.Configs;

namespace ACT.Battle;

public class EvtModifySpecialEnergy : BaseEvt
{
	public float preValue;

	public float curValue;

	public ActionChangeSpecialEnergy.State state;

	public override void Reset()
	{
		preValue = 0f;
		curValue = 0f;
		state = ActionChangeSpecialEnergy.State.Set;
	}
}
