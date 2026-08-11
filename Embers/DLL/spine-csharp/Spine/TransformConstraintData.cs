namespace Spine;

public class TransformConstraintData : ConstraintData
{
	internal ExposedList<BoneData> bones = new ExposedList<BoneData>();

	internal BoneData target;

	internal float mixRotate;

	internal float mixX;

	internal float mixY;

	internal float mixScaleX;

	internal float mixScaleY;

	internal float mixShearY;

	internal float offsetRotation;

	internal float offsetX;

	internal float offsetY;

	internal float offsetScaleX;

	internal float offsetScaleY;

	internal float offsetShearY;

	internal bool relative;

	internal bool local;

	public ExposedList<BoneData> Bones => bones;

	public BoneData Target
	{
		get
		{
			return target;
		}
		set
		{
			target = value;
		}
	}

	public float MixRotate
	{
		get
		{
			return mixRotate;
		}
		set
		{
			mixRotate = value;
		}
	}

	public float MixX
	{
		get
		{
			return mixX;
		}
		set
		{
			mixX = value;
		}
	}

	public float MixY
	{
		get
		{
			return mixY;
		}
		set
		{
			mixY = value;
		}
	}

	public float MixScaleX
	{
		get
		{
			return mixScaleX;
		}
		set
		{
			mixScaleX = value;
		}
	}

	public float MixScaleY
	{
		get
		{
			return mixScaleY;
		}
		set
		{
			mixScaleY = value;
		}
	}

	public float MixShearY
	{
		get
		{
			return mixShearY;
		}
		set
		{
			mixShearY = value;
		}
	}

	public float OffsetRotation
	{
		get
		{
			return offsetRotation;
		}
		set
		{
			offsetRotation = value;
		}
	}

	public float OffsetX
	{
		get
		{
			return offsetX;
		}
		set
		{
			offsetX = value;
		}
	}

	public float OffsetY
	{
		get
		{
			return offsetY;
		}
		set
		{
			offsetY = value;
		}
	}

	public float OffsetScaleX
	{
		get
		{
			return offsetScaleX;
		}
		set
		{
			offsetScaleX = value;
		}
	}

	public float OffsetScaleY
	{
		get
		{
			return offsetScaleY;
		}
		set
		{
			offsetScaleY = value;
		}
	}

	public float OffsetShearY
	{
		get
		{
			return offsetShearY;
		}
		set
		{
			offsetShearY = value;
		}
	}

	public bool Relative
	{
		get
		{
			return relative;
		}
		set
		{
			relative = value;
		}
	}

	public bool Local
	{
		get
		{
			return local;
		}
		set
		{
			local = value;
		}
	}

	public TransformConstraintData(string name)
		: base(name)
	{
	}
}
