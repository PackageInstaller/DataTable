namespace ACT.Battle;

public class EvtRogueTriggerParameterChange : BaseEvt
{
	public int triggerId;

	public string parameterName;

	public float parameterValue;

	public override void Reset()
	{
		triggerId = 0;
		parameterName = null;
		parameterValue = 0f;
	}
}
