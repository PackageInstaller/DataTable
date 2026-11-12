public class KasimiraNormalAttackFinishEvent : BaseAdventureEvent
{
	public bool isSpecial;

	public static KasimiraNormalAttackFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<KasimiraNormalAttackFinishEvent>("KASIMIRA_NORMALATTACK_FINISH");
	}

	public KasimiraNormalAttackFinishEvent()
		: base("KASIMIRA_NORMALATTACK_FINISH")
	{
	}

	public override void Clear()
	{
		isSpecial = false;
	}
}
