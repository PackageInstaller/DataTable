using System.Collections.Generic;
using ACT.Battle;
using ACT.World.Asset;

namespace ACT.Drama;

public class InteractStateCondition : BaseCondition
{
	public List<InteractState> interactStates = new List<InteractState>();

	public override bool Check()
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		foreach (InteractState interactState in interactStates)
		{
			int interactAssetState = ruleManager.GetInteractAssetState(interactState.uid);
			switch (interactState.operate)
			{
			case Operate.Equal:
				if (interactAssetState != interactState.stateId)
				{
					return false;
				}
				break;
			case Operate.NotEqual:
				if (interactAssetState == interactState.stateId)
				{
					return false;
				}
				break;
			case Operate.Low:
				if (interactAssetState >= interactState.stateId)
				{
					return false;
				}
				break;
			case Operate.High:
				if (interactAssetState <= interactState.stateId)
				{
					return false;
				}
				break;
			}
		}
		return true;
	}
}
