using ACT.Battle.Configs;

namespace ACT.Battle;

public class EvtModifyNormalEnergy : BaseEvt
{
	public float preValue;

	public float curValue;

	public ActionChangeNormalEnergy.ModifySource modifySource;

	public ActionChangeNormalEnergy.State state;

	public override void Reset()
	{
		preValue = 0f;
		curValue = 0f;
		modifySource = ActionChangeNormalEnergy.ModifySource.None;
		state = ActionChangeNormalEnergy.State.Set;
	}
}
