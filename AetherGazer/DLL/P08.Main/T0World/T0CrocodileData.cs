using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
[CreateAssetMenu(fileName = "T0CrocodileData", menuName = "T0小场景/交互小游戏/鳄鱼小游戏数据")]
public class T0CrocodileData : ScriptableObject
{
	public string furnitureBindName;

	public List<T0CrocodilePressTimelineData> pressTimelineDataList;

	public List<int> loseChanceList = new List<int>();
}
