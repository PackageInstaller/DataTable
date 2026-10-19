namespace ACT.Battle.Configs;

public class ECM2Override : TimelineItem
{
	public ActionOverrideEcm2Params configMotionECM2;

	public override bool CanDoPeriod()
	{
		return false;
	}
}
