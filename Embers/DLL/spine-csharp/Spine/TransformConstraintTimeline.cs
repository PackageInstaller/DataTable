namespace Spine;

public class TransformConstraintTimeline : CurveTimeline
{
	public const int ENTRIES = 7;

	private const int ROTATE = 1;

	private const int X = 2;

	private const int Y = 3;

	private const int SCALEX = 4;

	private const int SCALEY = 5;

	private const int SHEARY = 6;

	private readonly int constraintIndex;

	public override int FrameEntries => 7;

	public int TransformConstraintIndex => constraintIndex;

	public TransformConstraintTimeline(int frameCount, int bezierCount, int transformConstraintIndex)
		: base(frameCount, bezierCount, 16 + "|" + transformConstraintIndex)
	{
		constraintIndex = transformConstraintIndex;
	}

	public void SetFrame(int frame, float time, float mixRotate, float mixX, float mixY, float mixScaleX, float mixScaleY, float mixShearY)
	{
		frame *= 7;
		frames[frame] = time;
		frames[frame + 1] = mixRotate;
		frames[frame + 2] = mixX;
		frames[frame + 3] = mixY;
		frames[frame + 4] = mixScaleX;
		frames[frame + 5] = mixScaleY;
		frames[frame + 6] = mixShearY;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		TransformConstraint transformConstraint = skeleton.transformConstraints.Items[constraintIndex];
		if (!transformConstraint.active)
		{
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			TransformConstraintData data = transformConstraint.data;
			switch (blend)
			{
			case MixBlend.Setup:
				transformConstraint.mixRotate = data.mixRotate;
				transformConstraint.mixX = data.mixX;
				transformConstraint.mixY = data.mixY;
				transformConstraint.mixScaleX = data.mixScaleX;
				transformConstraint.mixScaleY = data.mixScaleY;
				transformConstraint.mixShearY = data.mixShearY;
				break;
			case MixBlend.First:
				transformConstraint.mixRotate += (data.mixRotate - transformConstraint.mixRotate) * alpha;
				transformConstraint.mixX += (data.mixX - transformConstraint.mixX) * alpha;
				transformConstraint.mixY += (data.mixY - transformConstraint.mixY) * alpha;
				transformConstraint.mixScaleX += (data.mixScaleX - transformConstraint.mixScaleX) * alpha;
				transformConstraint.mixScaleY += (data.mixScaleY - transformConstraint.mixScaleY) * alpha;
				transformConstraint.mixShearY += (data.mixShearY - transformConstraint.mixShearY) * alpha;
				break;
			}
		}
		else
		{
			GetCurveValue(out var rotate, out var x, out var y, out var scaleX, out var scaleY, out var shearY, time);
			if (blend == MixBlend.Setup)
			{
				TransformConstraintData data2 = transformConstraint.data;
				transformConstraint.mixRotate = data2.mixRotate + (rotate - data2.mixRotate) * alpha;
				transformConstraint.mixX = data2.mixX + (x - data2.mixX) * alpha;
				transformConstraint.mixY = data2.mixY + (y - data2.mixY) * alpha;
				transformConstraint.mixScaleX = data2.mixScaleX + (scaleX - data2.mixScaleX) * alpha;
				transformConstraint.mixScaleY = data2.mixScaleY + (scaleY - data2.mixScaleY) * alpha;
				transformConstraint.mixShearY = data2.mixShearY + (shearY - data2.mixShearY) * alpha;
			}
			else
			{
				transformConstraint.mixRotate += (rotate - transformConstraint.mixRotate) * alpha;
				transformConstraint.mixX += (x - transformConstraint.mixX) * alpha;
				transformConstraint.mixY += (y - transformConstraint.mixY) * alpha;
				transformConstraint.mixScaleX += (scaleX - transformConstraint.mixScaleX) * alpha;
				transformConstraint.mixScaleY += (scaleY - transformConstraint.mixScaleY) * alpha;
				transformConstraint.mixShearY += (shearY - transformConstraint.mixShearY) * alpha;
			}
		}
	}

	public void GetCurveValue(out float rotate, out float x, out float y, out float scaleX, out float scaleY, out float shearY, float time)
	{
		float[] array = frames;
		int num = Timeline.Search(array, time, 7);
		int num2 = (int)curves[num / 7];
		switch (num2)
		{
		case 0:
		{
			float num3 = array[num];
			rotate = array[num + 1];
			x = array[num + 2];
			y = array[num + 3];
			scaleX = array[num + 4];
			scaleY = array[num + 5];
			shearY = array[num + 6];
			float num4 = (time - num3) / (array[num + 7] - num3);
			rotate += (array[num + 7 + 1] - rotate) * num4;
			x += (array[num + 7 + 2] - x) * num4;
			y += (array[num + 7 + 3] - y) * num4;
			scaleX += (array[num + 7 + 4] - scaleX) * num4;
			scaleY += (array[num + 7 + 5] - scaleY) * num4;
			shearY += (array[num + 7 + 6] - shearY) * num4;
			break;
		}
		case 1:
			rotate = array[num + 1];
			x = array[num + 2];
			y = array[num + 3];
			scaleX = array[num + 4];
			scaleY = array[num + 5];
			shearY = array[num + 6];
			break;
		default:
			rotate = GetBezierValue(time, num, 1, num2 - 2);
			x = GetBezierValue(time, num, 2, num2 + 18 - 2);
			y = GetBezierValue(time, num, 3, num2 + 36 - 2);
			scaleX = GetBezierValue(time, num, 4, num2 + 54 - 2);
			scaleY = GetBezierValue(time, num, 5, num2 + 72 - 2);
			shearY = GetBezierValue(time, num, 6, num2 + 90 - 2);
			break;
		}
	}
}
