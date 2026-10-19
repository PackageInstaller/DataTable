using ACT.Battle.Configs;

namespace ACT.Battle;

public class EvtBeforeModifyNormalEnergy : BaseEvt
{
	public float value;

	public ActionChangeNormalEnergy.ModifySource modifySource;

	public override void Reset()
	{
		value = 0f;
		modifySource = ActionChangeNormalEnergy.ModifySource.None;
	}
}
