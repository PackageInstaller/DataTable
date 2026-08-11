using System;

namespace Spine;

public class SequenceTimeline : Timeline, ISlotTimeline
{
	public const int ENTRIES = 3;

	private const int MODE = 1;

	private const int DELAY = 2;

	private readonly int slotIndex;

	private readonly IHasTextureRegion attachment;

	public override int FrameEntries => 3;

	public int SlotIndex => slotIndex;

	public Attachment Attachment => (Attachment)attachment;

	public SequenceTimeline(int frameCount, int slotIndex, Attachment attachment)
		: base(frameCount, 28 + "|" + slotIndex + "|" + ((IHasTextureRegion)attachment).Sequence.Id)
	{
		this.slotIndex = slotIndex;
		this.attachment = (IHasTextureRegion)attachment;
	}

	public void SetFrame(int frame, float time, SequenceMode mode, int index, float delay)
	{
		frame *= 3;
		frames[frame] = time;
		frames[frame + 1] = (int)mode | (index << 4);
		frames[frame + 2] = delay;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Slot slot = skeleton.slots.Items[slotIndex];
		if (!slot.bone.active)
		{
			return;
		}
		Attachment attachment = slot.attachment;
		if (attachment != this.attachment && (!(attachment is VertexAttachment vertexAttachment) || vertexAttachment.TimelineAttachment != this.attachment))
		{
			return;
		}
		Sequence sequence = ((IHasTextureRegion)attachment).Sequence;
		if (sequence == null)
		{
			return;
		}
		if (direction == MixDirection.Out)
		{
			if (blend == MixBlend.Setup)
			{
				slot.SequenceIndex = -1;
			}
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			if (blend == MixBlend.Setup || blend == MixBlend.First)
			{
				slot.SequenceIndex = -1;
			}
			return;
		}
		int num = Timeline.Search(array, time, 3);
		float num2 = array[num];
		int num3 = (int)array[num + 1];
		float num4 = array[num + 2];
		int num5 = num3 >> 4;
		int num6 = sequence.Regions.Length;
		SequenceMode sequenceMode = (SequenceMode)(num3 & 0xF);
		if (sequenceMode != SequenceMode.Hold)
		{
			num5 += (int)((time - num2) / num4 + 0.0001f);
			switch (sequenceMode)
			{
			case SequenceMode.Once:
				num5 = Math.Min(num6 - 1, num5);
				break;
			case SequenceMode.Loop:
				num5 %= num6;
				break;
			case SequenceMode.Pingpong:
			{
				int num8 = (num6 << 1) - 2;
				num5 = ((num8 != 0) ? (num5 % num8) : 0);
				if (num5 >= num6)
				{
					num5 = num8 - num5;
				}
				break;
			}
			case SequenceMode.OnceReverse:
				num5 = Math.Max(num6 - 1 - num5, 0);
				break;
			case SequenceMode.LoopReverse:
				num5 = num6 - 1 - num5 % num6;
				break;
			case SequenceMode.PingpongReverse:
			{
				int num7 = (num6 << 1) - 2;
				num5 = ((num7 != 0) ? ((num5 + num6 - 1) % num7) : 0);
				if (num5 >= num6)
				{
					num5 = num7 - num5;
				}
				break;
			}
			}
		}
		slot.SequenceIndex = num5;
	}
}
