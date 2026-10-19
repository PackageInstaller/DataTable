using ACT.Config;

namespace ACT.Model;

public readonly struct ChallengeTargetDefinition(int targetId, Rules rule)
{
	public readonly int TargetId = targetId;

	public readonly Rules Rule = rule;
}
