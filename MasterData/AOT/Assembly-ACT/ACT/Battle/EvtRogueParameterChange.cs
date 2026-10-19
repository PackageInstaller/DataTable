namespace ACT.Battle;

public class EvtRogueParameterChange : BaseEvt
{
	public string parameterName;

	public float parameterValue;

	public override void Reset()
	{
		parameterName = null;
		parameterValue = 0f;
	}
}
