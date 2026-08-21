namespace Spine;

public class PathConstraintMixTimeline : CurveTimeline
{
	public const int ENTRIES = 4;

	private const int ROTATE = 1;

	private const int X = 2;

	private const int Y = 3;

	private readonly int constraintIndex;

	public override int FrameEntries => 4;

	public int PathConstraintIndex => constraintIndex;

	public PathConstraintMixTimeline(int frameCount, int bezierCount, int pathConstraintIndex)
		: base(frameCount, bezierCount, 19 + "|" + pathConstraintIndex)
	{
		constraintIndex = pathConstraintIndex;
	}

	public void SetFrame(int frame, float time, float mixRotate, float mixX, float mixY)
	{
		frame <<= 2;
		frames[frame] = time;
		frames[frame + 1] = mixRotate;
		frames[frame + 2] = mixX;
		frames[frame + 3] = mixY;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		PathConstraint pathConstraint = skeleton.pathConstraints.Items[constraintIndex];
		if (!pathConstraint.active)
		{
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			switch (blend)
			{
			case MixBlend.Setup:
				pathConstraint.mixRotate = pathConstraint.data.mixRotate;
				pathConstraint.mixX = pathConstraint.data.mixX;
				pathConstraint.mixY = pathConstraint.data.mixY;
				break;
			case MixBlend.First:
				pathConstraint.mixRotate += (pathConstraint.data.mixRotate - pathConstraint.mixRotate) * alpha;
				pathConstraint.mixX += (pathConstraint.data.mixX - pathConstraint.mixX) * alpha;
				pathConstraint.mixY += (pathConstraint.data.mixY - pathConstraint.mixY) * alpha;
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 4);
		int num2 = (int)curves[num >> 2];
		float num3;
		float num4;
		float num5;
		switch (num2)
		{
		case 0:
		{
			float num6 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			float num7 = (time - num6) / (array[num + 4] - num6);
			num3 += (array[num + 4 + 1] - num3) * num7;
			num4 += (array[num + 4 + 2] - num4) * num7;
			num5 += (array[num + 4 + 3] - num5) * num7;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			num5 = GetBezierValue(time, num, 3, num2 + 36 - 2);
			break;
		}
		if (blend == MixBlend.Setup)
		{
			PathConstraintData data = pathConstraint.data;
			pathConstraint.mixRotate = data.mixRotate + (num3 - data.mixRotate) * alpha;
			pathConstraint.mixX = data.mixX + (num4 - data.mixX) * alpha;
			pathConstraint.mixY = data.mixY + (num5 - data.mixY) * alpha;
		}
		else
		{
			pathConstraint.mixRotate += (num3 - pathConstraint.mixRotate) * alpha;
			pathConstraint.mixX += (num4 - pathConstraint.mixX) * alpha;
			pathConstraint.mixY += (num5 - pathConstraint.mixY) * alpha;
		}
	}
}
