using TrueSync;

public class FreesiaSkillDischargeEvent : BaseAdventureEvent
{
	public int lineCount;

	public TSVector2 position;

	public TSVector2 direction;

	public bool inBerserkState;

	public static FreesiaSkillDischargeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<FreesiaSkillDischargeEvent>("FREESIA_SKILL_DISCHARGE");
	}

	public FreesiaSkillDischargeEvent()
		: base("FREESIA_SKILL_DISCHARGE")
	{
	}

	public override void Clear()
	{
		lineCount = 0;
		position = default;
		direction = default;
		inBerserkState = false;
	}
}
