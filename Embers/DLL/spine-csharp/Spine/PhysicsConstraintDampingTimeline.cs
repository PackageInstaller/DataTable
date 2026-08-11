namespace Spine;

public class PhysicsConstraintDampingTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintDampingTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintDamping)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.damping;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.damping;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.damping = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.dampingGlobal;
	}
}
