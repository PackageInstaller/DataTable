namespace Spine;

public class AttachmentTimeline : Timeline, ISlotTimeline
{
	private readonly int slotIndex;

	private readonly string[] attachmentNames;

	public int SlotIndex => slotIndex;

	public string[] AttachmentNames => attachmentNames;

	public AttachmentTimeline(int frameCount, int slotIndex)
		: base(frameCount, 11 + "|" + slotIndex)
	{
		this.slotIndex = slotIndex;
		attachmentNames = new string[frameCount];
	}

	public void SetFrame(int frame, float time, string attachmentName)
	{
		frames[frame] = time;
		attachmentNames[frame] = attachmentName;
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Slot slot = skeleton.slots.Items[slotIndex];
		if (!slot.bone.active)
		{
			return;
		}
		if (direction == MixDirection.Out)
		{
			if (blend == MixBlend.Setup)
			{
				SetAttachment(skeleton, slot, slot.data.attachmentName);
			}
			return;
		}
		float[] array = frames;
		if (time < array[0])
		{
			if (blend == MixBlend.Setup || blend == MixBlend.First)
			{
				SetAttachment(skeleton, slot, slot.data.attachmentName);
			}
		}
		else
		{
			SetAttachment(skeleton, slot, attachmentNames[Timeline.Search(array, time)]);
		}
	}

	private void SetAttachment(Skeleton skeleton, Slot slot, string attachmentName)
	{
		slot.Attachment = ((attachmentName == null) ? null : skeleton.GetAttachment(slotIndex, attachmentName));
	}
}
