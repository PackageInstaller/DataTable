namespace Spine;

public class PhysicsConstraintResetTimeline : Timeline
{
	private static readonly string[] propertyIds = new string[1] { 27.ToString() };

	private readonly int constraintIndex;

	public int PhysicsConstraintIndex => constraintIndex;

	public override int FrameCount => frames.Length;

	public PhysicsConstraintResetTimeline(int frameCount, int physicsConstraintIndex)
		: base(frameCount, propertyIds)
	{
		constraintIndex = physicsConstraintIndex;
	}

	public void SetFrame(int frame, float time)
	{
		frames[frame] = time;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		PhysicsConstraint physicsConstraint = null;
		if (constraintIndex != -1)
		{
			physicsConstraint = skeleton.physicsConstraints.Items[constraintIndex];
			if (!physicsConstraint.active)
			{
				return;
			}
		}
		float[] array = frames;
		if (lastTime > time)
		{
			Apply(skeleton, lastTime, 2.1474836E+09f, null, alpha, blend, direction);
			lastTime = -1f;
		}
		else if (lastTime >= array[array.Length - 1])
		{
			return;
		}
		if (time < array[0] || (!(lastTime < array[0]) && !(time >= array[Timeline.Search(array, lastTime) + 1])))
		{
			return;
		}
		if (physicsConstraint != null)
		{
			physicsConstraint.Reset();
			return;
		}
		PhysicsConstraint[] items = skeleton.physicsConstraints.Items;
		int i = 0;
		for (int count = skeleton.physicsConstraints.Count; i < count; i++)
		{
			physicsConstraint = items[i];
			if (physicsConstraint.active)
			{
				physicsConstraint.Reset();
			}
		}
	}
}
