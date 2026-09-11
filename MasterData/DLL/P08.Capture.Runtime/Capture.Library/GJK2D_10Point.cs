using UnityEngine;

namespace Capture.Library;

public class GJK2D_10Point
{
	private Simplex simplex = new Simplex();

	public Shape2D_10Point shapeA;

	public Shape2D_10Point shapeB;

	public int maxIterCount = 10;

	public float eps = 1E-06f;

	public Vector2 direction;

	public bool isCollision;

	public bool queryCollision(Shape2D_10Point shapeA, Shape2D_10Point shapeB)
	{
		this.shapeA = shapeA;
		this.shapeB = shapeB;
		simplex.clear();
		isCollision = false;
		direction = Vector2.zero;
		direction = findFirstDirection();
		simplex.add(support(direction));
		direction = -direction;
		for (int i = 0; i < maxIterCount; i++)
		{
			if (direction.sqrMagnitude < eps)
			{
				isCollision = true;
				break;
			}
			simplex.add(support(direction));
			if (Vector2.Dot(simplex.getLast(), direction) < eps)
			{
				isCollision = false;
				break;
			}
			if (simplex.contains(Vector2.zero))
			{
				isCollision = true;
				break;
			}
			direction = findNextDirection();
		}
		return isCollision;
	}

	public Vector2 findFirstDirection()
	{
		Vector2 result = shapeA[0] - shapeB[0];
		if (result.sqrMagnitude < eps)
		{
			result = shapeA[1] - shapeB[0];
		}
		return result;
	}

	public Vector2 support(Vector2 dir)
	{
		Vector2 farthestPointInDirection = shapeA.getFarthestPointInDirection(dir);
		Vector2 farthestPointInDirection2 = shapeB.getFarthestPointInDirection(-dir);
		return farthestPointInDirection - farthestPointInDirection2;
	}

	public Vector2 findNextDirection()
	{
		if (simplex.count() == 2)
		{
			Vector2 perpendicularToOrigin = GJKTool.getPerpendicularToOrigin(simplex.get(0), simplex.get(1));
			return Vector2.zero - perpendicularToOrigin;
		}
		if (simplex.count() == 3)
		{
			Vector2 perpendicularToOrigin2 = GJKTool.getPerpendicularToOrigin(simplex.get(2), simplex.get(0));
			Vector2 perpendicularToOrigin3 = GJKTool.getPerpendicularToOrigin(simplex.get(2), simplex.get(1));
			if (perpendicularToOrigin2.sqrMagnitude < perpendicularToOrigin3.sqrMagnitude)
			{
				simplex.remove(1);
				return Vector2.zero - perpendicularToOrigin2;
			}
			simplex.remove(0);
			return Vector2.zero - perpendicularToOrigin3;
		}
		return new Vector2(0f, 0f);
	}
}
