namespace Spine;

public class PathConstraintData(string name) : ConstraintData(name)
{
	internal ExposedList<BoneData> bones = new ExposedList<BoneData>();

	internal SlotData target;

	internal PositionMode positionMode;

	internal SpacingMode spacingMode;

	internal RotateMode rotateMode;

	internal float offsetRotation;

	internal float position;

	internal float spacing;

	internal float mixRotate;

	internal float mixX;

	internal float mixY;

	public ExposedList<BoneData> Bones => bones;

	public SlotData Target
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

	public PositionMode PositionMode
	{
		get
		{
			return positionMode;
		}
		set
		{
			positionMode = value;
		}
	}

	public SpacingMode SpacingMode
	{
		get
		{
			return spacingMode;
		}
		set
		{
			spacingMode = value;
		}
	}

	public RotateMode RotateMode
	{
		get
		{
			return rotateMode;
		}
		set
		{
			rotateMode = value;
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

	public float Position
	{
		get
		{
			return position;
		}
		set
		{
			position = value;
		}
	}

	public float Spacing
	{
		get
		{
			return spacing;
		}
		set
		{
			spacing = value;
		}
	}

	public float RotateMix
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
}
