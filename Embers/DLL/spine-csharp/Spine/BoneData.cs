using System;

namespace Spine;

public class BoneData
{
	internal int index;

	internal string name;

	internal BoneData parent;

	internal float length;

	internal float x;

	internal float y;

	internal float rotation;

	internal float scaleX = 1f;

	internal float scaleY = 1f;

	internal float shearX;

	internal float shearY;

	internal Inherit inherit;

	internal bool skinRequired;

	public int Index => index;

	public string Name => name;

	public BoneData Parent => parent;

	public float Length
	{
		get
		{
			return length;
		}
		set
		{
			length = value;
		}
	}

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

	public float ScaleX
	{
		get
		{
			return scaleX;
		}
		set
		{
			scaleX = value;
		}
	}

	public float ScaleY
	{
		get
		{
			return scaleY;
		}
		set
		{
			scaleY = value;
		}
	}

	public float ShearX
	{
		get
		{
			return shearX;
		}
		set
		{
			shearX = value;
		}
	}

	public float ShearY
	{
		get
		{
			return shearY;
		}
		set
		{
			shearY = value;
		}
	}

	public Inherit Inherit
	{
		get
		{
			return inherit;
		}
		set
		{
			inherit = value;
		}
	}

	public bool SkinRequired
	{
		get
		{
			return skinRequired;
		}
		set
		{
			skinRequired = value;
		}
	}

	public BoneData(int index, string name, BoneData parent)
	{
		if (index < 0)
		{
			throw new ArgumentException("index must be >= 0", "index");
		}
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		this.index = index;
		this.name = name;
		this.parent = parent;
	}

	public override string ToString()
	{
		return name;
	}
}
