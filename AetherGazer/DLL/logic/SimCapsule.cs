using System;
using Config;

public class SimCapsule : ISimShape
{
	private Int3 mForward;

	public Int3 p0;

	public Int3 p1;

	public int radius;

	public int ID { get; set; }

	public int OwnerID { get; set; }

	public RoleType Layer { get; set; }

	public int AvgCollisionRadius
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public Int3 Forward => mForward;

	public Int3 WorldPos
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public bool IsEnable { get; set; }

	public bool IgnoreHit { get; set; }

	public bool IgnoreCollision { get; set; }

	public Int3 ComputeDirection()
	{
		return p1 - p0;
	}

	public bool EdgeIntersects(SimSphere s)
	{
		throw new NotImplementedException();
	}

	public bool EdgeIntersects(SimBox obb)
	{
		throw new NotImplementedException();
	}

	public bool EdgeIntersects(SimCylinderSector cs)
	{
		throw new NotImplementedException();
	}

	public bool EdgeIntersects(ISimShape shape)
	{
		throw new NotImplementedException();
	}

	public void GetAABB2D(out Int2 lt, out Int2 size)
	{
		throw new NotImplementedException();
	}

	public SimShapeType GetShapeType()
	{
		throw new NotImplementedException();
	}

	public bool Intersects(SimCylinderSector cs)
	{
		throw new NotImplementedException();
	}

	public bool Intersects(SimSphere s)
	{
		throw new NotImplementedException();
	}

	public bool Intersects(SimBox obb)
	{
		throw new NotImplementedException();
	}

	public bool Intersects(ISimShape shape)
	{
		throw new NotImplementedException();
	}

	public void UpdateWorldShape(Int3 location, Int3 forward)
	{
		throw new NotImplementedException();
	}

	public void UpdateShape(Int3 location, Int3 forward, int moveDelta)
	{
		throw new NotImplementedException();
	}

	public static bool Raycast(SimRay ray, Int distance, SimCapsule capsule, out SimRaycastHitInfo hitInfo)
	{
		hitInfo = default(SimRaycastHitInfo);
		return false;
	}

	public ABOX GetABBB()
	{
		throw new NotImplementedException();
	}

	public bool RayCast(SimRay ray, out SimRaycastHitInfo hitInfo)
	{
		throw new NotImplementedException();
	}
}
