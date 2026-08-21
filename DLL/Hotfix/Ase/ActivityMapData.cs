using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[CreateAssetMenu(fileName = "ActivityMapData", menuName = "ScriptableObjects/地图编辑")]
public class ActivityMapData : ScriptableObject
{
	public int StartSceneId;

	public List<ActivityMapDataStage> stages;

	public void Clear()
	{
		stages = new List<ActivityMapDataStage>();
	}
}
