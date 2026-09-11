using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding;

public class RecastBBTree
{
	private RecastBBTreeBox root;

	public void QueryInBounds(Rect bounds, List<RecastMeshObj> buffer)
	{
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		if (root != null)
		{
			QueryBoxInBounds(root, bounds, buffer);
		}
	}

	private void QueryBoxInBounds(RecastBBTreeBox box, Rect bounds, List<RecastMeshObj> boxes)
	{
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)box.mesh != (Object)null)
		{
			if (RectIntersectsRect(box.rect, bounds))
			{
				boxes.Add(box.mesh);
			}
			return;
		}
		if (RectIntersectsRect(box.c1.rect, bounds))
		{
			QueryBoxInBounds(box.c1, bounds, boxes);
		}
		if (RectIntersectsRect(box.c2.rect, bounds))
		{
			QueryBoxInBounds(box.c2, bounds, boxes);
		}
	}

	public bool Remove(RecastMeshObj mesh)
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)mesh == (Object)null)
		{
			throw new ArgumentNullException("mesh");
		}
		if (root == null)
		{
			return false;
		}
		bool found = false;
		Bounds bounds = mesh.GetBounds();
		Rect bounds2 = Rect.MinMaxRect(((Bounds)(ref bounds)).min.x, ((Bounds)(ref bounds)).min.z, ((Bounds)(ref bounds)).max.x, ((Bounds)(ref bounds)).max.z);
		root = RemoveBox(root, mesh, bounds2, ref found);
		return found;
	}

	private RecastBBTreeBox RemoveBox(RecastBBTreeBox c, RecastMeshObj mesh, Rect bounds, ref bool found)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		if (!RectIntersectsRect(c.rect, bounds))
		{
			return c;
		}
		if ((Object)(object)c.mesh == (Object)(object)mesh)
		{
			found = true;
			return null;
		}
		if ((Object)(object)c.mesh == (Object)null && !found)
		{
			c.c1 = RemoveBox(c.c1, mesh, bounds, ref found);
			if (c.c1 == null)
			{
				return c.c2;
			}
			if (!found)
			{
				c.c2 = RemoveBox(c.c2, mesh, bounds, ref found);
				if (c.c2 == null)
				{
					return c.c1;
				}
			}
			if (found)
			{
				c.rect = ExpandToContain(c.c1.rect, c.c2.rect);
			}
		}
		return c;
	}

	public void Insert(RecastMeshObj mesh)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		RecastBBTreeBox recastBBTreeBox = new RecastBBTreeBox(mesh);
		if (root == null)
		{
			root = recastBBTreeBox;
			return;
		}
		RecastBBTreeBox recastBBTreeBox2 = root;
		while (true)
		{
			recastBBTreeBox2.rect = ExpandToContain(recastBBTreeBox2.rect, recastBBTreeBox.rect);
			if ((Object)(object)recastBBTreeBox2.mesh != (Object)null)
			{
				break;
			}
			float num = ExpansionRequired(recastBBTreeBox2.c1.rect, recastBBTreeBox.rect);
			float num2 = ExpansionRequired(recastBBTreeBox2.c2.rect, recastBBTreeBox.rect);
			recastBBTreeBox2 = ((!(num < num2)) ? ((!(num2 < num)) ? ((RectArea(recastBBTreeBox2.c1.rect) < RectArea(recastBBTreeBox2.c2.rect)) ? recastBBTreeBox2.c1 : recastBBTreeBox2.c2) : recastBBTreeBox2.c2) : recastBBTreeBox2.c1);
		}
		recastBBTreeBox2.c1 = recastBBTreeBox;
		RecastBBTreeBox c = new RecastBBTreeBox(recastBBTreeBox2.mesh);
		recastBBTreeBox2.c2 = c;
		recastBBTreeBox2.mesh = null;
	}

	private static bool RectIntersectsRect(Rect r, Rect r2)
	{
		if (((Rect)(ref r)).xMax > ((Rect)(ref r2)).xMin && ((Rect)(ref r)).yMax > ((Rect)(ref r2)).yMin && ((Rect)(ref r2)).xMax > ((Rect)(ref r)).xMin)
		{
			return ((Rect)(ref r2)).yMax > ((Rect)(ref r)).yMin;
		}
		return false;
	}

	private static float ExpansionRequired(Rect r, Rect r2)
	{
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		float num = Mathf.Min(((Rect)(ref r)).xMin, ((Rect)(ref r2)).xMin);
		float num2 = Mathf.Max(((Rect)(ref r)).xMax, ((Rect)(ref r2)).xMax);
		float num3 = Mathf.Min(((Rect)(ref r)).yMin, ((Rect)(ref r2)).yMin);
		float num4 = Mathf.Max(((Rect)(ref r)).yMax, ((Rect)(ref r2)).yMax);
		return (num2 - num) * (num4 - num3) - RectArea(r);
	}

	private static Rect ExpandToContain(Rect r, Rect r2)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		float num = Mathf.Min(((Rect)(ref r)).xMin, ((Rect)(ref r2)).xMin);
		float num2 = Mathf.Max(((Rect)(ref r)).xMax, ((Rect)(ref r2)).xMax);
		float num3 = Mathf.Min(((Rect)(ref r)).yMin, ((Rect)(ref r2)).yMin);
		float num4 = Mathf.Max(((Rect)(ref r)).yMax, ((Rect)(ref r2)).yMax);
		return Rect.MinMaxRect(num, num3, num2, num4);
	}

	private static float RectArea(Rect r)
	{
		return ((Rect)(ref r)).width * ((Rect)(ref r)).height;
	}
}
