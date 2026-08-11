using System;

namespace Spine;

public class SlotData
{
	internal int index;

	internal string name;

	internal BoneData boneData;

	internal float r = 1f;

	internal float g = 1f;

	internal float b = 1f;

	internal float a = 1f;

	internal float r2;

	internal float g2;

	internal float b2;

	internal bool hasSecondColor;

	internal string attachmentName;

	internal BlendMode blendMode;

	public int Index => index;

	public string Name => name;

	public BoneData BoneData => boneData;

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
			return hasSecondColor;
		}
		set
		{
			hasSecondColor = value;
		}
	}

	public string AttachmentName
	{
		get
		{
			return attachmentName;
		}
		set
		{
			attachmentName = value;
		}
	}

	public BlendMode BlendMode
	{
		get
		{
			return blendMode;
		}
		set
		{
			blendMode = value;
		}
	}

	public SlotData(int index, string name, BoneData boneData)
	{
		if (index < 0)
		{
			throw new ArgumentException("index must be >= 0.", "index");
		}
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		if (boneData == null)
		{
			throw new ArgumentNullException("boneData", "boneData cannot be null.");
		}
		this.index = index;
		this.name = name;
		this.boneData = boneData;
	}

	public override string ToString()
	{
		return name;
	}
}
