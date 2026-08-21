using System;
using System.Collections.Generic;
using UnityEngine;

public class QWorldEntityData<T> : QWorldEntityData where T : QWorldEntityMono
{
}
[Serializable]
public abstract class QWorldEntityData
{
	public int group_index;

	public int id;

	public string editor_prefab_name;

	public string editor_prefab;

	public Vector3 position;

	public Quaternion rotation;

	public Vector3 localScale;

	public List<int> entity_child_list;

	public Vector3 size;
}
