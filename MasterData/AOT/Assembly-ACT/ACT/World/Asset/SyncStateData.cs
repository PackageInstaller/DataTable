using System;
using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

[Serializable]
public class SyncStateData : InteractRuleActionData
{
	public List<StateWorldUid> targets = new List<StateWorldUid>();

	public override IEnumerable<StateWorldUid> checkedSwid => targets;

	public override void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		int sourceSwid = eventContent.sourceSwid;
		int stateId = ruleManager.SharedGetState(sourceSwid);
		for (int i = 0; i < targets.Count; i++)
		{
			ruleManager.SharedChangeState(targets[i], stateId);
		}
	}

	public override void Bake(InteractRuleActionComp interactRuleActionComp)
	{
		targets.Bake(interactRuleActionComp);
	}
}
