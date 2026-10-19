using System;
using System.Collections.Generic;
using ACT.Event;

namespace ACT.World.Asset;

[Serializable]
public class SwapStateData : InteractRuleActionData
{
	public List<StateWorldUid> targets = new List<StateWorldUid>();

	public List<StateSwapGroup> stateSwapGroups = new List<StateSwapGroup>();

	public override IEnumerable<StateWorldUid> checkedSwid => targets;

	public override void Do(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		_ = eventContent.sourceSwid;
		for (int i = 0; i < targets.Count; i++)
		{
			int num = ruleManager.SharedGetState(targets[i]);
			int num2 = num;
			for (int j = 0; j < stateSwapGroups.Count; j++)
			{
				if (stateSwapGroups[j].SwapState(num, out var otherState))
				{
					num2 = otherState;
					break;
				}
			}
			if (num != num2)
			{
				ruleManager.SharedChangeState(targets[i], num2);
			}
		}
	}

	public override void Bake(InteractRuleActionComp interactRuleActionComp)
	{
		targets.Bake(interactRuleActionComp);
	}
}
