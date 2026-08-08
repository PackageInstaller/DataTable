using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_recast_mesh_obj.php")]
[AddComponentMenu("Pathfinding/Navmesh/RecastMeshObj")]
public class RecastMeshObj : VersionedMonoBehaviour
{
	protected static RecastBBTree tree = new RecastBBTree();

	protected static List<RecastMeshObj> dynamicMeshObjs = new List<RecastMeshObj>();

	[HideInInspector]
	public Bounds bounds;

	public bool dynamic = true;

	public int area;

	private bool _dynamic;

	private bool registered;

	public static void GetAllInBounds(List<RecastMeshObj> buffer, Bounds bounds)
	{
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0110: Unknown result type (might be due to invalid IL or missing references)
		Bounds val;
		if (!Application.isPlaying)
		{
			RecastMeshObj[] array = Object.FindObjectsOfType(typeof(RecastMeshObj)) as RecastMeshObj[];
			for (int i = 0; i < array.Length; i++)
			{
				array[i].RecalculateBounds();
				val = array[i].GetBounds();
				if (((Bounds)(ref val)).Intersects(bounds))
				{
					buffer.Add(array[i]);
				}
			}
			return;
		}
		if (Time.timeSinceLevelLoad == 0f)
		{
			RecastMeshObj[] array2 = Object.FindObjectsOfType(typeof(RecastMeshObj)) as RecastMeshObj[];
			for (int j = 0; j < array2.Length; j++)
			{
				array2[j].Register();
			}
		}
		for (int k = 0; k < dynamicMeshObjs.Count; k++)
		{
			val = dynamicMeshObjs[k].GetBounds();
			if (((Bounds)(ref val)).Intersects(bounds))
			{
				buffer.Add(dynamicMeshObjs[k]);
			}
		}
		Rect val2 = Rect.MinMaxRect(((Bounds)(ref bounds)).min.x, ((Bounds)(ref bounds)).min.z, ((Bounds)(ref bounds)).max.x, ((Bounds)(ref bounds)).max.z);
		tree.QueryInBounds(val2, buffer);
	}

	private void OnEnable()
	{
		Register();
	}

	private void Register()
	{
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		if (!registered)
		{
			registered = true;
			area = Mathf.Clamp(area, -1, 33554432);
			Renderer component = ((Component)this).GetComponent<Renderer>();
			Collider component2 = ((Component)this).GetComponent<Collider>();
			if ((Object)(object)component == (Object)null && (Object)(object)component2 == (Object)null)
			{
				throw new Exception("A renderer or a collider should be attached to the GameObject");
			}
			MeshFilter component3 = ((Component)this).GetComponent<MeshFilter>();
			if ((Object)(object)component != (Object)null && (Object)(object)component3 == (Object)null)
			{
				throw new Exception("A renderer was attached but no mesh filter");
			}
			bounds = (((Object)(object)component != (Object)null) ? component.bounds : component2.bounds);
			_dynamic = dynamic;
			if (_dynamic)
			{
				dynamicMeshObjs.Add(this);
			}
			else
			{
				tree.Insert(this);
			}
		}
	}

	private void RecalculateBounds()
	{
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		Renderer component = ((Component)this).GetComponent<Renderer>();
		Collider collider = GetCollider();
		if ((Object)(object)component == (Object)null && (Object)(object)collider == (Object)null)
		{
			throw new Exception("A renderer or a collider should be attached to the GameObject");
		}
		MeshFilter component2 = ((Component)this).GetComponent<MeshFilter>();
		if ((Object)(object)component != (Object)null && (Object)(object)component2 == (Object)null)
		{
			throw new Exception("A renderer was attached but no mesh filter");
		}
		bounds = (((Object)(object)component != (Object)null) ? component.bounds : collider.bounds);
	}

	public Bounds GetBounds()
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (_dynamic)
		{
			RecalculateBounds();
		}
		return bounds;
	}

	public MeshFilter GetMeshFilter()
	{
		return ((Component)this).GetComponent<MeshFilter>();
	}

	public Collider GetCollider()
	{
		return ((Component)this).GetComponent<Collider>();
	}

	private void OnDisable()
	{
		registered = false;
		if (_dynamic)
		{
			dynamicMeshObjs.Remove(this);
		}
		else if (!tree.Remove(this))
		{
			throw new Exception("Could not remove RecastMeshObj from tree even though it should exist in it. Has the object moved without being marked as dynamic?");
		}
		_dynamic = dynamic;
	}
}
