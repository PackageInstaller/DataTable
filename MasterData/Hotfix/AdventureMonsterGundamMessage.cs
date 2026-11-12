using TrueSync;

public class AdventureMonsterGundamMessage : BaseAdventureEvent
{
	public string operationType;

	public long monsterId;

	public int skillId;

	public int skillType;

	public bool brokenOthers;

	public bool isNextHandSkill;

	public int handCount;

	public TSVector2 selectPosition;

	public long bodyId;

	public int actionPhase;

	public int cooperateType;

	public static AdventureMonsterGundamMessage Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterGundamMessage>("MONSTER_GAMDAM_MESSAGE");
	}

	public AdventureMonsterGundamMessage()
		: base("MONSTER_GAMDAM_MESSAGE")
	{
	}

	public override void Clear()
	{
		operationType = "";
		monsterId = 0L;
		skillId = 0;
		brokenOthers = false;
	}
}
