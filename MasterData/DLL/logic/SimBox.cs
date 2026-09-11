using System;
using Config;

public class SimBox : ISimShape, IFramePooledObject
{
	private bool mIsDirty;

	private Int3 mCenter = Int3.zero;

	private Int3 mSize = Int3.one;

	private Int3 mWorldPos = Int3.zero;

	private Int3 mWorldExtends = Int3.half;

	private int mWorldRadius;

	private Int3[] mAxis = new Int3[3]
	{
		new Int3(1000, 0, 0),
		new Int3(0, 1000, 0),
		new Int3(0, 0, 1000)
	};

	private Int3 _tempDist;

	private long _tempRadius;

	private ABOX mABox;

	private Int3[] array = new Int3[8]
	{
		new Int3(-1, 1, -1),
		new Int3(1, 1, -1),
		new Int3(1, 1, 1),
		new Int3(-1, 1, 1),
		new Int3(-1, -1, -1),
		new Int3(1, -1, -1),
		new Int3(1, -1, 1),
		new Int3(-1, -1, 1)
	};

	private Int3[] array2 = new Int3[8]
	{
		new Int3(-1, 1, -1),
		new Int3(1, 1, -1),
		new Int3(1, 1, 1),
		new Int3(-1, 1, 1),
		new Int3(-1, -1, -1),
		new Int3(1, -1, -1),
		new Int3(1, -1, 1),
		new Int3(-1, -1, 1)
	};

	public int WorldRadius => mWorldRadius;

	public RoleType Layer { get; set; }

	public Int3 Center
	{
		get
		{
			return mCenter;
		}
		set
		{
			mCenter = value;
			mIsDirty = true;
		}
	}

	public Int3 Size
	{
		get
		{
			return mSize;
		}
		set
		{
			mSize = value;
			mIsDirty = true;
		}
	}

	public Int3 WorldExtends => mWorldExtends;

	public Int3 WorldPos => mWorldPos;

	public Int3 AxisX => mAxis[0];

	public Int3 AxisY => mAxis[1];

	public Int3 AxisZ => mAxis[2];

	public Int3 Forward => AxisZ;

	public int AvgCollisionRadius
	{
		get
		{
			int num = mWorldExtends.x + mWorldExtends.z;
			return num >> 1;
		}
	}

	public int ID { get; set; }

	public int OwnerID { get; set; }

	public bool IsEnable { get; set; }

	public bool IgnoreHit { get; set; }

	public bool IgnoreCollision { get; set; }

	public SimBox()
	{
		mIsDirty = false;
		mCenter = Int3.zero;
		mSize = Int3.one;
		mWorldPos = Int3.zero;
		mWorldExtends = Int3.half;
		mWorldRadius = 0;
	}

	public bool EdgeIntersects(SimCylinderSector cs)
	{
		return cs.EdgeIntersects(this);
	}

	public bool EdgeIntersects(SimSphere s)
	{
		return false;
	}

	public bool EdgeIntersects(SimBox obb)
	{
		return false;
	}

	public void GetAABB2D(out Int2 lt, out Int2 size)
	{
		lt = Int2.zero;
		size = Int2.zero;
	}

	public SimShapeType GetShapeType()
	{
		return SimShapeType.Box;
	}

	public bool IntersectsOBB(SimBox b)
	{
		long num = mWorldRadius + b.mWorldRadius;
		if ((mWorldPos - b.mWorldPos).sqrMagnitudeLong > num * num)
		{
			return false;
		}
		Int3 @int = new Int3(IntMath.Divide(Int3.Dot(mAxis[0], b.mAxis[0]), 1000), IntMath.Divide(Int3.Dot(mAxis[0], b.mAxis[1]), 1000), IntMath.Divide(Int3.Dot(mAxis[0], b.mAxis[2]), 1000));
		Int3 int2 = new Int3(IntMath.Divide(Int3.Dot(mAxis[1], b.mAxis[0]), 1000), IntMath.Divide(Int3.Dot(mAxis[1], b.mAxis[1]), 1000), IntMath.Divide(Int3.Dot(mAxis[1], b.mAxis[2]), 1000));
		Int3 int3 = new Int3(IntMath.Divide(Int3.Dot(mAxis[2], b.mAxis[0]), 1000), IntMath.Divide(Int3.Dot(mAxis[2], b.mAxis[1]), 1000), IntMath.Divide(Int3.Dot(mAxis[2], b.mAxis[2]), 1000));
		Int3 abs = @int.abs;
		Int3 abs2 = int2.abs;
		Int3 abs3 = int3.abs;
		Int3 lhs = b.mWorldPos - mWorldPos;
		lhs = new Int3(IntMath.Divide(Int3.Dot(lhs, mAxis[0]), 1000), IntMath.Divide(Int3.Dot(lhs, mAxis[1]), 1000), IntMath.Divide(Int3.Dot(lhs, mAxis[2]), 1000));
		int num2 = mWorldExtends.x * 1000;
		int num3 = Int3.Dot(b.mWorldExtends, abs);
		if (IntMath.Abs(lhs.x) * 1000 > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.y * 1000;
		num3 = Int3.Dot(b.mWorldExtends, abs2);
		if (IntMath.Abs(lhs.y) * 1000 > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.z * 1000;
		num3 = Int3.Dot(b.mWorldExtends, abs3);
		if (Math.Abs(lhs.z) * 1000 > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs.x + mWorldExtends.y * abs2.x + mWorldExtends.z * abs3.x;
		num3 = b.mWorldExtends.x * 1000;
		if (Math.Abs(lhs.x * @int.x + lhs.y * int2.x + lhs.z * int3.x) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs.y + mWorldExtends.y * abs2.y + mWorldExtends.z * abs3.y;
		num3 = b.mWorldExtends.y * 1000;
		if (Math.Abs(lhs.x * @int.y + lhs.y * int2.y + lhs.z * int3.y) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs.z + mWorldExtends.y * abs2.z + mWorldExtends.z * abs3.z;
		num3 = b.mWorldExtends.z * 1000;
		if (Math.Abs(lhs.x * @int.z + lhs.y * int2.z + lhs.z * int3.z) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.y * abs3.x + mWorldExtends.z * abs2.x;
		num3 = b.mWorldExtends.y * abs.z + b.mWorldExtends.z * abs.y;
		if (Math.Abs(lhs.z * int2.x - lhs.y * int3.x) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.y * abs3.y + mWorldExtends.z * abs2.y;
		num3 = b.mWorldExtends.x * abs.z + b.mWorldExtends.z * abs.x;
		if (Math.Abs(lhs.z * int2.y - lhs.y * int3.y) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.y * abs3.z + mWorldExtends.z * abs2.z;
		num3 = b.mWorldExtends.x * abs.y + b.mWorldExtends.y * abs.x;
		if (Math.Abs(lhs.z * int2.z - lhs.y * int3.z) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs3.x + mWorldExtends.z * abs.x;
		num3 = b.mWorldExtends.y * abs2.z + b.mWorldExtends.z * abs2.y;
		if (Math.Abs(lhs.x * int3.x - lhs.z * @int.x) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs3.y + mWorldExtends.z * abs.y;
		num3 = b.mWorldExtends.x * abs2.z + b.mWorldExtends.z * abs2.x;
		if (Math.Abs(lhs.x * int3.y - lhs.z * @int.y) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs3.z + mWorldExtends.z * abs.z;
		num3 = b.mWorldExtends.x * abs2.y + b.mWorldExtends.y * abs2.x;
		if (Math.Abs(lhs.x * int3.z - lhs.z * @int.z) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs2.x + mWorldExtends.y * abs.x;
		num3 = b.mWorldExtends.y * abs3.z + b.mWorldExtends.z * abs3.y;
		if (Math.Abs(lhs.y * @int.x - lhs.x * int2.x) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs2.y + mWorldExtends.y * abs.y;
		num3 = b.mWorldExtends.x * abs3.z + b.mWorldExtends.z * abs3.x;
		if (Math.Abs(lhs.y * @int.y - lhs.x * int2.y) > num2 + num3)
		{
			return false;
		}
		num2 = mWorldExtends.x * abs2.z + mWorldExtends.y * abs.z;
		num3 = b.mWorldExtends.x * abs3.y + b.mWorldExtends.y * abs3.x;
		return Math.Abs(lhs.y * @int.z - lhs.x * int2.z) <= num2 + num3;
	}

	public bool Intersects(SimCylinderSector cs)
	{
		return cs.Intersects(this);
	}

	public bool Intersects(SimSphere s)
	{
		_tempRadius = mWorldRadius + s.Radius;
		_tempDist = mWorldPos - s.WorldPos;
		if (_tempDist.sqrMagnitudeLong > _tempRadius * _tempRadius)
		{
			return false;
		}
		Int3 worldPos = s.WorldPos;
		Int3 @int = ClosestPoint(worldPos);
		return (worldPos - @int).sqrMagnitudeLong <= s.Radius * s.Radius;
	}

	public bool Intersects(SimBox obb)
	{
		return IntersectsOBB(obb);
	}

	private ABOX CreateABOX(Int3 worldPosition, Int3 forward)
	{
		mWorldRadius = (int)mWorldExtends.LongMagnitude;
		int num = mWorldRadius;
		Int3 min = worldPosition - new Int3(num, num, num);
		Int3 max = worldPosition + new Int3(num, num, num);
		return new ABOX(min, max);
	}

	public void UpdateWorldShape(Int3 worldPosition, Int3 forward)
	{
		mAxis[2] = forward;
		mAxis[0] = Int3.Cross(Int3.up, mAxis[2]).NormalizeTo(1000);
		mAxis[1] = Int3.Cross(mAxis[2], mAxis[0]).NormalizeTo(1000);
		mWorldPos = worldPosition;
		mWorldExtends.x = mSize.x >> 1;
		mWorldExtends.y = mSize.y >> 1;
		mWorldExtends.z = mSize.z >> 1;
		mWorldRadius = (int)mWorldExtends.LongMagnitude;
		mIsDirty = false;
		mABox = CreateABOX(worldPosition, forward);
	}

	public void UpdateShape(Int3 center, Int3 forward)
	{
		mAxis[2] = forward;
		mAxis[0] = Int3.Cross(Int3.up, mAxis[2]).NormalizeTo(1000);
		mAxis[1] = Int3.Cross(ref mAxis[2], ref mAxis[0]).NormalizeTo(1000);
		mWorldPos = IntMath.Transform(ref mCenter, ref mAxis[0], ref mAxis[1], ref mAxis[2], ref center);
		mWorldExtends.x = mSize.x >> 1;
		mWorldExtends.y = mSize.y >> 1;
		mWorldExtends.z = mSize.z >> 1;
		mWorldRadius = (int)mWorldExtends.LongMagnitude;
		mIsDirty = false;
		mABox = CreateABOX(mWorldPos, forward);
	}

	public void UpdateShape(Int3 location, Int3 forward, int moveDelta)
	{
		mAxis[2] = forward;
		mAxis[0] = Int3.Cross(Int3.up, mAxis[2]).NormalizeTo(1000);
		mAxis[1] = Int3.Cross(ref mAxis[2], ref mAxis[0]).NormalizeTo(1000);
		location += forward.NormalizeTo(moveDelta >> 1);
		mWorldPos = IntMath.Transform(ref mCenter, ref mAxis[0], ref mAxis[1], ref mAxis[2], ref location);
		mWorldExtends.x = mSize.x >> 1;
		mWorldExtends.y = mSize.y >> 1;
		mWorldExtends.z = mSize.z + moveDelta >> 1;
		mWorldRadius = (int)mWorldExtends.LongMagnitude;
		mIsDirty = false;
		mABox = CreateABOX(mWorldPos, forward);
	}

	public Int3 ClosestPoint(Int3 targetPoint)
	{
		Int3 lhs = targetPoint - mWorldPos;
		Int3 @int = mWorldPos;
		int num = mWorldExtends.x * 1000;
		int num2 = mWorldExtends.y * 1000;
		int num3 = mWorldExtends.z * 1000;
		@int += IntMath.Divide(mAxis[0], IntMath.Clamp(Int3.Dot(lhs, mAxis[0]), -num, num), 1000000L);
		@int += IntMath.Divide(mAxis[1], IntMath.Clamp(Int3.Dot(lhs, mAxis[1]), -num2, num2), 1000000L);
		return @int + IntMath.Divide(mAxis[2], IntMath.Clamp(Int3.Dot(lhs, mAxis[2]), -num3, num3), 1000000L);
	}

	public Int3[] GetPoints()
	{
		Int3 zero = Int3.zero;
		Int3 @int = mWorldExtends;
		Int3 int2 = mAxis[0];
		Int3 int3 = mAxis[1];
		Int3 int4 = mAxis[2];
		for (int i = 0; i < 8; i++)
		{
			zero.x = array[i].x * @int.x;
			zero.y = array[i].y * @int.y;
			zero.z = array[i].z * @int.z;
			Int3 int5 = int2 * zero.x;
			int5 += int3 * zero.y;
			int5 += int4 * zero.z;
			array2[i] = IntMath.Divide(int5 + mWorldPos * 1000, 1000);
		}
		return array2;
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

	public bool RayCast(SimRay ray, out SimRaycastHitInfo hitInfo)
	{
		Int3 point = ray.origin - mWorldPos;
		Int3 orgin = IntMath.InvertTransform(ref point, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		Int3 direction = IntMath.InvertTransform(ref ray.direction, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		SimRay ray2 = new SimRay(orgin, direction);
		if (!IntersectRayAABB(ray2, WorldExtends, out hitInfo))
		{
			return false;
		}
		hitInfo.normal = IntMath.Transform(ref hitInfo.normal, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		hitInfo.point = IntMath.Transform(ref hitInfo.point, ref mAxis[0], ref mAxis[1], ref mAxis[2], ref mWorldPos);
		return true;
	}

	public bool RayCast(SimRay ray, out SimRaycastHitInfo hitInfoIn, out SimRaycastHitInfo hitInfoInOut)
	{
		Int3 point = ray.origin - mWorldPos;
		Int3 orgin = IntMath.InvertTransform(ref point, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		Int3 direction = IntMath.InvertTransform(ref ray.direction, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		SimRay ray2 = new SimRay(orgin, direction);
		if (!IntersectRayAABB(ray2, WorldExtends, out hitInfoIn, out hitInfoInOut))
		{
			return false;
		}
		hitInfoIn.normal = IntMath.Transform(ref hitInfoIn.normal, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		hitInfoIn.point = IntMath.Transform(ref hitInfoIn.point, ref mAxis[0], ref mAxis[1], ref mAxis[2], ref mWorldPos);
		hitInfoInOut.normal = IntMath.Transform(ref hitInfoInOut.normal, ref mAxis[0], ref mAxis[1], ref mAxis[2]);
		hitInfoInOut.point = IntMath.Transform(ref hitInfoInOut.point, ref mAxis[0], ref mAxis[1], ref mAxis[2], ref mWorldPos);
		return true;
	}

	public static bool IntersectRayAABB(SimRay ray, Int3 dimension, out SimRaycastHitInfo hitInfo, int distance = int.MaxValue)
	{
		hitInfo = default(SimRaycastHitInfo);
		Int3 @int = -dimension;
		Int3 int2 = dimension;
		Int3 int3 = -Int3.one;
		bool flag = true;
		for (int i = 0; i < 3; i++)
		{
			int num = @int[i];
			int num2 = int2[i];
			int num3 = ray.origin[i];
			int num4 = ray.direction[i];
			if (num3 < num)
			{
				hitInfo.point[i] = num;
				flag = false;
				if (num4 != 0)
				{
					int3[i] = IntMath.Divide((num - num3) * 1000, num4);
				}
			}
			else if (num3 > num2)
			{
				hitInfo.point[i] = num2;
				flag = false;
				if (ray.direction[i] != 0)
				{
					int3[i] = IntMath.Divide((num2 - num3) * 1000, num4);
				}
			}
		}
		if (flag)
		{
			hitInfo.point = ray.origin;
			hitInfo.distance = 0;
			hitInfo.normal = -ray.direction;
			return true;
		}
		int num5 = 0;
		if (int3[1] > int3[num5])
		{
			num5 = 1;
		}
		if (int3[2] > int3[num5])
		{
			num5 = 2;
		}
		if (int3[num5] < 0)
		{
			return false;
		}
		for (int j = 0; j < 3; j++)
		{
			if (j != num5)
			{
				hitInfo.point[j] = ray.origin[j] + IntMath.Divide(int3[num5] * ray.direction[j], 1000);
				if (hitInfo.point[j] < @int[j] || hitInfo.point[j] > int2[j])
				{
					return false;
				}
			}
		}
		hitInfo.distance = int3[num5];
		Int3 zero = Int3.zero;
		zero[num5] = ((hitInfo.point[num5] > 0) ? 1000 : (-1000));
		hitInfo.normal = zero;
		return true;
	}

	public static bool IntersectRayAABB(SimRay ray, Int3 dimension, out SimRaycastHitInfo hitInfoI, out SimRaycastHitInfo hitInfoO)
	{
		hitInfoI = default(SimRaycastHitInfo);
		hitInfoO = default(SimRaycastHitInfo);
		Int3 @int = -dimension;
		Int3 int2 = dimension;
		Int3 int3 = new Int3(int.MinValue, int.MinValue, int.MinValue);
		Int3 int4 = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
		for (int i = 0; i < 3; i++)
		{
			int num = @int[i];
			int num2 = int2[i];
			int num3 = ray.origin[i];
			int num4 = ray.direction[i];
			if (num4 != 0)
			{
				if (num3 < num)
				{
					int3[i] = IntMath.Divide((num - num3) * 1000, num4);
					int4[i] = IntMath.Divide((num2 - num3) * 1000, num4);
					continue;
				}
				if (num3 > num2)
				{
					int3[i] = IntMath.Divide((num2 - num3) * 1000, num4);
					int4[i] = IntMath.Divide((num - num3) * 1000, num4);
					continue;
				}
				int3[i] = 0;
				int a = IntMath.Divide((num2 - num3) * 1000, num4);
				int b = IntMath.Divide((num - num3) * 1000, num4);
				int4[i] = IntMath.Max(a, b);
			}
			else if (num3 > num2 || num3 < num)
			{
				return false;
			}
		}
		int i2 = 0;
		if (int3[1] > int3[i2])
		{
			i2 = 1;
		}
		if (int3[2] > int3[i2])
		{
			i2 = 2;
		}
		if (int3[i2] < 0)
		{
			return false;
		}
		int i3 = 0;
		if (int4[1] < int4[i3])
		{
			i3 = 1;
		}
		if (int4[2] < int4[i3])
		{
			i3 = 2;
		}
		if (int4[i3] < int3[i2])
		{
			return false;
		}
		hitInfoI.point = ray.origin + IntMath.Divide(ray.direction, int3[i2], 1000L);
		hitInfoO.point = ray.origin + IntMath.Divide(ray.direction, int4[i3], 1000L);
		hitInfoI.distance = int3[i2];
		Int3 zero = Int3.zero;
		zero[i2] = ((hitInfoI.point[i2] > 0) ? 1000 : (-1000));
		hitInfoI.normal = zero;
		hitInfoO.distance = int4[i3];
		zero = Int3.zero;
		zero[i3] = ((hitInfoO.point[i3] > 0) ? 1000 : (-1000));
		hitInfoO.normal = zero;
		return true;
	}

	public ABOX GetABBB()
	{
		return mABox;
	}

	public void OnEnterPool()
	{
		mIsDirty = false;
		mCenter = Int3.zero;
		mSize = Int3.one;
		mWorldPos = Int3.zero;
		mWorldExtends = Int3.half;
		mWorldRadius = 0;
	}
}
