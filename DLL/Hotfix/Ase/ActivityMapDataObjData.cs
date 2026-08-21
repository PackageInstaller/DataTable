using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class ActivityMapDataObjData
{
	public ActivityMapDataObjType objType;

	public int id;

	public Vector3 pos;

	public Vector3 angles;

	public string name;

	public int groupHelp;

	[HideInInspector]
	public int groupID;
}
