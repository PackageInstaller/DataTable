namespace Spine;

public class PhysicsConstraintWindTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintWindTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintWind)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.wind;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.wind;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.wind = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.windGlobal;
	}
}
