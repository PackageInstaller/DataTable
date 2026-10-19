namespace ACT.Battle.Configs;

public class PhysicsOverride : TimelineItem
{
	public ConfigMotionPhysics configMotionPhysics;

	public override bool CanDoPeriod()
	{
		return false;
	}
}
