using System;

namespace Spine;

public class PointAttachment : Attachment
{
	internal float x;

	internal float y;

	internal float rotation;

	public float X
	{
		get
		{
			return x;
		}
		set
		{
			x = value;
		}
	}

	public float Y
	{
		get
		{
			return y;
		}
		set
		{
			y = value;
		}
	}

	public float Rotation
	{
		get
		{
			return rotation;
		}
		set
		{
			rotation = value;
		}
	}

	public PointAttachment(string name)
		: base(name)
	{
	}

	protected PointAttachment(PointAttachment other)
		: base(other)
	{
		x = other.x;
		y = other.y;
		rotation = other.rotation;
	}

	public void ComputeWorldPosition(Bone bone, out float ox, out float oy)
	{
		bone.LocalToWorld(x, y, out ox, out oy);
	}

	public float ComputeWorldRotation(Bone bone)
	{
		float num = rotation * (MathF.PI / 180f);
		float num2 = (float)Math.Cos(num);
		float num3 = (float)Math.Sin(num);
		float num4 = num2 * bone.a + num3 * bone.b;
		return MathUtils.Atan2Deg(num2 * bone.c + num3 * bone.d, num4);
	}

	public override Attachment Copy()
	{
		return new PointAttachment(this);
	}
}
