public class AdventureMsgShowBossHpBarEvent : BaseAdventureEvent
{
	public static AdventureMsgShowBossHpBarEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMsgShowBossHpBarEvent>("ADVENTURE_BATTLE_SHOW_BOSS_HPBAR");
	}

	public AdventureMsgShowBossHpBarEvent()
		: base("ADVENTURE_BATTLE_SHOW_BOSS_HPBAR")
	{
	}
}
