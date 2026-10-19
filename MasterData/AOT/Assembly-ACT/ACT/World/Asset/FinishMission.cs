using System;
using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

[Serializable]
[Obsolete]
public class FinishMission : InteractRuleActionData
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
	}
}
