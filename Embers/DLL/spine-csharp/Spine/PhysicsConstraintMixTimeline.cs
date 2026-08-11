namespace Spine;

public class PhysicsConstraintMixTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintMixTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintMix)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.mix;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.mix;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.mix = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.mixGlobal;
	}
}
