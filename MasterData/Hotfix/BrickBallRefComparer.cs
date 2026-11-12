using System.Collections.Generic;
using System.Runtime.CompilerServices;

public sealed class BrickBallRefComparer : IEqualityComparer<Brick_BallBase>
{
	public static readonly BrickBallRefComparer Instance = new BrickBallRefComparer();

	public bool Equals(Brick_BallBase x, Brick_BallBase y)
	{
		return (object)x == y;
	}

	public int GetHashCode(Brick_BallBase obj)
	{
		return RuntimeHelpers.GetHashCode(obj);
	}
}
