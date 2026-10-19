using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedFloatList : SharedVariable<List<float>>
{
	public static implicit operator SharedFloatList(List<float> value)
	{
		return new SharedFloatList
		{
			mValue = value
		};
	}
}
