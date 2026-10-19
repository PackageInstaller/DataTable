using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class TransformsPattern
{
	public abstract void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms);
}
