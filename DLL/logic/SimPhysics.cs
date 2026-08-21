using System.Collections.Generic;
using Config;
using Pathfinding.Util;

public class SimPhysics
{
	public static DynamicTree<ISimShape> sAABBTree;

	public static SimSphere temp = new SimSphere();

	public static bool Raycast(Int3 origin, Int3 direction, List<int> collisions, uint layer)
	{
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(origin, direction, list);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (userData != null && RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.RayCast(new SimRay(origin, direction), out var _))
			{
				collisions.Add(userData.OwnerID);
			}
		}
		if (collisions != null)
		{
			return collisions.Count > 0;
		}
		return false;
	}

	public static bool Raycast(Int3 origin, Int3 direction, uint layer, out int hitEntityID, out SimRaycastHitInfo hitInfo)
	{
		long num = long.MaxValue;
		hitInfo = default(SimRaycastHitInfo);
		hitEntityID = -1;
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(origin, direction, list);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (userData != null && RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.RayCast(new SimRay(origin, direction), out var hitInfo2))
			{
				long sqrMagnitudeLong = (hitInfo2.point - origin).sqrMagnitudeLong;
				if (sqrMagnitudeLong < num)
				{
					num = sqrMagnitudeLong;
					hitEntityID = userData.OwnerID;
					hitInfo = hitInfo2;
				}
			}
		}
		return hitEntityID > 0;
	}

	public static bool Raycast(Int3 origin, Int3 direction, Int3 originOffset, uint layer, List<ISimShape> shapeList, List<SimRaycastHitInfo> hitInfoList)
	{
		Int3 @int = direction;
		origin = IntMath.Transform(originOffset, @int.NormalizeTo(1000), origin);
		shapeList.Clear();
		hitInfoList.Clear();
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(origin, direction, list);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (userData != null && RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.RayCast(new SimRay(origin, direction), out var hitInfo))
			{
				shapeList.Add(userData);
				hitInfoList.Add(hitInfo);
			}
		}
		ListPool<int>.Release(list);
		return shapeList.Count > 0;
	}

	public static bool Raycast(Int3 origin, Int3 direction, Int3 originOffset, uint layer, out ISimShape hitEntityID, out SimRaycastHitInfo hitInfo, long minDistance = long.MaxValue, bool ignoreZeroBunker = true)
	{
		Int3 @int = direction;
		origin = IntMath.Transform(originOffset, @int.NormalizeTo(1000), origin);
		hitInfo = default(SimRaycastHitInfo);
		hitEntityID = null;
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(origin, direction, list);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (userData != null && RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.RayCast(new SimRay(origin, direction), out var hitInfo2))
			{
				long sqrMagnitudeLong = (hitInfo2.point - origin).sqrMagnitudeLong;
				if ((!ignoreZeroBunker || sqrMagnitudeLong != 0L || userData.Layer != RoleType.Bunker) && userData.IsEnable && sqrMagnitudeLong < minDistance)
				{
					minDistance = sqrMagnitudeLong;
					hitEntityID = userData;
					hitInfo = hitInfo2;
				}
			}
		}
		ListPool<int>.Release(list);
		return hitEntityID != null;
	}

	public static void Overlap(Int3 origin, int radius, List<int> collisions, uint layer)
	{
		SimSphere simSphere = FrameObjectPool<SimSphere>.Claim();
		simSphere.Radius = radius;
		simSphere.UpdateWorldShape(origin, Int3.forward);
		Overlap(simSphere, collisions, layer);
		FrameObjectPool<SimSphere>.Release(simSphere);
	}

	public static void Overlap(Int3 origin, Int3 forward, Int3 offset, int radius, List<ISimShape> collisions, uint layer)
	{
		SimSphere simSphere = FrameObjectPool<SimSphere>.Claim();
		simSphere.Radius = radius;
		origin = IntMath.Transform(offset, forward, origin);
		simSphere.UpdateWorldShape(origin, forward);
		Overlap(simSphere, collisions, layer);
		FrameObjectPool<SimSphere>.Release(simSphere);
	}

	public static void Overlap(Int3 origin, int radius, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(origin.x + radius, origin.y + radius, origin.z + radius);
		Int3 min = new Int3(origin.x - radius, origin.y - radius, origin.z - radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer))
			{
				temp.Pos = origin;
				temp.Radius = radius;
				temp.UpdateWorldShape(origin, Int3.forward);
				if (userData.Intersects(temp))
				{
					collisions.Add(userData);
				}
			}
		}
		ListPool<int>.Release(list);
	}

	public static void Overlap(SimSphere sphere, List<int> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(sphere.WorldPos.x + sphere.Radius, sphere.WorldPos.y + sphere.Radius, sphere.WorldPos.z + sphere.Radius);
		Int3 min = new Int3(sphere.WorldPos.x - sphere.Radius, sphere.WorldPos.y - sphere.Radius, sphere.WorldPos.z - sphere.Radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(sphere))
			{
				collisions.Add(userData.OwnerID);
			}
		}
		ListPool<int>.Release(list);
	}

	public static void Overlap(SimSphere sphere, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(sphere.WorldPos.x + sphere.Radius, sphere.WorldPos.y + sphere.Radius, sphere.WorldPos.z + sphere.Radius);
		Int3 min = new Int3(sphere.WorldPos.x - sphere.Radius, sphere.WorldPos.y - sphere.Radius, sphere.WorldPos.z - sphere.Radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(sphere))
			{
				collisions.Add(userData);
			}
		}
		ListPool<int>.Release(list);
	}

	public static void OverlapAnnulus(Int3 origin, int radius, int innerRadius, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(origin.x + radius, origin.y + radius, origin.z + radius);
		Int3 min = new Int3(origin.x - radius, origin.y - radius, origin.z - radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimAnnulusSphere simAnnulusSphere = FrameObjectPool<SimAnnulusSphere>.Claim();
		simAnnulusSphere.SetNesscessaryProperty(innerRadius, radius, origin);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && simAnnulusSphere.Intersects(userData))
			{
				collisions.Add(userData);
			}
		}
		ListPool<int>.Release(list);
		FrameObjectPool<SimAnnulusSphere>.Release(simAnnulusSphere);
	}

	public static void OverlapAnnulus(Int3 origin, int radius, int innerRadius, List<int> collisions, uint layer)
	{
		List<ISimShape> list = ListPool<ISimShape>.Claim();
		OverlapAnnulus(origin, radius, innerRadius, list, layer);
		for (int i = 0; i < list.Count; i++)
		{
			collisions.Add(list[i].OwnerID);
		}
		ListPool<ISimShape>.Release(list);
	}

	public static void OverlapAnnularSector(Int3 origin, int radius, int innerRadius, int degree, Int3 castDirection, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(origin.x + radius, origin.y + radius, origin.z + radius);
		Int3 min = new Int3(origin.x - radius, origin.y - radius, origin.z - radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimCylinderAnnularSector simCylinderAnnularSector = FrameObjectPool<SimCylinderAnnularSector>.Claim();
		simCylinderAnnularSector.SetNesscessaryProperty(innerRadius, radius, origin, castDirection, 500, degree);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && simCylinderAnnularSector.Intersects(userData))
			{
				collisions.Add(userData);
			}
		}
		ListPool<int>.Release(list);
		FrameObjectPool<SimCylinderAnnularSector>.Release(simCylinderAnnularSector);
	}

	public static void OverlapAnnularSector(Int3 origin, int radius, int innerRadius, int degree, Int3 castDirection, List<int> collisions, uint layer)
	{
		List<ISimShape> list = ListPool<ISimShape>.Claim();
		OverlapAnnularSector(origin, radius, innerRadius, degree, castDirection, list, layer);
		for (int i = 0; i < list.Count; i++)
		{
			collisions.Add(list[i].OwnerID);
		}
		ListPool<ISimShape>.Release(list);
	}

	public static void OverlapSector(Int3 origin, int radius, int degree, Int3 castDirection, List<int> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(origin.x + radius, origin.y + radius, origin.z + radius);
		Int3 min = new Int3(origin.x - radius, origin.y - radius, origin.z - radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimCylinderSector simCylinderSector = FrameObjectPool<SimCylinderSector>.Claim();
		simCylinderSector.WorldPos = origin;
		simCylinderSector.Radius = radius;
		simCylinderSector.Degree = degree;
		simCylinderSector.Rotation = IntMath.AngleOfVector(castDirection).i;
		simCylinderSector.UpdateWorldShape(origin, castDirection);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(simCylinderSector))
			{
				collisions.Add(userData.OwnerID);
			}
		}
		FrameObjectPool<SimCylinderSector>.Release(simCylinderSector);
		ListPool<int>.Release(list);
	}

	public static void OverlapSector(Int3 origin, Int3 foward, Int3 offset, int radius, int degree, Int3 castDirection, List<ISimShape> collisions, uint layer)
	{
		origin = IntMath.Transform(offset, foward, origin);
		OverlapSector(origin, radius, degree, castDirection, collisions, layer);
	}

	public static void OverlapSector(Int3 origin, int radius, int degree, Int3 castDirection, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		Int3 max = new Int3(origin.x + radius, origin.y + radius, origin.z + radius);
		Int3 min = new Int3(origin.x - radius, origin.y - radius, origin.z - radius);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimCylinderSector simCylinderSector = FrameObjectPool<SimCylinderSector>.Claim();
		simCylinderSector.WorldPos = origin;
		simCylinderSector.Radius = radius;
		simCylinderSector.Degree = degree;
		simCylinderSector.Rotation = IntMath.AngleOfVector(castDirection).i;
		simCylinderSector.UpdateWorldShape(origin, castDirection);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(simCylinderSector))
			{
				collisions.Add(userData);
			}
		}
		FrameObjectPool<SimCylinderSector>.Release(simCylinderSector);
		ListPool<int>.Release(list);
	}

	public static void OverlapBox(Int3 origin, Int3 forward, Int3 centerOffset, Int3 size, List<int> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		int num = IntMath.Max(size.x, size.y, size.z);
		Int3 worldPosition = IntMath.Transform(centerOffset, forward.NormalizeTo(1000), origin);
		Int3 max = new Int3(worldPosition.x + num, worldPosition.y + num, worldPosition.z + num);
		Int3 min = new Int3(worldPosition.x - num, worldPosition.y - num, worldPosition.z - num);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimBox simBox = FrameObjectPool<SimBox>.Claim();
		simBox.Center = centerOffset;
		simBox.Size = size;
		simBox.UpdateWorldShape(worldPosition, forward);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(simBox))
			{
				collisions.Add(userData.OwnerID);
			}
		}
		FrameObjectPool<SimBox>.Release(simBox);
		ListPool<int>.Release(list);
	}

	public static void OverlapBox(Int3 origin, Int3 forward, Int3 centerOffset, Int3 size, List<ISimShape> collisions, uint layer)
	{
		if (sAABBTree == null)
		{
			return;
		}
		int num = IntMath.Max(size.x, size.y, size.z);
		Int3 worldPosition = IntMath.Transform(centerOffset, forward.NormalizeTo(1000), origin);
		Int3 max = new Int3(worldPosition.x + num, worldPosition.y + num, worldPosition.z + num);
		Int3 min = new Int3(worldPosition.x - num, worldPosition.y - num, worldPosition.z - num);
		ABOX aabb = new ABOX(min, max);
		List<int> list = ListPool<int>.Claim();
		sAABBTree.Query(list, ref aabb);
		SimBox simBox = FrameObjectPool<SimBox>.Claim();
		simBox.Center = centerOffset;
		simBox.Size = size;
		simBox.UpdateWorldShape(worldPosition, forward);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape userData = sAABBTree.GetUserData(list[i]);
			if (RoleCampProcessor.Is(layer, (uint)userData.Layer) && userData.Intersects(simBox))
			{
				collisions.Add(userData);
			}
		}
		FrameObjectPool<SimBox>.Release(simBox);
		ListPool<int>.Release(list);
	}
}
