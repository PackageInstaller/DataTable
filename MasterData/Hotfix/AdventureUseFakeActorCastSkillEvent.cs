using TrueSync;

public class AdventureUseFakeActorCastSkillEvent : BaseAdventureEvent
{
	public TSVector2 position;

	public TSVector2 direction;

	public int templeteId;

	public long attributeId;

	public int skillId;

	public int factionId;

	public FP positionY;

	public static AdventureUseFakeActorCastSkillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureUseFakeActorCastSkillEvent>("USE_FAKEACTOR_CASTSKILL");
	}

	public AdventureUseFakeActorCastSkillEvent()
		: base("USE_FAKEACTOR_CASTSKILL")
	{
	}

	public override void Clear()
	{
		base.Clear();
		position = TSVector2.zero;
		direction = TSVector2.zero;
		templeteId = 0;
		attributeId = 0L;
		skillId = 0;
		factionId = 0;
		positionY = 0;
	}
}
