public class SpecialModeGoblinsFail : BaseAdventureEvent
{
	public static SpecialModeGoblinsFail Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<SpecialModeGoblinsFail>("SPECIALMODE_GOBLINS_FAIL");
	}

	public SpecialModeGoblinsFail()
		: base("SPECIALMODE_GOBLINS_FAIL")
	{
	}

	public override void Clear()
	{
	}
}
