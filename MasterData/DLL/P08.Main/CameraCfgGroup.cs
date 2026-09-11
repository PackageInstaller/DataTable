using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class CameraCfgGroup
{
	public List<CameraCfg> cameraCfgS;

	public bool overrideMoveSpeed;

	public Vector2 overrideMoveSpeedValue;
}
