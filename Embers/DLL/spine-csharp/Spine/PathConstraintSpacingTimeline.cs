namespace Spine;

public class PathConstraintSpacingTimeline : CurveTimeline1
{
	private readonly int constraintIndex;

	public int PathConstraintIndex => constraintIndex;

	public PathConstraintSpacingTimeline(int frameCount, int bezierCount, int pathConstraintIndex)
		: base(frameCount, bezierCount, 18 + "|" + pathConstraintIndex)
	{
		constraintIndex = pathConstraintIndex;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> events, float alpha, MixBlend blend, MixDirection direction)
	{
		PathConstraint pathConstraint = skeleton.pathConstraints.Items[constraintIndex];
		if (pathConstraint.active)
		{
			pathConstraint.spacing = GetAbsoluteValue(time, alpha, blend, pathConstraint.spacing, pathConstraint.data.spacing);
		}
	}
}
