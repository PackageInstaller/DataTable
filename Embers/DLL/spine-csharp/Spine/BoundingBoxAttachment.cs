namespace Spine;

public class BoundingBoxAttachment : VertexAttachment
{
	public BoundingBoxAttachment(string name)
		: base(name)
	{
	}

	protected BoundingBoxAttachment(BoundingBoxAttachment other)
		: base(other)
	{
	}

	public override Attachment Copy()
	{
		return new BoundingBoxAttachment(this);
	}
}
