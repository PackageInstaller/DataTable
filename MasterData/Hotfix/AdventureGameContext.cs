public static class AdventureGameContext
{
	private static AdventureModuleLevelLoadParams _levelLoadParam = new AdventureModuleLevelLoadParams();

	private static bool _isIgnoreTimelinePerformanceLimit;

	public static AdventureModuleLevelLoadParams LevelLoadParam
	{
		get
		{
			return _levelLoadParam;
		}
		set
		{
			_levelLoadParam = value;
			AdventureGlobalState.IsStarTowerPrologue = value?.isStarTowerPrologue ?? false;
		}
	}

	public static AdventureAutoBattleConfig AutoBattleConfig { get; set; }

	public static GameTeamConfig TeamConfig { get; set; }

	public static bool IsTestBattle { get; set; }

	public static bool IsIgnoreTimelinePerformanceLimit
	{
		get
		{
			if (IsTestBattle)
			{
				return _isIgnoreTimelinePerformanceLimit;
			}
			return false;
		}
		set
		{
			_isIgnoreTimelinePerformanceLimit = value;
		}
	}
}
