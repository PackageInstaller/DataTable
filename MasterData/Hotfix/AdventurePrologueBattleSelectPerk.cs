public class AdventurePrologueBattleSelectPerk : BaseAdventureEvent
{
	public static AdventurePrologueBattleSelectPerk Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePrologueBattleSelectPerk>("PROLOGUELEVEL_SELECTPERK");
	}

	public AdventurePrologueBattleSelectPerk()
		: base("PROLOGUELEVEL_SELECTPERK")
	{
	}

	public override void Clear()
	{
	}
}
