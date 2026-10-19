using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class SharedVector3List : SharedVariable<List<Vector3>>
{
	public static implicit operator SharedVector3List(List<Vector3> value)
	{
		return new SharedVector3List
		{
			mValue = value
		};
	}
}
