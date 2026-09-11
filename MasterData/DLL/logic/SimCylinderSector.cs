using System;
using Config;

public class SimCylinderSector : ISimShape, IFramePooledObject
{
	private int mRadius = 500;

	private int mDegree = 90;

	private int mRotation;

	private int mHeight = 500;

	private Int3 mWorldPos = Int3.zero;

	private Int3 mRightDir = Int3.forward;

	private Int3 mLeftDir = Int3.forward;

	private bool mIsDirty;

	private ABOX mABox;

	private Int3 mForward;

	public int ID { get; set; }

	public int OwnerID { get; set; }

	public RoleType Layer { get; set; }

	public Int3 WorldPos
	{
		get
		{
			return mWorldPos;
		}
		set
		{
			mIsDirty = false;
			mWorldPos = value;
		}
	}

	public int Radius
	{
		get
		{
			return mRadius;
		}
		set
		{
			mRadius = value;
			mIsDirty = true;
		}
	}

	public int Degree
	{
		get
		{
			return mDegree;
		}
		set
		{
			mDegree = IntMath.Clamp(value, 1, 360);
			mIsDirty = true;
		}
	}

	public int Height
	{
		get
		{
			return mHeight;
		}
		set
		{
			mHeight = IntMath.Max(0, value);
			mIsDirty = true;
		}
	}

	public int Rotation
	{
		get
		{
			return mRotation;
		}
		set
		{
			mRotation = value;
			mIsDirty = true;
		}
	}

	public int AvgCollisionRadius => mRadius;

	public Int3 Forward => mForward;

	public bool IsEnable { get; set; }

	public bool IgnoreHit { get; set; }

	public bool IgnoreCollision { get; set; }

	public static long FarestSqrDistanceToLeftLineAndRightLineXZ(Int3 point, SimCylinderSector cs)
	{
		long sqrMagnitudeLong2D = (point - cs.WorldPos).sqrMagnitudeLong2D;
		Int3 @int = cs.WorldPos + IntMath.Divide(cs.mLeftDir, cs.Radius, 1000L);
		Int3 int2 = cs.WorldPos + IntMath.Divide(cs.mRightDir, cs.Radius, 1000L);
		long sqrMagnitudeLong2D2 = (point - @int).sqrMagnitudeLong2D;
		sqrMagnitudeLong2D = ((sqrMagnitudeLong2D2 > sqrMagnitudeLong2D) ? sqrMagnitudeLong2D2 : sqrMagnitudeLong2D);
		sqrMagnitudeLong2D2 = (point - int2).sqrMagnitudeLong2D;
		return (sqrMagnitudeLong2D2 > sqrMagnitudeLong2D) ? sqrMagnitudeLong2D2 : sqrMagnitudeLong2D;
	}

	public static Int3 ClosestPointLeftXZ(Int3 point, SimCylinderSector cs)
	{
		return ClosestPoint(ref point, ref cs.mWorldPos, ref cs.mLeftDir, cs.Radius);
	}

	public static Int3 ClosestPointRightXZ(Int3 point, SimCylinderSector cs)
	{
		return ClosestPoint(ref point, ref cs.mWorldPos, ref cs.mRightDir, cs.Radius);
	}

	private static Int3 ClosestPoint(ref Int3 point, ref Int3 lineStart, ref Int3 lineDir, int lineLen)
	{
		long a = Int3.DotXZLong(point - lineStart, lineDir);
		a = IntMath.Clamp(a, 0L, lineLen);
		return IntMath.Divide(lineDir, a, 1000L) + lineStart;
	}

	private static int CalcSide(ref Int3 point, ref Int3 lineStart, ref Int3 lineDir)
	{
		return lineDir.x * (point.z - lineStart.z) - (point.x - lineStart.x) * lineDir.z;
	}

	public bool EdgeIntersects(SimCylinderSector cs)
	{
		return false;
	}

	public bool EdgeIntersects(SimSphere s)
	{
		return Intersects(s);
	}

	public bool EdgeIntersects(SimBox obb)
	{
		return false;
	}

	public SimShapeType GetShapeType()
	{
		return SimShapeType.CylinderSector;
	}

	public bool Intersects(SimCylinderSector cs)
	{
		return false;
	}

	public bool Intersects(SimSphere s)
	{
		Int3 point = s.WorldPos;
		int radius = s.Radius;
		int num = mHeight >> 1;
		int num2 = mWorldPos.y - num;
		int num3 = mWorldPos.y + num;
		if (point.y + radius <= num2 || point.y - radius >= num3)
		{
			return false;
		}
		int num4 = radius;
		if (point.y > num3 || point.y < num2)
		{
			int num5 = ((point.y <= num3) ? (num2 - point.y) : (point.y - num3));
			long a = (long)radius * (long)radius - num5 * num5;
			num4 = IntMath.Sqrt(a);
		}
		long num6 = num4 + mRadius;
		if ((mWorldPos - point).sqrMagnitudeLong2D >= num6 * num6)
		{
			return false;
		}
		int num7 = radius * radius;
		Int3 @int = ClosestPoint(ref point, ref mWorldPos, ref mLeftDir, mRadius);
		if ((@int - point).sqrMagnitudeLong2D <= num7)
		{
			return true;
		}
		@int = ClosestPoint(ref point, ref mWorldPos, ref mRightDir, mRadius);
		if ((@int - point).sqrMagnitudeLong2D <= num7)
		{
			return true;
		}
		if (mDegree <= 180)
		{
			if (CalcSide(ref point, ref mWorldPos, ref mLeftDir) <= 0 && CalcSide(ref point, ref mWorldPos, ref mRightDir) >= 0)
			{
				return true;
			}
		}
		else if (CalcSide(ref point, ref mWorldPos, ref mLeftDir) <= 0 || CalcSide(ref point, ref mWorldPos, ref mRightDir) >= 0)
		{
			return true;
		}
		return false;
	}

	public static bool PointDirInSectorXZ(Int3 point, SimCylinderSector cs)
	{
		if (cs.Degree <= 180)
		{
			if (CalcSide(ref point, ref cs.mWorldPos, ref cs.mLeftDir) <= 0 && CalcSide(ref point, ref cs.mWorldPos, ref cs.mRightDir) >= 0)
			{
				return true;
			}
		}
		else if (CalcSide(ref point, ref cs.mWorldPos, ref cs.mLeftDir) <= 0 || CalcSide(ref point, ref cs.mWorldPos, ref cs.mRightDir) >= 0)
		{
			return true;
		}
		return false;
	}

	public bool Intersects(SimBox obb)
	{
		Int3 point = obb.ClosestPoint(WorldPos);
		if ((point - WorldPos).sqrMagnitudeLong2D > Radius * Radius)
		{
			return false;
		}
		if (obb.RayCast(new SimRay(WorldPos, mLeftDir), out var hitInfo) && hitInfo.distance < mRadius)
		{
			return true;
		}
		if (obb.RayCast(new SimRay(WorldPos, mRightDir), out hitInfo) && hitInfo.distance < mRadius)
		{
			return true;
		}
		if (mDegree <= 180)
		{
			if (CalcSide(ref point, ref mWorldPos, ref mLeftDir) <= 0 && CalcSide(ref point, ref mWorldPos, ref mRightDir) >= 0)
			{
				return true;
			}
		}
		else if (CalcSide(ref point, ref mWorldPos, ref mLeftDir) <= 0 || CalcSide(ref point, ref mWorldPos, ref mRightDir) >= 0)
		{
			return true;
		}
		return false;
	}

	public void UpdateWorldShape(Int3 location, Int3 forward)
	{
		mForward = forward;
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
		mIsDirty = false;
		Int3 @int = new Int3(Radius, Radius, Radius);
		mABox = new ABOX(mWorldPos - @int, mWorldPos + @int);
	}

	public void UpdateShape(Int3 location, Int3 forward, int moveDelta)
	{
	}

	public static void UpdatePosition(ref Int3 worldPos, ref Int3 localPos, ref Int3 location, ref Int3 forward)
	{
		if (localPos.x == 0 && localPos.z == 0)
		{
			worldPos.x = localPos.x + location.x;
			worldPos.y = localPos.y + location.y;
			worldPos.z = localPos.z + location.z;
		}
		else
		{
			Int3 lhs = Int3.up;
			Int3 rhs = forward;
			Int3 axis_x = Int3.Cross(ref lhs, ref rhs);
			Int3 trans = location;
			worldPos = IntMath.Transform(ref localPos, ref axis_x, ref lhs, ref rhs, ref trans);
		}
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
		}
		return result;
	}

	public bool EdgeIntersects(ISimShape shape)
	{
		bool result = false;
		switch (shape.GetShapeType())
		{
		case SimShapeType.Box:
			result = EdgeIntersects((SimBox)shape);
			break;
		case SimShapeType.Sphere:
			result = EdgeIntersects((SimSphere)shape);
			break;
		case SimShapeType.CylinderSector:
			result = EdgeIntersects((SimCylinderSector)shape);
			break;
		}
		return result;
	}

	public ABOX GetABBB()
	{
		return mABox;
	}

	public void GetAABB2D(out Int2 lt, out Int2 size)
	{
		lt = mWorldPos.xz;
		lt.x -= mRadius;
		lt.y -= mRadius;
		size.x = mRadius + mRadius;
		size.y = size.x;
	}

	public bool RayCast(SimRay ray, out SimRaycastHitInfo hitInfo)
	{
		throw new NotImplementedException();
	}

	public void OnEnterPool()
	{
		mRadius = 500;
		mDegree = 90;
		mRotation = 0;
		mHeight = 500;
		mWorldPos = Int3.zero;
		mRightDir = Int3.forward;
		mLeftDir = Int3.forward;
		mIsDirty = false;
		ID = 0;
		OwnerID = 0;
		Layer = RoleType.None;
	}
}
