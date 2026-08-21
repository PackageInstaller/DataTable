namespace Spine;

public class RGBATimeline : CurveTimeline, ISlotTimeline
{
	public const int ENTRIES = 5;

	protected const int R = 1;

	protected const int G = 2;

	protected const int B = 3;

	protected const int A = 4;

	private readonly int slotIndex;

	public override int FrameEntries => 5;

	public int SlotIndex => slotIndex;

	public RGBATimeline(int frameCount, int bezierCount, int slotIndex)
		: base(frameCount, bezierCount, 8 + "|" + slotIndex, 9 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
	}

	public void SetFrame(int frame, float time, float r, float g, float b, float a)
	{
		frame *= 5;
		frames[frame] = time;
		frames[frame + 1] = r;
		frames[frame + 2] = g;
		frames[frame + 3] = b;
		frames[frame + 4] = a;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Slot slot = skeleton.slots.Items[slotIndex];
		if (!slot.bone.active)
		{
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			SlotData data = slot.data;
			switch (blend)
			{
			case MixBlend.Setup:
				slot.r = data.r;
				slot.g = data.g;
				slot.b = data.b;
				slot.a = data.a;
				break;
			case MixBlend.First:
				slot.r += (data.r - slot.r) * alpha;
				slot.g += (data.g - slot.g) * alpha;
				slot.b += (data.b - slot.b) * alpha;
				slot.a += (data.a - slot.a) * alpha;
				slot.ClampColor();
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 5);
		int num2 = (int)curves[num / 5];
		float num3;
		float num4;
		float num5;
		float num6;
		switch (num2)
		{
		case 0:
		{
			float num7 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			float num8 = (time - num7) / (array[num + 5] - num7);
			num3 += (array[num + 5 + 1] - num3) * num8;
			num4 += (array[num + 5 + 2] - num4) * num8;
			num5 += (array[num + 5 + 3] - num5) * num8;
			num6 += (array[num + 5 + 4] - num6) * num8;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			num5 = GetBezierValue(time, num, 3, num2 + 36 - 2);
			num6 = GetBezierValue(time, num, 4, num2 + 54 - 2);
			break;
		}
		if (alpha == 1f)
		{
			slot.r = num3;
			slot.g = num4;
			slot.b = num5;
			slot.a = num6;
		}
		else
		{
			float r;
			float g;
			float b;
			float a;
			if (blend == MixBlend.Setup)
			{
				r = slot.data.r;
				g = slot.data.g;
				b = slot.data.b;
				a = slot.data.a;
			}
			else
			{
				r = slot.r;
				g = slot.g;
				b = slot.b;
				a = slot.a;
			}
			slot.r = r + (num3 - r) * alpha;
			slot.g = g + (num4 - g) * alpha;
			slot.b = b + (num5 - b) * alpha;
			slot.a = a + (num6 - a) * alpha;
		}
		slot.ClampColor();
	}
}
