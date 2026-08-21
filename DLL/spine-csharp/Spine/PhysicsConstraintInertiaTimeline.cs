namespace Spine;

public class PhysicsConstraintInertiaTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintInertiaTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintInertia)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.inertia;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.inertia;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.inertia = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.inertiaGlobal;
	}
}
