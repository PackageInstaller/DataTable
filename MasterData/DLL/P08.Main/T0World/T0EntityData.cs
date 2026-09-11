using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0EntityData
{
	public int entityID;

	public string name;

	public Vector3 pos;

	public Vector3 rot;

	public LoadTypeEnum loadType;

	public string loadResPath;

	public int initTreeID = -1;

	[HideInInspector]
	public List<T0InterationTreeData> interationList;

	public T0EntityData()
	{
		interationList = new List<T0InterationTreeData>();
	}
}
