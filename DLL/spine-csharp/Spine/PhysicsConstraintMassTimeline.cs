namespace Spine;

public class PhysicsConstraintMassTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintMassTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintMass)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return 1f / constraint.data.massInverse;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return 1f / constraint.massInverse;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.massInverse = 1f / value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.massGlobal;
	}
}
