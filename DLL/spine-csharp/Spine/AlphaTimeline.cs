namespace Spine;

public class AlphaTimeline : CurveTimeline1, ISlotTimeline
{
	private readonly int slotIndex;

	public int SlotIndex => slotIndex;

	public AlphaTimeline(int frameCount, int bezierCount, int slotIndex)
		: base(frameCount, bezierCount, 9 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
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
				slot.a = data.a;
				break;
			case MixBlend.First:
				slot.a += (data.a - slot.a) * alpha;
				slot.ClampColor();
				break;
			}
			return;
		}
		float curveValue = GetCurveValue(time);
		if (alpha == 1f)
		{
			slot.a = curveValue;
		}
		else
		{
			if (blend == MixBlend.Setup)
			{
				slot.a = slot.data.a;
			}
			slot.a += (curveValue - slot.a) * alpha;
		}
		slot.ClampColor();
	}
}
