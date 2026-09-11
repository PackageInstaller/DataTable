using System;

public class SimAnnulusSphere : IFramePooledObject
{
	private Int3 mWorldPos = Int3.zero;

	private int mInnerRadius = 400;

	private int mOutterRadius = 500;

	public void SetNesscessaryProperty(int innerR, int outterR, Int3 location)
	{
		mInnerRadius = innerR;
		mOutterRadius = outterR;
		mWorldPos = location;
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
		Int3 @int = obb.ClosestPoint(mWorldPos);
		long sqrMagnitudeLong = (@int - mWorldPos).sqrMagnitudeLong;
		long num = 0L;
		Int3[] points = obb.GetPoints();
		for (int i = 0; i < points.Length; i++)
		{
			long sqrMagnitudeLong2 = (points[i] - mWorldPos).sqrMagnitudeLong;
			if (sqrMagnitudeLong2 > num)
			{
				num = sqrMagnitudeLong2;
			}
		}
		bool flag = sqrMagnitudeLong > (long)mOutterRadius * (long)mOutterRadius || num < (long)mInnerRadius * (long)mInnerRadius;
		return !flag;
	}

	public bool Intersects(SimSphere s)
	{
		long sqrMagnitudeLong = (s.WorldPos - mWorldPos).sqrMagnitudeLong;
		bool flag = ((mInnerRadius >= s.Radius) ? (sqrMagnitudeLong > ((long)mOutterRadius + (long)s.Radius) * ((long)mOutterRadius + (long)s.Radius) || sqrMagnitudeLong < ((long)mInnerRadius - (long)s.Radius) * ((long)mInnerRadius - (long)s.Radius)) : (sqrMagnitudeLong > ((long)mOutterRadius + (long)s.Radius) * ((long)mOutterRadius + (long)s.Radius)));
		return !flag;
	}

	public bool Intersects(SimCylinderSector cs)
	{
		int num = cs.Height >> 1;
		int num2 = cs.WorldPos.y - num;
		int num3 = cs.WorldPos.y + num;
		if (mWorldPos.y + mOutterRadius <= num2 || mWorldPos.y - mOutterRadius >= num3)
		{
			return false;
		}
		long num4 = mInnerRadius;
		long num5 = mOutterRadius;
		if (mWorldPos.y > num3 || mWorldPos.y < num2)
		{
			int num6 = ((mWorldPos.y <= num3) ? (num2 - mWorldPos.y) : (mWorldPos.y - num3));
			num5 = (long)mOutterRadius * (long)mOutterRadius - num6 * num6;
			num4 = (long)mInnerRadius * (long)mInnerRadius - num6 * num6;
			num4 = ((num4 < 0) ? 0 : num4);
		}
		Int3 @int = SimCylinderSector.ClosestPointRightXZ(mWorldPos, cs);
		bool flag = (@int - mWorldPos).sqrMagnitudeLong2D > num5;
		if (flag)
		{
			@int = SimCylinderSector.ClosestPointLeftXZ(mWorldPos, cs);
			flag = (@int - mWorldPos).sqrMagnitudeLong2D > num5;
		}
		if (flag && SimCylinderSector.PointDirInSectorXZ(mWorldPos, cs))
		{
			long num7 = IntMath.Sqrt(num5) + cs.Radius;
			flag = (mWorldPos - cs.WorldPos).sqrMagnitudeLong2D > num7 * num7;
		}
		if (flag)
		{
			return false;
		}
		long num8 = SimCylinderSector.FarestSqrDistanceToLeftLineAndRightLineXZ(mWorldPos, cs);
		bool flag2 = num8 < num4;
		if (flag2)
		{
			Int3 point = cs.WorldPos + cs.WorldPos - mWorldPos;
			if (SimCylinderSector.PointDirInSectorXZ(point, cs))
			{
				long num9 = (mWorldPos - cs.WorldPos).magnitude2D + cs.Radius;
				flag2 = num9 * num9 < num4;
			}
		}
		if (flag2)
		{
			return false;
		}
		return true;
	}

	public void OnEnterPool()
	{
		mWorldPos = Int3.zero;
		mInnerRadius = 400;
		mOutterRadius = 500;
	}
}
