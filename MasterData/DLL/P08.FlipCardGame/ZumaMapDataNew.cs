using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class ZumaMapDataNew : ScriptableObject
{
	public List<ZumaTrackData> trackList = new List<ZumaTrackData>();

	public string mapName = "";

	public float moveSpeed;

	public float shootSpeed;

	public int createColorNums;

	public List<bool> useColorList = new List<bool> { true, true, true, false, false, false, false, false };

	public Vector3 shootPos;

	public List<BallGroup> groupList = new List<BallGroup>();
}
