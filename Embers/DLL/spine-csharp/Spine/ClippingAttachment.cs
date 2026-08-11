namespace Spine;

public class ClippingAttachment : VertexAttachment
{
	internal SlotData endSlot;

	public SlotData EndSlot
	{
		get
		{
			return endSlot;
		}
		set
		{
			endSlot = value;
		}
	}

	public ClippingAttachment(string name)
		: base(name)
	{
	}

	protected ClippingAttachment(ClippingAttachment other)
		: base(other)
	{
		endSlot = other.endSlot;
	}

	public override Attachment Copy()
	{
		return new ClippingAttachment(this);
	}
}
