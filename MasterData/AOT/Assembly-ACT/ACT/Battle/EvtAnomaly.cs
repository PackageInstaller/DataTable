namespace ACT.Battle;

public class EvtAnomaly : BaseEvt
{
	public AnomalyType anomalyType;

	public int anomalyValue;

	public override void Reset()
	{
		anomalyType = AnomalyType.count;
		anomalyValue = 0;
	}
}
