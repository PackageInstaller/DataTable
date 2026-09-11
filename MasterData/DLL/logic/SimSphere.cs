using Config;

public class SimSphere : ISimShape, IFramePooledObject
{
	private Int3 mLocalPos = Int3.zero;

	private int mRadius = 500;

	private Int3 mWorldPos = Int3.zero;

	private bool mIsDirty;

	private ABOX mABox;

	private Int3 mFoward;

	public int ID { get; set; }

	public int OwnerID { get; set; }

	public RoleType Layer { get; set; }

	public Int3 Pos
	{
		get
		{
			return mLocalPos;
		}
		set
		{
			mLocalPos = value;
			mIsDirty = false;
		}
	}

	public Int3 WorldPos => mWorldPos;

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

	public int AvgCollisionRadius => Radius;

	public Int3 Forward => mFoward;

	public bool IsEnable { get; set; }

	public bool IgnoreHit { get; set; }

	public bool IgnoreCollision { get; set; }

	public bool EdgeIntersects(SimCylinderSector cs)
	{
		return cs.EdgeIntersects(this);
	}

	public bool EdgeIntersects(SimSphere s)
	{
		long num = Radius + s.Radius;
		long num2 = Radius - s.Radius;
		long sqrMagnitudeLong2D = (mWorldPos - s.mWorldPos).sqrMagnitudeLong2D;
		if (sqrMagnitudeLong2D <= num * num)
		{
			return sqrMagnitudeLong2D >= num2 * num2;
		}
		return false;
	}

	public bool EdgeIntersects(SimBox obb)
	{
		return false;
	}

	public SimShapeType GetShapeType()
	{
		return SimShapeType.Sphere;
	}

	public bool Intersects(SimCylinderSector cs)
	{
		return cs.Intersects(this);
	}

	public bool Intersects(SimSphere s)
	{
		long num = Radius + s.Radius;
		return (mWorldPos - s.mWorldPos).sqrMagnitudeLong <= num * num;
	}

	public bool Intersects(SimBox obb)
	{
		return obb.Intersects(this);
	}

	public void UpdateWorldShape(Int3 location, Int3 forward)
	{
		mFoward = forward;
		mWorldPos = location;
		mIsDirty = false;
		Int3 @int = new Int3(Radius, Radius, Radius);
		mABox = new ABOX(mWorldPos - @int, mWorldPos + @int);
	}

	public void UpdateShape(Int3 location, Int3 forward, int moveDelta)
	{
	}

	public void GetAABB2D(out Int2 lt, out Int2 size)
	{
		lt = WorldPos.xz;
		lt.x -= mRadius;
		lt.y -= mRadius;
		size.x = mRadius + mRadius;
		size.y = size.x;
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
		if (!IntersectRaySphereBasic(ray, int.MaxValue, this, out hitInfo))
		{
			XLogger.Debug("RayCast failed!");
			return false;
		}
		hitInfo.normal = hitInfo.point - WorldPos;
		hitInfo.normal.Normalize();
		return true;
	}

	public static bool Raycast(SimRay ray, Int distance, SimSphere sphere, out SimRaycastHitInfo hitInfo)
	{
		if (!IntersectRaySphereBasic(ray, distance, sphere, out hitInfo))
		{
			return false;
		}
		hitInfo.normal = hitInfo.point - sphere.WorldPos;
		hitInfo.normal.Normalize();
		return true;
	}

	public static bool IntersectRaySphereBasic(SimRay ray, Int distance, SimSphere sphere, out SimRaycastHitInfo hitInfo)
	{
		hitInfo = default(SimRaycastHitInfo);
		Int3 @int = sphere.WorldPos - ray.origin;
		int num = IntMath.Divide(Int3.Dot(ray.direction, @int), 1000);
		int num2 = Int3.Dot(@int, @int);
		long num3 = sphere.AvgCollisionRadius * sphere.AvgCollisionRadius;
		if (num2 <= num3)
		{
			hitInfo.point = ray.origin;
			hitInfo.normal = Int3.zero;
			hitInfo.distance = 0;
			return true;
		}
		if (num <= 0 || num - distance > sphere.AvgCollisionRadius)
		{
			return false;
		}
		long num4 = num3 - (num2 - num * num);
		if (num4 < 0)
		{
			return false;
		}
		hitInfo.distance = num - IntMath.Sqrt(num4);
		if (hitInfo.distance > distance)
		{
			return false;
		}
		hitInfo.point = ray.origin + ray.direction * new VFactor(hitInfo.distance, 1000L);
		return true;
	}

	public ABOX GetABBB()
	{
		return mABox;
	}

	public void OnEnterPool()
	{
		mLocalPos = Int3.zero;
		mRadius = 500;
		mWorldPos = Int3.zero;
		mIsDirty = false;
		mFoward = Int3.forward;
	}
}
