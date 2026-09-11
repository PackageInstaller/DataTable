using System;
using System.Collections.Generic;
using UnityEngine;

public class QWorldEntityMono : MonoBehaviour
{
	public int id;

	public int group_index;

	public List<int> entity_child_list;

	[Obsolete]
	[HideInInspector]
	public List<int> disable_child_list;

	[HideInInspector]
	public Vector3 size;

	public virtual Vector3? Size
	{
		get
		{
			return size;
		}
		set
		{
			size = value ?? size;
		}
	}
}
