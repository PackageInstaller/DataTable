using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class ActivityMapDataStage
{
	public int sceneID;

	public float stageTime;

	public List<Vector3> bornPos;

	public List<Vector3> bornAngle;

	public List<int> roomID = new List<int> { 0, 0, 0 };

	public List<ActivityMapDataGroup> allGroupData;
}
