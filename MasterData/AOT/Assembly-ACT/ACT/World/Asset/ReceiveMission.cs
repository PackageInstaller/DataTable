using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Game;

namespace ACT.World.Asset;

[Serializable]
public class ReceiveMission : InteractRuleActionData
{
	public int[] missionIds;

	public override IEnumerable<StateWorldUid> checkedSwid
	{
		get
		{
			yield break;
		}
	}

	public override void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		int[] array = missionIds;
		foreach (int missionId in array)
		{
			G.service.AcceptMission(missionId);
		}
	}
}
