using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

[Serializable]
public class KCMissionsConditionParam : IMissionDependencies
{
	public List<int> missions = new List<int>();

	IEnumerable<int> IMissionDependencies.MissionDependencies
	{
		get
		{
			foreach (int mission in missions)
			{
				yield return mission;
			}
		}
	}
}
