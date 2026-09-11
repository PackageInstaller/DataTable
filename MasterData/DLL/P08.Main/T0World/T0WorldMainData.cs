using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
[CreateAssetMenu(fileName = "T0WorldMainData", menuName = "T0小场景/T0主数据")]
public class T0WorldMainData : ScriptableObject
{
	public int characterID = 108502;

	public List<T0WorldMapData> mapDataList;

	public int defaultSceneID;
}
