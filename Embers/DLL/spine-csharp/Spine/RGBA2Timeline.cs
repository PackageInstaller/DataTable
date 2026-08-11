namespace Spine;

public class RGBA2Timeline : CurveTimeline, ISlotTimeline
{
	public const int ENTRIES = 8;

	protected const int R = 1;

	protected const int G = 2;

	protected const int B = 3;

	protected const int A = 4;

	protected const int R2 = 5;

	protected const int G2 = 6;

	protected const int B2 = 7;

	private readonly int slotIndex;

	public override int FrameEntries => 8;

	public int SlotIndex => slotIndex;

	public RGBA2Timeline(int frameCount, int bezierCount, int slotIndex)
		: base(frameCount, bezierCount, 8 + "|" + slotIndex, 9 + "|" + slotIndex, 10 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
	}

	public void SetFrame(int frame, float time, float r, float g, float b, float a, float r2, float g2, float b2)
	{
		frame <<= 3;
		frames[frame] = time;
		frames[frame + 1] = r;
		frames[frame + 2] = g;
		frames[frame + 3] = b;
		frames[frame + 4] = a;
		frames[frame + 5] = r2;
		frames[frame + 6] = g2;
		frames[frame + 7] = b2;
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
				slot.a += (slot.a - data.a) * alpha;
				slot.ClampColor();
				slot.r2 += (slot.r2 - data.r2) * alpha;
				slot.g2 += (slot.g2 - data.g2) * alpha;
				slot.b2 += (slot.b2 - data.b2) * alpha;
				slot.ClampSecondColor();
				break;
			}
			return;
		}
		int num = Timeline.Search(array, time, 8);
		int num2 = (int)curves[num >> 3];
		float num3;
		float num4;
		float num5;
		float num6;
		float num7;
		float num8;
		float num9;
		switch (num2)
		{
		case 0:
		{
			float num10 = array[num];
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			num7 = array[num + 5];
			num8 = array[num + 6];
			num9 = array[num + 7];
			float num11 = (time - num10) / (array[num + 8] - num10);
			num3 += (array[num + 8 + 1] - num3) * num11;
			num4 += (array[num + 8 + 2] - num4) * num11;
			num5 += (array[num + 8 + 3] - num5) * num11;
			num6 += (array[num + 8 + 4] - num6) * num11;
			num7 += (array[num + 8 + 5] - num7) * num11;
			num8 += (array[num + 8 + 6] - num8) * num11;
			num9 += (array[num + 8 + 7] - num9) * num11;
			break;
		}
		case 1:
			num3 = array[num + 1];
			num4 = array[num + 2];
			num5 = array[num + 3];
			num6 = array[num + 4];
			num7 = array[num + 5];
			num8 = array[num + 6];
			num9 = array[num + 7];
			break;
		default:
			num3 = GetBezierValue(time, num, 1, num2 - 2);
			num4 = GetBezierValue(time, num, 2, num2 + 18 - 2);
			num5 = GetBezierValue(time, num, 3, num2 + 36 - 2);
			num6 = GetBezierValue(time, num, 4, num2 + 54 - 2);
			num7 = GetBezierValue(time, num, 5, num2 + 72 - 2);
			num8 = GetBezierValue(time, num, 6, num2 + 90 - 2);
			num9 = GetBezierValue(time, num, 7, num2 + 108 - 2);
			break;
		}
		if (alpha == 1f)
		{
			slot.r = num3;
			slot.g = num4;
			slot.b = num5;
			slot.a = num6;
			slot.r2 = num7;
			slot.g2 = num8;
			slot.b2 = num9;
		}
		else
		{
			float r;
			float g;
			float b;
			float a;
			float r2;
			float g2;
			float b2;
			if (blend == MixBlend.Setup)
			{
				r = slot.data.r;
				g = slot.data.g;
				b = slot.data.b;
				a = slot.data.a;
				r2 = slot.data.r2;
				g2 = slot.data.g2;
				b2 = slot.data.b2;
			}
			else
			{
				r = slot.r;
				g = slot.g;
				b = slot.b;
				a = slot.a;
				r2 = slot.r2;
				g2 = slot.g2;
				b2 = slot.b2;
			}
			slot.r = r + (num3 - r) * alpha;
			slot.g = g + (num4 - g) * alpha;
			slot.b = b + (num5 - b) * alpha;
			slot.a = a + (num6 - a) * alpha;
			slot.r2 = r2 + (num7 - r2) * alpha;
			slot.g2 = g2 + (num8 - g2) * alpha;
			slot.b2 = b2 + (num9 - b2) * alpha;
		}
		slot.ClampColor();
		slot.ClampSecondColor();
	}
}
