using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class Mapdata : ScriptableObject
{
	public string mapdataName;

	[SerializeField]
	public List<EntityData> entityDatas = new List<EntityData>();
}
