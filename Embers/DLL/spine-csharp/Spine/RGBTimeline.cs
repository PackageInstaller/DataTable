namespace Spine;

public class RGBTimeline : CurveTimeline, ISlotTimeline
{
	public const int ENTRIES = 4;

	protected const int R = 1;

	protected const int G = 2;

	protected const int B = 3;

	private readonly int slotIndex;

	public override int FrameEntries => 4;

	public int SlotIndex => slotIndex;

	public RGBTimeline(int frameCount, int bezierCount, int slotIndex)
		: base(frameCount, bezierCount, 8 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
	}

	public void SetFrame(int frame, float time, float r, float g, float b)
	{
		frame <<= 2;
		frames[frame] = time;
		frames[frame + 1] = r;
		frames[frame + 2] = g;
		frames[frame + 3] = b;
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
				break;
			case MixBlend.First:
				slot.r += (data.r - slot.r) * alpha;
				slot.g += (data.g - slot.g) * alpha;
				slot.b += (data.b - slot.b) * alpha;
				slot.ClampColor();
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
		if (alpha == 1f)
		{
			slot.r = num3;
			slot.g = num4;
			slot.b = num5;
		}
		else
		{
			float r;
			float g;
			float b;
			if (blend == MixBlend.Setup)
			{
				SlotData data2 = slot.data;
				r = data2.r;
				g = data2.g;
				b = data2.b;
			}
			else
			{
				r = slot.r;
				g = slot.g;
				b = slot.b;
			}
			slot.r = r + (num3 - r) * alpha;
			slot.g = g + (num4 - g) * alpha;
			slot.b = b + (num5 - b) * alpha;
		}
		slot.ClampColor();
	}
}
