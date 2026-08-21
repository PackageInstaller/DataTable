namespace Spine;

public class PhysicsConstraintData : ConstraintData
{
	internal BoneData bone;

	internal float x;

	internal float y;

	internal float rotate;

	internal float scaleX;

	internal float shearX;

	internal float limit;

	internal float step;

	internal float inertia;

	internal float strength;

	internal float damping;

	internal float massInverse;

	internal float wind;

	internal float gravity;

	internal float mix;

	internal bool inertiaGlobal;

	internal bool strengthGlobal;

	internal bool dampingGlobal;

	internal bool massGlobal;

	internal bool windGlobal;

	internal bool gravityGlobal;

	internal bool mixGlobal;

	public BoneData Bone => bone;

	public float Step
	{
		get
		{
			return step;
		}
		set
		{
			step = value;
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

	public float Rotate
	{
		get
		{
			return rotate;
		}
		set
		{
			rotate = value;
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

	public float Limit
	{
		get
		{
			return limit;
		}
		set
		{
			limit = value;
		}
	}

	public float Inertia
	{
		get
		{
			return inertia;
		}
		set
		{
			inertia = value;
		}
	}

	public float Strength
	{
		get
		{
			return strength;
		}
		set
		{
			strength = value;
		}
	}

	public float Damping
	{
		get
		{
			return damping;
		}
		set
		{
			damping = value;
		}
	}

	public float MassInverse
	{
		get
		{
			return massInverse;
		}
		set
		{
			massInverse = value;
		}
	}

	public float Wind
	{
		get
		{
			return wind;
		}
		set
		{
			wind = value;
		}
	}

	public float Gravity
	{
		get
		{
			return gravity;
		}
		set
		{
			gravity = value;
		}
	}

	public float Mix
	{
		get
		{
			return mix;
		}
		set
		{
			mix = value;
		}
	}

	public bool InertiaGlobal
	{
		get
		{
			return inertiaGlobal;
		}
		set
		{
			inertiaGlobal = value;
		}
	}

	public bool StrengthGlobal
	{
		get
		{
			return strengthGlobal;
		}
		set
		{
			strengthGlobal = value;
		}
	}

	public bool DampingGlobal
	{
		get
		{
			return dampingGlobal;
		}
		set
		{
			dampingGlobal = value;
		}
	}

	public bool MassGlobal
	{
		get
		{
			return massGlobal;
		}
		set
		{
			massGlobal = value;
		}
	}

	public bool WindGlobal
	{
		get
		{
			return windGlobal;
		}
		set
		{
			windGlobal = value;
		}
	}

	public bool GravityGlobal
	{
		get
		{
			return gravityGlobal;
		}
		set
		{
			gravityGlobal = value;
		}
	}

	public bool MixGlobal
	{
		get
		{
			return mixGlobal;
		}
		set
		{
			mixGlobal = value;
		}
	}

	public PhysicsConstraintData(string name)
		: base(name)
	{
	}
}
