using System;
using Animancer;
using UnityEngine;

[CreateAssetMenu(menuName = "Animancer/Directional Animation Set/4 Directions Turning", order = 414)]
internal class DirectionalAnimationSet4_Turning : DirectionalSet<AnimationClip>
{
	public enum Direction
	{
		R_90,
		L_90,
		L_180,
		R_180
	}

	[SerializeField]
	private AnimationClip _R_90;

	[SerializeField]
	private AnimationClip _R_180;

	[SerializeField]
	private AnimationClip _L_90;

	[SerializeField]
	private AnimationClip _L_180;

	public float turnTolerance = 22.5f;

	public override int DirectionCount => 4;

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

	public static Direction VectorToDirection(Vector2 direction, float turnTolerance = 0f)
	{
		float num = Vector2.SignedAngle(Vector2.up, direction);
		if (num >= 0f && num < 90f + turnTolerance)
		{
			return Direction.L_90;
		}
		if (num >= -90f - turnTolerance && num < 0f)
		{
			return Direction.R_90;
		}
		if (num < -180f)
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
			Direction.L_90 => L_90, 
			Direction.L_180 => L_180, 
			Direction.R_180 => R_180, 
			_ => throw AnimancerUtilities.CreateUnsupportedArgumentException(direction), 
		};
	}

	public static Vector2 DirectionToVector(Direction direction)
	{
		return direction switch
		{
			Direction.R_90 => Vector2.right, 
			Direction.L_90 => Vector2.left, 
			Direction.L_180 => Vector2.down, 
			Direction.R_180 => Vector2.down, 
			_ => throw AnimancerUtilities.CreateUnsupportedArgumentException(direction), 
		};
	}

	public override Vector2 GetDirection(int direction)
	{
		return DirectionToVector((Direction)direction);
	}

	public static Vector2 SnapVectorToDirection(Vector2 vector, float turnTolerance = 0f)
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
		case Direction.L_90:
			L_90 = value;
			break;
		case Direction.L_180:
			L_180 = value;
			break;
		case Direction.R_180:
			R_180 = value;
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
