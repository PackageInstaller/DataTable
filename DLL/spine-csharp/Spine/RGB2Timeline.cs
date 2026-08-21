namespace Spine;

public class RGB2Timeline : CurveTimeline, ISlotTimeline
{
	public const int ENTRIES = 7;

	protected const int R = 1;

	protected const int G = 2;

	protected const int B = 3;

	protected const int R2 = 4;

	protected const int G2 = 5;

	protected const int B2 = 6;

	private readonly int slotIndex;

	public override int FrameEntries => 7;

	public int SlotIndex => slotIndex;

	public RGB2Timeline(int frameCount, int bezierCount, int slotIndex)
		: base(frameCount, bezierCount, 8 + "|" + slotIndex, 10 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
	}

	public void SetFrame(int frame, float time, float r, float g, float b, float r2, float g2, float b2)
	{
		frame *= 7;
		frames[frame] = time;
		frames[frame + 1] = r;
		frames[frame + 2] = g;
		frames[frame + 3] = b;
		frames[frame + 4] = r2;
		frames[frame + 5] = g2;
		frames[frame + 6] = b2;
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
				slot.ClampColor();
				slot.r2 = data.r2;
				slot.g2 = data.g2;
				slot.b2 = data.b2;
				slot.ClampSecondColor();
				break;
			case MixBlend.First:
				slot.r += (slot.r - data.r) * alpha;
				slot.g += (slot.g - data.g) * alpha;
				slot.b += (slot.b - data.b) * alpha;
				slot.ClampColor();
				slot.r2 += (slot.r2 - data.r2) * alpha;
				slot.g2 += (slot.g2 - data.g2) * alpha;
				slot.b2 += (slot.b2 - data.b2) * alpha;
				slot.ClampSecondColor();
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 7);
		int num2 = (int)curves[num / 7];
		float num3;
		float num4;
		float num5;
		float num6;
		float num7;
		float num8;
		switch (num2)
		{
		case 0:
		{
			float num9 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			num7 = array[num + 5];
			num8 = array[num + 6];
			float num10 = (time - num9) / (array[num + 7] - num9);
			num3 += (array[num + 7 + 1] - num3) * num10;
			num4 += (array[num + 7 + 2] - num4) * num10;
			num5 += (array[num + 7 + 3] - num5) * num10;
			num6 += (array[num + 7 + 4] - num6) * num10;
			num7 += (array[num + 7 + 5] - num7) * num10;
			num8 += (array[num + 7 + 6] - num8) * num10;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			num7 = array[num + 5];
			num8 = array[num + 6];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			num5 = GetBezierValue(time, num, 3, num2 + 36 - 2);
			num6 = GetBezierValue(time, num, 4, num2 + 54 - 2);
			num7 = GetBezierValue(time, num, 5, num2 + 72 - 2);
			num8 = GetBezierValue(time, num, 6, num2 + 90 - 2);
			break;
		}
		if (alpha == 1f)
		{
			slot.r = num3;
			slot.g = num4;
			slot.b = num5;
			slot.r2 = num6;
			slot.g2 = num7;
			slot.b2 = num8;
		}
		else
		{
			float r;
			float g;
			float b;
			float r2;
			float g2;
			float b2;
			if (blend == MixBlend.Setup)
			{
				SlotData data2 = slot.data;
				r = data2.r;
				g = data2.g;
				b = data2.b;
				r2 = data2.r2;
				g2 = data2.g2;
				b2 = data2.b2;
			}
			else
			{
				r = slot.r;
				g = slot.g;
				b = slot.b;
				r2 = slot.r2;
				g2 = slot.g2;
				b2 = slot.b2;
			}
			slot.r = r + (num3 - r) * alpha;
			slot.g = g + (num4 - g) * alpha;
			slot.b = b + (num5 - b) * alpha;
			slot.r2 = r2 + (num6 - r2) * alpha;
			slot.g2 = g2 + (num7 - g2) * alpha;
			slot.b2 = b2 + (num8 - b2) * alpha;
		}
		slot.ClampColor();
		slot.ClampSecondColor();
	}
}
