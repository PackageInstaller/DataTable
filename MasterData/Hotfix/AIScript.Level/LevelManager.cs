using AIScript.DynamicLevel;

namespace AIScript.Level;

public class LevelManager : AIBase
{
	public void LoadLevelController()
	{
		AdventureLevelController adventureLevelController = null;
		switch (ModuleController<AdventureModuleController>.Instance.levelType)
		{
		case HotfixEnum.worldLevelType.Mainline:
		case HotfixEnum.worldLevelType.Branchline:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<MainlineLevelController>();
			break;
		case HotfixEnum.worldLevelType.RegionBoss:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<RegionBossLevelController>();
			break;
		case HotfixEnum.worldLevelType.TravelerDuel:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<TravelerduelController>();
			break;
		case HotfixEnum.worldLevelType.DailyInstance:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<DailyInstanceLevelController>();
			break;
		case HotfixEnum.worldLevelType.InfinityTower:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<InfinityTowerLevelController>();
			break;
		case HotfixEnum.worldLevelType.EquipmentInstance:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<EquipmentInstanceLevelController>();
			break;
		case HotfixEnum.worldLevelType.VampireInstance:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<VampireInstanceLevelController>();
			break;
		case HotfixEnum.worldLevelType.ScoreBoss:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<ScoreBossLevelController>();
			MonoSingleton<GameController>.Instance.uploadDamageData = true;
			break;
		case HotfixEnum.worldLevelType.SkillInstance:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<SkillInstanceLevelController>();
			break;
		case HotfixEnum.worldLevelType.WeeklyCopies:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<WeeklyCopiesLevelController>();
			break;
		case HotfixEnum.worldLevelType.ActivityLevels:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<ActivityLevelsInstanceController>();
			break;
		case HotfixEnum.worldLevelType.TowerDefense:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<TowerDefenseLevelController>();
			break;
		case HotfixEnum.worldLevelType.BrickBreaker:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<BrickBreakerController>();
			break;
		case HotfixEnum.worldLevelType.ActivityStory:
			adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<ActivityStoryLevelController>();
			break;
		case HotfixEnum.worldLevelType.Dynamic:
			switch ((HotfixEnum.dynamicLevelType)ModuleController<AdventureModuleController>.Instance.levelLoadParams.dynamicLevelType)
			{
			case HotfixEnum.dynamicLevelType.JointDrill:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<JointDrillLevelController>();
				break;
			case HotfixEnum.dynamicLevelType.Trial:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<TrialLevelController>();
				break;
			case HotfixEnum.dynamicLevelType.Tutorial:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<TutorialLevelController>();
				break;
			case HotfixEnum.dynamicLevelType.JointDrill_2:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<JointDrillLevelController_2>();
				break;
			case HotfixEnum.dynamicLevelType.TraceHunt:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<TraceHuntLevelController>();
				break;
			case HotfixEnum.dynamicLevelType.SoldierChess:
				adventureLevelController = ModuleController<AdventureModuleController>.Instance.controllerContent?.AddComponent<SoldierLevelController>();
				break;
			}
			MonoSingleton<GameController>.Instance.uploadDamageData = true;
			break;
		}
		if (adventureLevelController != null)
		{
			ModuleController<AdventureModuleController>.Instance.levelInstance = adventureLevelController;
		}
	}

	public void DynamicModule_LoadLevelController()
	{
		DynamicLevelController dynamicLevelController = ModuleController<DormModuleController>.Instance.InitDynamicLevelControllerContent(typeof(DormLevelController));
		if (dynamicLevelController != null)
		{
			ModuleController<DormModuleController>.Instance.levelInstance = dynamicLevelController;
		}
	}
}
