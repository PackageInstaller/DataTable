using ACT.Core;
using ACT.RichText;

namespace ACT.UI;

public static class ChallengeTargetTextUtility
{
	public static string GetText(int ruleId)
	{
		if (ruleId <= 0 || RuntimeConfigs.data?.ruless == null || !RuntimeConfigs.data.ruless.TryGetValue(ruleId, out var value) || value == null)
		{
			return string.Empty;
		}
		return CustomTagParser.ReplaceBattleRuleDataText(value, value.number, value.param);
	}
}
