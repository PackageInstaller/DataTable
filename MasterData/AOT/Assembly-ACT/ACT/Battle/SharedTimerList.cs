using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class SharedTimerList : SharedVariable<List<Timer>>
{
	public static implicit operator SharedTimerList(List<Timer> value)
	{
		return new SharedTimerList
		{
			mValue = value
		};
	}
}
