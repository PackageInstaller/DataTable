using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
[CreateAssetMenu(fileName = "T0WorldMapData", menuName = "T0小场景/场景数据")]
public class T0WorldMapData : ScriptableObject
{
	public int characterID = 108502;

	public List<T0EntityData> entityList;

	public string sceneName;

	public int sceneID;

	public Vector3 playerStartPos;

	public Vector3 playerStartRot;
}
