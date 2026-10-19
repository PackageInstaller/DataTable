using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class RandomSequenceDistributionPattern : TransformsPattern
{
	[SerializeReference]
	public TransformsPattern transformsPattern;

	public override void GetPositionsAndRotation(ActionMemory memory, List<(Vector3, Vector3)> transforms)
	{
		transformsPattern.GetPositionsAndRotation(memory, transforms);
		System.Random random = new System.Random();
		int num = transforms.Count;
		while (num > 1)
		{
			num--;
			int num2 = random.Next(num + 1);
			int index = num2;
			int index2 = num;
			(Vector3, Vector3) tuple = transforms[num];
			(Vector3, Vector3) tuple2 = transforms[num2];
			(Vector3, Vector3) tuple3 = (transforms[index] = tuple);
			tuple3 = (transforms[index2] = tuple2);
		}
	}
}
