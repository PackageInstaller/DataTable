using Config;

public interface ISimShape
{
	int ID { get; set; }

	int OwnerID { get; set; }

	bool IsEnable { get; set; }

	RoleType Layer { get; set; }

	Int3 WorldPos { get; }

	Int3 Forward { get; }

	int AvgCollisionRadius { get; }

	bool IgnoreHit { get; set; }

	bool IgnoreCollision { get; set; }

	bool Intersects(ISimShape shape);

	bool Intersects(SimBox obb);

	bool Intersects(SimSphere s);

	bool Intersects(SimCylinderSector cs);

	bool EdgeIntersects(ISimShape shape);

	bool EdgeIntersects(SimBox obb);

	bool EdgeIntersects(SimSphere s);

	bool EdgeIntersects(SimCylinderSector cs);

	void UpdateWorldShape(Int3 location, Int3 forward);

	void UpdateShape(Int3 location, Int3 forward, int moveDelta);

	bool RayCast(SimRay ray, out SimRaycastHitInfo hitInfo);

	SimShapeType GetShapeType();

	void GetAABB2D(out Int2 lt, out Int2 size);

	ABOX GetABBB();
}
