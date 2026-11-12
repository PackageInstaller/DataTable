public class AdventureMonsterActivationOtherMessage : BaseAdventureEvent
{
	public static AdventureMonsterActivationOtherMessage Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterActivationOtherMessage>("MONSTER_ACTIVATION_OTHER");
	}

	public AdventureMonsterActivationOtherMessage()
		: base("MONSTER_ACTIVATION_OTHER")
	{
	}

	public override void Clear()
	{
	}
}
