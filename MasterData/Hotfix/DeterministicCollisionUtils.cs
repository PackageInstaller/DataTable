using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;

public static class DeterministicCollisionUtils
{
	internal class DeterministicRaycastHitComparer : IComparer<DeterministicRaycastHit>
	{
		public int Compare(DeterministicRaycastHit x, DeterministicRaycastHit y)
		{
			if (x.distance < y.distance)
			{
				return -1;
			}
			if (!(x.distance > y.distance))
			{
				return 0;
			}
			return 1;
		}
	}

	internal static readonly DistanceInput _internalDistanceInput = new DistanceInput();

	internal static bool IsColliderFilter(DeterministicCollider collider, int layerMask)
	{
		if (!(collider == null) && !collider.IgnoreCollision)
		{
			return (collider.CollisionLayerFlag & layerMask) == 0;
		}
		return true;
	}

	internal static bool TestOverlap(Shape shapeA, Shape shapeB, ref Transform xfA, ref Transform xfB, bool refreshShapeAProxy = true, bool refreshShapeBProxy = true)
	{
		if (shapeA.ShapeType == ShapeType.Circle && shapeB.ShapeType == ShapeType.Circle)
		{
			CircleShape circleShape = (CircleShape)shapeA;
			CircleShape circleShape2 = (CircleShape)shapeB;
			TSVector2 value = MathUtils.Mul(ref xfA, circleShape.Position);
			TSVector2 value2 = MathUtils.Mul(ref xfB, circleShape2.Position);
			FP fP = TSVector2.DistanceSquared(value, value2);
			FP fP2 = (circleShape.Radius + circleShape2.Radius) * (circleShape.Radius + circleShape2.Radius);
			return fP <= fP2;
		}
		if (refreshShapeAProxy)
		{
			_internalDistanceInput.ProxyA.Set(shapeA, 0);
			_internalDistanceInput.TransformA = xfA;
		}
		if (refreshShapeBProxy)
		{
			_internalDistanceInput.ProxyB.Set(shapeB, 0);
			_internalDistanceInput.TransformB = xfB;
		}
		_internalDistanceInput.UseRadii = true;
		Distance.ComputeDistance(out var output, out var _, _internalDistanceInput);
		return output.Distance < 10f * Settings.Epsilon;
	}

	internal static void CreateLineShape(PolygonShape shape, TSVector2 start, TSVector2 end)
	{
		Vertices vertices = shape.Vertices;
		vertices.Clear();
		vertices.Add(start);
		vertices.Add(end);
	}

	internal static void CreateRectangleShape(PolygonShape shape, FP hx, FP hy)
	{
		Vertices vertices = shape.Vertices;
		vertices.Clear();
		vertices.Add(new TSVector2(-hx, -hy));
		vertices.Add(new TSVector2(hx, -hy));
		vertices.Add(new TSVector2(hx, hy));
		vertices.Add(new TSVector2(-hx, hy));
	}

	internal static void CreateCircleShape(PolygonShape shape, FP radius, int numberOfEdges)
	{
		Vertices vertices = shape.Vertices;
		vertices.Clear();
		FP fP = FP.PiTimes2 / numberOfEdges;
		vertices.Add(new TSVector2(radius, 0));
		for (int num = numberOfEdges - 1; num > 0; num--)
		{
			vertices.Add(new TSVector2(radius * FP.Cos(fP * num), -radius * FP.Sin(fP * num)));
		}
	}

	internal static void CreateFanShape(PolygonShape shape, FP radians, int sides, FP radius)
	{
		Vertices vertices = shape.Vertices;
		vertices.Clear();
		FP fP = radians / sides;
		vertices.Add(new TSVector2(0, 0));
		for (int num = sides; num >= 0; num--)
		{
			vertices.Add(new TSVector2(radius * FP.Cos(fP * num), radius * FP.Sin(fP * num)));
		}
	}

	public static bool TestSimpleOverLap_Rect2Circle(TSVector2 rectPos, FP rectRot, FP rectWidth, FP rectLength, TSVector2 circlePos, FP circleRaidus)
	{
		TSVector2 v = circlePos - rectPos;
		v = TSVector2.Rotate(v, -rectRot);
		TSVector2 tSVector = new TSVector2(FP.Abs(v.x), FP.Abs(v.y));
		FP fP = rectWidth * 0.5f;
		FP fP2 = rectLength * 0.5f;
		if (FP.Abs(v.x) <= fP && FP.Abs(v.y) <= fP2)
		{
			return true;
		}
		if (tSVector.x < fP)
		{
			return FP.Abs(fP2 - tSVector.y) < circleRaidus;
		}
		if (tSVector.y < fP2)
		{
			return FP.Abs(fP - tSVector.x) < circleRaidus;
		}
		return TSVector2.DistanceSquared(tSVector.x, tSVector.y, fP, fP2) < circleRaidus * circleRaidus;
	}

	public static bool TestSimpleOverLap_Circle2Circle(TSVector2 circlePosA, FP radiusA, FP innerRadiusA, TSVector2 circlePosB, FP radiusB)
	{
		FP fP = TSVector2.DistanceSquared(circlePosA, circlePosB);
		FP fP2 = radiusA + radiusB;
		FP fP3 = fP2 * fP2;
		if (fP >= fP3)
		{
			return false;
		}
		if (innerRadiusA <= 0)
		{
			return true;
		}
		if (innerRadiusA <= radiusB)
		{
			return true;
		}
		FP fP4 = innerRadiusA - radiusB;
		return fP4 * fP4 <= fP;
	}

	public static bool TestSimpleOverLap_Fan2Circle(TSVector2 fanPos, FP fanRot, FP fanAngle, FP fanRadius, FP fanInnerRadius, TSVector2 circlePos, FP circleRaidus)
	{
		TSVector2 v = circlePos - fanPos;
		FP fP = v.LengthSquared();
		FP fP2 = fanRadius + circleRaidus;
		if (fP >= fP2 * fP2)
		{
			return false;
		}
		if (FP.Abs(v.GetAngle() - fanRot) <= fanAngle * 0.5f)
		{
			if (fanInnerRadius > 0)
			{
				return fP >= fanInnerRadius * fanInnerRadius * 0.25f;
			}
			return true;
		}
		TSVector2 tSVector = TSVector2.Rotate(v, -fanRot);
		tSVector = new TSVector2(FP.Abs(tSVector.x), tSVector.y);
		TSVector2 tSVector2 = TSVector2.zero;
		if (fanInnerRadius > 0)
		{
			tSVector2 = fanInnerRadius * new TSVector2(FP.Sin(fanAngle * 0.5f * FP.Deg2Rad), FP.Cos(fanAngle * 0.5f * FP.Deg2Rad));
		}
		TSVector2 sectionV = fanRadius * new TSVector2(FP.Sin(fanAngle * 0.5f * FP.Deg2Rad), FP.Cos(fanAngle * 0.5f * FP.Deg2Rad)) - tSVector2;
		return GetMinSqrDisP2V(tSVector2, sectionV, tSVector) < circleRaidus * circleRaidus;
		static FP GetMinSqrDisP2V(TSVector2 startPoint, TSVector2 tSVector3, TSVector2 targetPoint)
		{
			FP value = TSVector2.Dot(targetPoint - startPoint, tSVector3) / tSVector3.LengthSquared();
			return (targetPoint - (startPoint + TSMath.Clamp01(value) * tSVector3)).LengthSquared();
		}
	}
}
