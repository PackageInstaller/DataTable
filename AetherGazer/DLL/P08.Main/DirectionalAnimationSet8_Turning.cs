using System;
using Animancer;
using UnityEngine;

[CreateAssetMenu(menuName = "Animancer/Directional Animation Set/8 Directions Turning", order = 414)]
internal class DirectionalAnimationSet8_Turning : DirectionalSet<AnimationClip>
{
	public enum Direction
	{
		R_90,
		R_45,
		L_45,
		L_90,
		L_135,
		L_180,
		R_180,
		R_135
	}

	[SerializeField]
	private AnimationClip _R_45;

	[SerializeField]
	private AnimationClip _R_90;

	[SerializeField]
	private AnimationClip _R_135;

	[SerializeField]
	private AnimationClip _R_180;

	[SerializeField]
	private AnimationClip _L_45;

	[SerializeField]
	private AnimationClip _L_90;

	[SerializeField]
	private AnimationClip _L_135;

	[SerializeField]
	private AnimationClip _L_180;

	public float turnTolerance = 22.5f;

	public override int DirectionCount => 8;

	public AnimationClip R_45
	{
		get
		{
			return _R_45;
		}
		set
		{
			_R_45 = value;
		}
	}

	public AnimationClip R_90
	{
		get
		{
			return _R_90;
		}
		set
		{
			_R_90 = value;
		}
	}

	public AnimationClip R_135
	{
		get
		{
			return _R_135;
		}
		set
		{
			_R_135 = value;
		}
	}

	public AnimationClip R_180
	{
		get
		{
			return _R_180;
		}
		set
		{
			_R_180 = value;
		}
	}

	public AnimationClip L_45
	{
		get
		{
			return _L_45;
		}
		set
		{
			_L_45 = value;
		}
	}

	public AnimationClip L_90
	{
		get
		{
			return _L_90;
		}
		set
		{
			_L_90 = value;
		}
	}

	public AnimationClip L_135
	{
		get
		{
			return _L_135;
		}
		set
		{
			_L_135 = value;
		}
	}

	public AnimationClip L_180
	{
		get
		{
			return _L_180;
		}
		set
		{
			_L_180 = value;
		}
	}

	protected override string GetDirectionName(int direction)
	{
		Direction direction2 = (Direction)direction;
		return direction2.ToString();
	}

	public static Direction VectorToDirection(Vector2 direction, float turnTolerance)
	{
		float num = 0f - Vector2.SignedAngle(Vector2.up, direction);
		if (num >= 0f && num < 45f + turnTolerance)
		{
			return Direction.R_45;
		}
		if (num >= 45f + turnTolerance && num < 90f + turnTolerance)
		{
			return Direction.R_90;
		}
		if (num >= 90f + turnTolerance && num < 135f + turnTolerance)
		{
			return Direction.R_135;
		}
		if (num >= 0f - (135f + turnTolerance) && num < 0f - (90f + turnTolerance))
		{
			return Direction.L_135;
		}
		if (num >= 0f - (90f + turnTolerance) && num < 0f - (45f + turnTolerance))
		{
			return Direction.L_90;
		}
		if (num >= 0f - (45f + turnTolerance) && num < -0f)
		{
			return Direction.L_45;
		}
		if (num >= 135f + turnTolerance)
		{
			return Direction.R_180;
		}
		return Direction.L_180;
	}

	public override AnimationClip Get(int direction)
	{
		return GetClip((Direction)direction);
	}

	public override AnimationClip Get(Vector2 direction)
	{
		return GetClip(VectorToDirection(direction, turnTolerance));
	}

	public AnimationClip GetClip(Direction direction)
	{
		return direction switch
		{
			Direction.R_90 => R_90, 
			Direction.R_45 => R_45, 
			Direction.L_45 => L_45, 
			Direction.L_90 => L_90, 
			Direction.L_135 => L_135, 
			Direction.L_180 => L_180, 
			Direction.R_180 => R_180, 
			Direction.R_135 => R_135, 
			_ => throw AnimancerUtilities.CreateUnsupportedArgumentException(direction), 
		};
	}

	public static Vector2 DirectionToVector(Direction direction)
	{
		return direction switch
		{
			Direction.R_90 => Vector2.right, 
			Direction.R_45 => Directions.UpRight, 
			Direction.L_45 => Directions.UpLeft, 
			Direction.L_90 => Vector2.left, 
			Direction.L_135 => Directions.DownLeft, 
			Direction.L_180 => Vector2.down, 
			Direction.R_180 => Vector2.down, 
			Direction.R_135 => Directions.DownRight, 
			_ => throw AnimancerUtilities.CreateUnsupportedArgumentException(direction), 
		};
	}

	public override Vector2 GetDirection(int direction)
	{
		return DirectionToVector((Direction)direction);
	}

	public static Vector2 SnapVectorToDirection(Vector2 vector, float turnTolerance)
	{
		float magnitude = vector.magnitude;
		vector = DirectionToVector(VectorToDirection(vector, turnTolerance)) * magnitude;
		return vector;
	}

	public override Vector2 Snap(Vector2 vector)
	{
		return SnapVectorToDirection(vector, turnTolerance);
	}

	public void Set(Direction direction, AnimationClip value)
	{
		switch (direction)
		{
		case Direction.R_90:
			R_90 = value;
			break;
		case Direction.R_45:
			R_45 = value;
			break;
		case Direction.L_45:
			L_45 = value;
			break;
		case Direction.L_90:
			L_90 = value;
			break;
		case Direction.L_135:
			L_135 = value;
			break;
		case Direction.L_180:
			L_180 = value;
			break;
		case Direction.R_180:
			R_180 = value;
			break;
		case Direction.R_135:
			R_135 = value;
			break;
		default:
			throw AnimancerUtilities.CreateUnsupportedArgumentException(direction);
		}
	}

	public override void Set(int direction, AnimationClip value)
	{
		Set((Direction)direction, value);
	}

	public override int GetDirection(string name)
	{
		throw new NotImplementedException();
	}
}
