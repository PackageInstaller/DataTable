using ACT.Utility;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Curr状态", "Predicate", new string[] { "check", "curr", "state", "change", "status", "tag", "predicate", "condition" })]
public class CheckCurrStateChange : ConfigPredicate
{
	public PlayState playState;

	public override bool Check(ActionMemory memory)
	{
		return MonoECS.instance.playState == playState;
	}
}
