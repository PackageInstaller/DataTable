using System;
using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

[Serializable]
public class SetStateData : InteractRuleActionData
{
	public List<InteractRuleState> targets = new List<InteractRuleState>();

	public override IEnumerable<StateWorldUid> checkedSwid
	{
		get
		{
			for (int i = 0; i < targets.Count; i++)
			{
				yield return targets[i].stateWorldUid;
			}
		}
	}

	public override void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		_ = eventContent.sourceSwid;
		for (int i = 0; i < targets.Count; i++)
		{
			ruleManager.SharedChangeState(targets[i].stateWorldUid, targets[i].stateId);
		}
	}

	public override void Bake(InteractRuleActionComp interactRuleActionComp)
	{
		targets.Bake(interactRuleActionComp);
	}
}
