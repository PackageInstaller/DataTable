namespace Spine;

public class PathConstraintPositionTimeline : CurveTimeline1
{
	private readonly int constraintIndex;

	public int PathConstraintIndex => constraintIndex;

	public PathConstraintPositionTimeline(int frameCount, int bezierCount, int pathConstraintIndex)
		: base(frameCount, bezierCount, 17 + "|" + pathConstraintIndex)
	{
		constraintIndex = pathConstraintIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		PathConstraint pathConstraint = skeleton.pathConstraints.Items[constraintIndex];
		if (pathConstraint.active)
		{
			pathConstraint.position = GetAbsoluteValue(time, alpha, blend, pathConstraint.position, pathConstraint.data.position);
		}
	}
}
