using UnityEngine;

namespace Pathfinding;

public class RecastBBTreeBox
{
	public Rect rect;

	public RecastMeshObj mesh;

	public RecastBBTreeBox c1;

	public RecastBBTreeBox c2;

	public RecastBBTreeBox(RecastMeshObj mesh)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		base._002Ector();
		this.mesh = mesh;
		Vector3 min = ((Bounds)(ref mesh.bounds)).min;
		Vector3 max = ((Bounds)(ref mesh.bounds)).max;
		rect = Rect.MinMaxRect(min.x, min.z, max.x, max.z);
	}

	public bool Contains(Vector3 p)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return ((Rect)(ref rect)).Contains(p);
	}
}
