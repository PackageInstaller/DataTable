namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断动作名称按事件动作", "Predicate", new string[] { "check", "motion", "name", "by", "listen", "evt", "change", "predicate", "condition", "skill" })]
public class CheckMotionNameByListenEvtMotionChange : ConfigPredicate
{
	public enum CheckType
	{
		checkFromName,
		checkToName,
		checkFromMotionType,
		checkToMotionType
	}

	public CheckType type;

	public string name;

	public MotionState stateType;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		if (memory.evt is EvtMotionChange evtMotionChange)
		{
			switch (type)
			{
			case CheckType.checkFromName:
				result = evtMotionChange.from == name;
				break;
			case CheckType.checkToName:
				result = evtMotionChange.to == name;
				break;
			case CheckType.checkFromMotionType:
				result = evtMotionChange.fromState.stateType == stateType;
				break;
			case CheckType.checkToMotionType:
				result = evtMotionChange.toState.stateType == stateType;
				break;
			}
		}
		return result;
	}
}
