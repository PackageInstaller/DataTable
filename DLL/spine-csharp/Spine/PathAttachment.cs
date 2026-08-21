using System;

namespace Spine;

public class PathAttachment : VertexAttachment
{
	internal float[] lengths;

	internal bool closed;

	internal bool constantSpeed;

	public float[] Lengths
	{
		get
		{
			return lengths;
		}
		set
		{
			lengths = value;
		}
	}

	public bool Closed
	{
		get
		{
			return closed;
		}
		set
		{
			closed = value;
		}
	}

	public bool ConstantSpeed
	{
		get
		{
			return constantSpeed;
		}
		set
		{
			constantSpeed = value;
		}
	}

	public PathAttachment(string name)
		: base(name)
	{
	}

	protected PathAttachment(PathAttachment other)
		: base(other)
	{
		lengths = new float[other.lengths.Length];
		Array.Copy(other.lengths, 0, lengths, 0, lengths.Length);
		closed = other.closed;
		constantSpeed = other.constantSpeed;
	}

	public override Attachment Copy()
	{
		return new PathAttachment(this);
	}
}
