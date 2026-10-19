using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ReversePattern : TransformsPattern
{
	[SerializeReference]
	public TransformsPattern transformsPattern;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		transformsPattern.GetPositionsAndRotation(memory, transforms);
		transforms.Reverse();
	}
}
