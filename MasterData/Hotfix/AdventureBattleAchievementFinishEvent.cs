public class AdventureBattleAchievementFinishEvent : BaseAdventureEvent
{
	public HotfixEnum.questCompleteCondClient achievementType;

	public static AdventureBattleAchievementFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBattleAchievementFinishEvent>("BATTLE_ACHIEVEMENT_FINISH");
	}

	public AdventureBattleAchievementFinishEvent()
		: base("BATTLE_ACHIEVEMENT_FINISH")
	{
	}
}
