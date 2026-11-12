using AIScript.Monster.Template;

namespace AIScript.Monster._50531DaGuanZi;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.DaGuanZi_001;

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.DaGuanZi_002;

	private readonly string LogicTag_IsXiaoGuanZi = "DaGuanZiToXiaoGuanZi";

	private bool _achievementTypeFinish_1;

	private bool _achievementTypeFinish_2;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.DaGuanZi_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.DaGuanZi_002);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if ((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor == _actor)
		{
			if (!_achievementTypeFinish_1 && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
			{
				_achievementTypeFinish_1 = SetAchievementState(HotfixEnum.questCompleteCondClient.DaGuanZi_001);
			}
			if (!_achievementTypeFinish_2 && monsterAdventureActor.logicVariable.GetLogicTagToggle(LogicTag_IsXiaoGuanZi))
			{
				_achievementTypeFinish_2 = SetAchievementState(HotfixEnum.questCompleteCondClient.DaGuanZi_002);
			}
		}
	}

	private bool SetAchievementState(HotfixEnum.questCompleteCondClient achievementType)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType))
		{
			return true;
		}
		ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(achievementType);
		return ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType);
	}
}
