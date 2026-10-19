using System;
using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

[Serializable]
public class SetWorldState : InteractRuleActionData
{
	public List<InteractWorldRuleState> targets = new List<InteractWorldRuleState>();

	public override IEnumerable<StateWorldUid> checkedSwid
	{
		get
		{
			yield break;
		}
	}

	public override void Do(IRuleManager systemWorld, LocalStateWorldEvent eventContent)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			InteractWorldRuleState interactWorldRuleState = targets[i];
			systemWorld.SharedChangeState(interactWorldRuleState.stateWorldUid, interactWorldRuleState.stateId);
		}
	}

	public override void Bake(InteractRuleActionComp interactRuleActionComp)
	{
		targets.Bake(interactRuleActionComp);
	}
}
