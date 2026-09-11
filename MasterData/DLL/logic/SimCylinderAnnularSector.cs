using System;

public class SimCylinderAnnularSector : IFramePooledObject
{
	private Int3 mWorldPos = Int3.zero;

	private int mInnerRadius = 400;

	private int mOutterRadius = 500;

	private int mDegree = 90;

	private int mHeight = 500;

	private Int3 mRightDir = Int3.forward;

	private Int3 mLeftDir = Int3.forward;

	public void SetNesscessaryProperty(int innerR, int outterR, Int3 location, Int3 forward, int height, int degree)
	{
		mInnerRadius = innerR;
		mOutterRadius = outterR;
		mWorldPos = location;
		mDegree = degree;
		mHeight = height;
		IntMath.sincos(out var s, out var c, 314 * IntMath.Clamp(mDegree, 1, 360), 36000L);
		long num = c.nom * s.den;
		long num2 = c.den * s.nom;
		long b = c.den * s.den;
		mRightDir.x = (int)IntMath.Divide(forward.x * num + forward.z * num2, b);
		mRightDir.z = (int)IntMath.Divide(-forward.x * num2 + forward.z * num, b);
		mRightDir.y = 0;
		num2 = -num2;
		mLeftDir.x = (int)IntMath.Divide(forward.x * num + forward.z * num2, b);
		mLeftDir.z = (int)IntMath.Divide(-forward.x * num2 + forward.z * num, b);
		mLeftDir.y = 0;
		mRightDir.Normalize();
		mLeftDir.Normalize();
	}

	public bool Intersects(ISimShape shape)
	{
		bool result = false;
		switch (shape.GetShapeType())
		{
		case SimShapeType.Box:
			result = Intersects((SimBox)shape);
			break;
		case SimShapeType.Sphere:
			result = Intersects((SimSphere)shape);
			break;
		case SimShapeType.CylinderSector:
			result = Intersects((SimCylinderSector)shape);
			break;
		default:
			throw new NotImplementedException();
		case SimShapeType.None:
			break;
		}
		return result;
	}

	public bool Intersects(SimBox obb)
	{
		bool flag = obb.RayCast(new SimRay(mWorldPos, mLeftDir), out var hitInfoIn, out var hitInfoInOut);
		bool flag2 = obb.RayCast(new SimRay(mWorldPos, mRightDir), out var hitInfoIn2, out var hitInfoInOut2);
		Int3 @int = obb.ClosestPoint(mWorldPos);
		long num = (@int - mWorldPos).sqrMagnitudeLong2D;
		if (!PointDirInSectorXZ(@int))
		{
			if (!flag && !flag2)
			{
				return false;
			}
			num = 2147483647L;
			if (flag && hitInfoIn.distance * hitInfoIn.distance < num)
			{
				num = hitInfoIn.distance * hitInfoIn.distance;
				@int = hitInfoIn.point;
			}
			if (flag2 && hitInfoIn2.distance * hitInfoIn2.distance < num)
			{
				num = hitInfoIn2.distance * hitInfoIn2.distance;
				@int = hitInfoIn2.point;
			}
		}
		if (num == int.MaxValue)
		{
			return false;
		}
		Int3 zero = Int3.zero;
		long num2 = -1L;
		Int3[] points = obb.GetPoints();
		for (int i = 0; i < 4; i++)
		{
			long sqrMagnitudeLong2D = (points[i] - mWorldPos).sqrMagnitudeLong2D;
			if (sqrMagnitudeLong2D > num2 && PointDirInSectorXZ(points[i]))
			{
				num2 = sqrMagnitudeLong2D;
				zero = points[i];
			}
		}
		if (flag && hitInfoInOut.distance * hitInfoInOut.distance > num2)
		{
			num2 = hitInfoInOut.distance * hitInfoInOut.distance;
			zero = hitInfoInOut.point;
		}
		if (flag2 && hitInfoInOut2.distance * hitInfoInOut2.distance > num2)
		{
			num2 = hitInfoInOut2.distance * hitInfoInOut2.distance;
			zero = hitInfoInOut2.point;
		}
		if (num2 == -1)
		{
			return false;
		}
		if (num > (long)mOutterRadius * (long)mOutterRadius || num2 < (long)mInnerRadius * (long)mInnerRadius)
		{
			return false;
		}
		return true;
	}

	public bool Intersects(SimSphere s)
	{
		Int3 worldPos = s.WorldPos;
		int num = s.Radius;
		int num2 = mHeight >> 1;
		int num3 = mWorldPos.y - num2;
		int num4 = mWorldPos.y + num2;
		if (worldPos.y + num <= num3 || worldPos.y - num >= num4)
		{
			return false;
		}
		if (mWorldPos.y > num4 || mWorldPos.y < num3)
		{
			int num5 = ((mWorldPos.y <= num4) ? (num3 - mWorldPos.y) : (mWorldPos.y - num4));
			num = IntMath.Sqrt((long)num * (long)num - num5 * num5);
		}
		if (PointDirInSectorXZ(worldPos))
		{
			long sqrMagnitudeLong2D = (worldPos - mWorldPos).sqrMagnitudeLong2D;
			if (sqrMagnitudeLong2D > (long)mOutterRadius * (long)mOutterRadius)
			{
				return sqrMagnitudeLong2D < ((long)num + (long)mOutterRadius) * ((long)num + (long)mOutterRadius);
			}
			if (sqrMagnitudeLong2D > (long)mInnerRadius * (long)mInnerRadius)
			{
				return true;
			}
			return mInnerRadius - num <= 0 || sqrMagnitudeLong2D > ((long)mInnerRadius - (long)num) * ((long)mInnerRadius - (long)num);
		}
		Int3 @int = ClosestPoint(worldPos, mWorldPos + IntMath.Divide(mLeftDir, mInnerRadius, 1000L), mLeftDir, mOutterRadius - mInnerRadius);
		long sqrMagnitudeLong2D2 = (worldPos - @int).sqrMagnitudeLong2D;
		if (sqrMagnitudeLong2D2 < num * num)
		{
			return true;
		}
		Int3 int2 = ClosestPoint(worldPos, mWorldPos + IntMath.Divide(mRightDir, mInnerRadius, 1000L), mRightDir, mOutterRadius - mInnerRadius);
		sqrMagnitudeLong2D2 = (worldPos - int2).sqrMagnitudeLong2D;
		return sqrMagnitudeLong2D2 < num * num;
	}

	public static Int3 ClosestPoint(Int3 point, Int3 lineStart, Int3 lineDir, int lineLen)
	{
		long a = Int3.DotXZLong(point - lineStart, lineDir);
		a = IntMath.Clamp(a, 0L, lineLen);
		return IntMath.Divide(lineDir, a, 1000L) + lineStart;
	}

	private static int CalcSide(Int3 point, Int3 lineStart, Int3 lineDir)
	{
		return lineDir.x * (point.z - lineStart.z) - (point.x - lineStart.x) * lineDir.z;
	}

	public bool PointDirInSectorXZ(Int3 point)
	{
		if (mDegree <= 180)
		{
			if (CalcSide(point, mWorldPos, mLeftDir) <= 0 && CalcSide(point, mWorldPos, mRightDir) >= 0)
			{
				return true;
			}
		}
		else if (CalcSide(point, mWorldPos, mLeftDir) <= 0 || CalcSide(point, mWorldPos, mRightDir) >= 0)
		{
			return true;
		}
		return false;
	}

	public bool Intersects(SimCylinderSector cs)
	{
		throw new NotImplementedException();
	}

	public void OnEnterPool()
	{
		mWorldPos = Int3.zero;
		mInnerRadius = 400;
		mOutterRadius = 500;
		mDegree = 90;
		mHeight = 500;
		mRightDir = Int3.forward;
		mLeftDir = Int3.forward;
	}
}
