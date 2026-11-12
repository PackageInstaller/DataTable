public static class AdventureBootConfigSubscriber
{
	private static bool _registered;

	internal static void RegisterSubscriber()
	{
		if (!_registered)
		{
			Singleton<EventDispatchManager>.Instance.AddEventListener("Boot.BootConfigReady", OnBootConfigReady);
			_registered = true;
		}
	}

	private static void OnBootConfigReady(IEvent evt)
	{
		if (!((evt as GeneralEvent)?.data is BootConfigReadyEventData bootConfigReadyEventData) || bootConfigReadyEventData.BootConfig == null)
		{
			return;
		}
		BootConfig bootConfig = bootConfigReadyEventData.BootConfig as BootConfig;
		if (!(bootConfig == null))
		{
			AdventureGameContext.LevelLoadParam = bootConfig.adventureModuleLevelLoadParams;
			AdventureGameContext.AutoBattleConfig = bootConfig.autoBattleConfig;
			AdventureGameContext.TeamConfig = bootConfig.teamConfig;
			AdventureGameContext.IsTestBattle = bootConfigReadyEventData.IsTestBattle;
			if (!bootConfigReadyEventData.IsTestBattle && bootConfig.teamConfig != null)
			{
				bootConfig.teamConfig.playerIngoreCDAndEnergy = false;
				bootConfig.teamConfig.useUltraSkillLoadParams = false;
			}
		}
	}
}
