namespace ACT.World.StateObject;

public interface IShowInteractTip
{
	bool ShowInteractTip { get; }

	int InteractTipId { get; }

	bool TipConditionPassed { get; }

	void EvaluateTipConditions();
}
