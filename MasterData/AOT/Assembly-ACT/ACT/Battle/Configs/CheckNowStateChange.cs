using ACT.Utility;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Now状态", "Predicate", new string[] { "check", "now", "state", "change", "status", "tag", "predicate", "condition" })]
public class CheckNowStateChange : ConfigPredicate
{
	public bool pre;

	public bool now = true;

	public PlayState playState;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtStateChange evtStateChange)
		{
			if (pre && playState == evtStateChange.pre)
			{
				return true;
			}
			if (now && playState == evtStateChange.now)
			{
				return true;
			}
		}
		return false;
	}
}
