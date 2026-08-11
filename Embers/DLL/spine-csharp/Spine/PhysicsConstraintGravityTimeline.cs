namespace Spine;

public class PhysicsConstraintGravityTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintGravityTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintGravity)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.gravity;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.gravity;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.gravity = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.gravityGlobal;
	}
}
