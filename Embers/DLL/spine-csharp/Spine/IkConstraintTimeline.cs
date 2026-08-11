namespace Spine;

public class IkConstraintTimeline : CurveTimeline
{
	public const int ENTRIES = 6;

	private const int MIX = 1;

	private const int SOFTNESS = 2;

	private const int BEND_DIRECTION = 3;

	private const int COMPRESS = 4;

	private const int STRETCH = 5;

	private readonly int constraintIndex;

	public override int FrameEntries => 6;

	public int IkConstraintIndex => constraintIndex;

	public IkConstraintTimeline(int frameCount, int bezierCount, int ikConstraintIndex)
		: base(frameCount, bezierCount, 15 + "|" + ikConstraintIndex)
	{
		constraintIndex = ikConstraintIndex;
	}

	public void SetFrame(int frame, float time, float mix, float softness, int bendDirection, bool compress, bool stretch)
	{
		frame *= 6;
		frames[frame] = time;
		frames[frame + 1] = mix;
		frames[frame + 2] = softness;
		frames[frame + 3] = bendDirection;
		frames[frame + 4] = (compress ? 1 : 0);
		frames[frame + 5] = (stretch ? 1 : 0);
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		IkConstraint ikConstraint = skeleton.ikConstraints.Items[constraintIndex];
		if (!ikConstraint.active)
		{
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			switch (blend)
			{
			case MixBlend.Setup:
				ikConstraint.mix = ikConstraint.data.mix;
				ikConstraint.softness = ikConstraint.data.softness;
				ikConstraint.bendDirection = ikConstraint.data.bendDirection;
				ikConstraint.compress = ikConstraint.data.compress;
				ikConstraint.stretch = ikConstraint.data.stretch;
				break;
			case MixBlend.First:
				ikConstraint.mix += (ikConstraint.data.mix - ikConstraint.mix) * alpha;
				ikConstraint.softness += (ikConstraint.data.softness - ikConstraint.softness) * alpha;
				ikConstraint.bendDirection = ikConstraint.data.bendDirection;
				ikConstraint.compress = ikConstraint.data.compress;
				ikConstraint.stretch = ikConstraint.data.stretch;
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 6);
		int num2 = (int)curves[num / 6];
		float num3;
		float num4;
		switch (num2)
		{
		case 0:
		{
			float num5 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			float num6 = (time - num5) / (array[num + 6] - num5);
			num3 += (array[num + 6 + 1] - num3) * num6;
			num4 += (array[num + 6 + 2] - num4) * num6;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			break;
		}
		if (blend == MixBlend.Setup)
		{
			ikConstraint.mix = ikConstraint.data.mix + (num3 - ikConstraint.data.mix) * alpha;
			ikConstraint.softness = ikConstraint.data.softness + (num4 - ikConstraint.data.softness) * alpha;
			if (direction == MixDirection.Out)
			{
				ikConstraint.bendDirection = ikConstraint.data.bendDirection;
				ikConstraint.compress = ikConstraint.data.compress;
				ikConstraint.stretch = ikConstraint.data.stretch;
			}
			else
			{
				ikConstraint.bendDirection = (int)array[num + 3];
				ikConstraint.compress = array[num + 4] != 0f;
				ikConstraint.stretch = array[num + 5] != 0f;
			}
		}
		else
		{
			ikConstraint.mix += (num3 - ikConstraint.mix) * alpha;
			ikConstraint.softness += (num4 - ikConstraint.softness) * alpha;
			if (direction == MixDirection.In)
			{
				ikConstraint.bendDirection = (int)array[num + 3];
				ikConstraint.compress = array[num + 4] != 0f;
				ikConstraint.stretch = array[num + 5] != 0f;
			}
		}
	}
}
