using System;

namespace Spine;

public class Slot
{
	internal SlotData data;

	internal Bone bone;

	internal float r;

	internal float g;

	internal float b;

	internal float a;

	internal float r2;

	internal float g2;

	internal float b2;

	internal bool hasSecondColor;

	internal Attachment attachment;

	internal int sequenceIndex;

	internal ExposedList<float> deform = new ExposedList<float>();

	internal int attachmentState;

	public SlotData Data => data;

	public Bone Bone => bone;

	public Skeleton Skeleton => bone.skeleton;

	public float R
	{
		get
		{
			return r;
		}
		set
		{
			r = value;
		}
	}

	public float G
	{
		get
		{
			return g;
		}
		set
		{
			g = value;
		}
	}

	public float B
	{
		get
		{
			return b;
		}
		set
		{
			b = value;
		}
	}

	public float A
	{
		get
		{
			return a;
		}
		set
		{
			a = value;
		}
	}

	public float R2
	{
		get
		{
			return r2;
		}
		set
		{
			r2 = value;
		}
	}

	public float G2
	{
		get
		{
			return g2;
		}
		set
		{
			g2 = value;
		}
	}

	public float B2
	{
		get
		{
			return b2;
		}
		set
		{
			b2 = value;
		}
	}

	public bool HasSecondColor
	{
		get
		{
			return data.hasSecondColor;
		}
		set
		{
			data.hasSecondColor = value;
		}
	}

	public Attachment Attachment
	{
		get
		{
			return attachment;
		}
		set
		{
			if (attachment != value)
			{
				if (!(value is VertexAttachment) || !(attachment is VertexAttachment) || ((VertexAttachment)value).TimelineAttachment != ((VertexAttachment)attachment).TimelineAttachment)
				{
					deform.Clear();
				}
				attachment = value;
				sequenceIndex = -1;
			}
		}
	}

	public int SequenceIndex
	{
		get
		{
			return sequenceIndex;
		}
		set
		{
			sequenceIndex = value;
		}
	}

	public ExposedList<float> Deform
	{
		get
		{
			return deform;
		}
		set
		{
			if (deform == null)
			{
				throw new ArgumentNullException("deform", "deform cannot be null.");
			}
			deform = value;
		}
	}

	public Slot(SlotData data, Bone bone)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data", "data cannot be null.");
		}
		if (bone == null)
		{
			throw new ArgumentNullException("bone", "bone cannot be null.");
		}
		this.data = data;
		this.bone = bone;
		if (data.hasSecondColor)
		{
			r2 = (g2 = (b2 = 0f));
		}
		SetToSetupPose();
	}

	public Slot(Slot slot, Bone bone)
	{
		if (slot == null)
		{
			throw new ArgumentNullException("slot", "slot cannot be null.");
		}
		if (bone == null)
		{
			throw new ArgumentNullException("bone", "bone cannot be null.");
		}
		data = slot.data;
		this.bone = bone;
		r = slot.r;
		g = slot.g;
		b = slot.b;
		a = slot.a;
		if (slot.hasSecondColor)
		{
			r2 = slot.r2;
			g2 = slot.g2;
			b2 = slot.b2;
		}
		else
		{
			r2 = (g2 = (b2 = 0f));
		}
		hasSecondColor = slot.hasSecondColor;
		attachment = slot.attachment;
		sequenceIndex = slot.sequenceIndex;
		deform.AddRange(slot.deform);
	}

	public void ClampColor()
	{
		r = MathUtils.Clamp(r, 0f, 1f);
		g = MathUtils.Clamp(g, 0f, 1f);
		b = MathUtils.Clamp(b, 0f, 1f);
		a = MathUtils.Clamp(a, 0f, 1f);
	}

	public void ClampSecondColor()
	{
		r2 = MathUtils.Clamp(r2, 0f, 1f);
		g2 = MathUtils.Clamp(g2, 0f, 1f);
		b2 = MathUtils.Clamp(b2, 0f, 1f);
	}

	public void SetToSetupPose()
	{
		r = data.r;
		g = data.g;
		b = data.b;
		a = data.a;
		if (HasSecondColor)
		{
			r2 = data.r2;
			g2 = data.g2;
			b2 = data.b2;
		}
		if (data.attachmentName == null)
		{
			Attachment = null;
			return;
		}
		attachment = null;
		Attachment = bone.skeleton.GetAttachment(data.index, data.attachmentName);
	}

	public override string ToString()
	{
		return data.name;
	}
}
