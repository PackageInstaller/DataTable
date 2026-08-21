namespace Spine;

public abstract class PhysicsConstraintTimeline : CurveTimeline1
{
	private readonly int constraintIndex;

	public int PhysicsConstraintIndex => constraintIndex;

	public PhysicsConstraintTimeline(int frameCount, int bezierCount, int physicsConstraintIndex, Property property)
		: base(frameCount, bezierCount, (int)property + "|" + physicsConstraintIndex)
	{
		constraintIndex = physicsConstraintIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		if (constraintIndex == -1)
		{
			float value = ((time >= frames[0]) ? GetCurveValue(time) : 0f);
			PhysicsConstraint[] items = skeleton.physicsConstraints.Items;
			int i = 0;
			for (int count = skeleton.physicsConstraints.Count; i < count; i++)
			{
				PhysicsConstraint physicsConstraint = items[i];
				if (physicsConstraint.active && Global(physicsConstraint.data))
				{
					Set(physicsConstraint, GetAbsoluteValue(time, alpha, blend, Get(physicsConstraint), Setup(physicsConstraint), value));
				}
			}
		}
		else
		{
			PhysicsConstraint physicsConstraint = skeleton.physicsConstraints.Items[constraintIndex];
			if (physicsConstraint.active)
			{
				Set(physicsConstraint, GetAbsoluteValue(time, alpha, blend, Get(physicsConstraint), Setup(physicsConstraint)));
			}
		}
	}

	protected abstract float Setup(PhysicsConstraint constraint);

	protected abstract float Get(PhysicsConstraint constraint);

	protected abstract void Set(PhysicsConstraint constraint, float value);

	protected abstract bool Global(PhysicsConstraintData constraint);
}
