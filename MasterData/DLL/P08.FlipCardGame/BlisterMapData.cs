using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "BlisterMapData", menuName = "ScriptableObjects/BlisterMapData")]
public class BlisterMapData : ScriptableObject
{
	public string mapName;

	public int blisterNum;

	public int comboReward;

	public int row;

	public int column;

	public List<BlisterData> mapData = new List<BlisterData>();
}
