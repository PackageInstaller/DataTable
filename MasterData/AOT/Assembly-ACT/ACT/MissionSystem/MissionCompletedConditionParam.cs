using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class MissionCompletedConditionParam : IMissionDependencies
{
	public int missionId;

	IEnumerable<int> IMissionDependencies.MissionDependencies
	{
		get
		{
			yield return missionId;
		}
	}
}
