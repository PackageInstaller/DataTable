namespace Spine;

public class PhysicsConstraintStrengthTimeline : PhysicsConstraintTimeline
{
	public PhysicsConstraintStrengthTimeline(int frameCount, int bezierCount, int physicsConstraintIndex)
		: base(frameCount, bezierCount, physicsConstraintIndex, Property.PhysicsConstraintStrength)
	{
	}

	protected override float Setup(PhysicsConstraint constraint)
	{
		return constraint.data.strength;
	}

	protected override float Get(PhysicsConstraint constraint)
	{
		return constraint.strength;
	}

	protected override void Set(PhysicsConstraint constraint, float value)
	{
		constraint.strength = value;
	}

	protected override bool Global(PhysicsConstraintData constraint)
	{
		return constraint.strengthGlobal;
	}
}
