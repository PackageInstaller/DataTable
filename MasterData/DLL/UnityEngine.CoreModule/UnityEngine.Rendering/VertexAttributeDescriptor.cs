using System;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
public struct VertexAttributeDescriptor : IEquatable<VertexAttributeDescriptor>
{
	public VertexAttribute attribute { get; set; }

	public VertexAttributeFormat format { get; set; }

	public int dimension { get; set; }

	public int stream { get; set; }

	public VertexAttributeDescriptor(VertexAttribute attribute = VertexAttribute.Position, VertexAttributeFormat format = VertexAttributeFormat.Float32, int dimension = 3, int stream = 0)
	{
		this.attribute = attribute;
		this.format = format;
		this.dimension = dimension;
		this.stream = stream;
	}

	public override string ToString()
	{
		return $"(attr={attribute} fmt={format} dim={dimension} stream={stream})";
	}

	public override int GetHashCode()
	{
		int num = 17;
		num = (int)(num * 23 + attribute);
		num = (int)(num * 23 + format);
		num = num * 23 + dimension;
		return num * 23 + stream;
	}

	public override bool Equals(object other)
	{
		if (!(other is VertexAttributeDescriptor))
		{
			return false;
		}
		return Equals((VertexAttributeDescriptor)other);
	}

	public bool Equals(VertexAttributeDescriptor other)
	{
		return attribute == other.attribute && format == other.format && dimension == other.dimension && stream == other.stream;
	}
}
