using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._50541ChuShi;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.ChuShi_001;

	private static readonly List<int> teammateIndex_1 = new List<int> { 1, 2 };

	private const int teammateCountSameTime_1 = 15;

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.ChuShi_002;

	private static readonly int bulletTag_2 = CommonHelper.StringToHash("Knife_CallBack_Fire");

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.ChuShi_003;

	private static readonly List<int> killTeammateIndex_3 = new List<int> { 1, 2 };

	private bool _achievementTypeFinish_1;

	private int _teammateCount_1;

	private bool _achievementTypeFinish_2;

	private bool _canFinishAchievementType_2;

	private bool _achievementTypeFinish_3;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ChuShi_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ChuShi_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ChuShi_003);
		_teammateCount_1 = 0;
		_canFinishAchievementType_2 = true;
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (!((evt as AdventurActorSpawned).sender is MonsterAdventureActor item) || _achievementTypeFinish_1)
		{
			return;
		}
		for (int i = 0; i < teammateIndex_1.Count; i++)
		{
			int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, teammateIndex_1.get_Item(i));
			if (ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex).Contains(item))
			{
				_teammateCount_1++;
				break;
			}
		}
		if (_teammateCount_1 >= 15)
		{
			_achievementTypeFinish_1 = SetAchievementState(HotfixEnum.questCompleteCondClient.ChuShi_001);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner is MonsterAdventureActor && !_achievementTypeFinish_2 && _canFinishAchievementType_2 && adventureBulletBornEvent.bulletHashCode == bulletTag_2)
		{
			_canFinishAchievementType_2 = false;
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (!(adventureActorDiedEvent.actor is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (adventureActorDiedEvent.killer != _actor && !_achievementTypeFinish_3)
		{
			for (int i = 0; i < killTeammateIndex_3.Count; i++)
			{
				int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, killTeammateIndex_3.get_Item(i));
				if (ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex).Contains(monsterAdventureActor))
				{
					_achievementTypeFinish_3 = SetAchievementState(HotfixEnum.questCompleteCondClient.ChuShi_003);
					break;
				}
			}
		}
		if (!_achievementTypeFinish_1)
		{
			for (int j = 0; j < teammateIndex_1.Count; j++)
			{
				int teammateIdByIndex2 = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, teammateIndex_1.get_Item(j));
				if (ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex2).Contains(monsterAdventureActor))
				{
					_teammateCount_1--;
					break;
				}
			}
		}
		if (monsterAdventureActor == _actor && !_achievementTypeFinish_2 && _canFinishAchievementType_2)
		{
			SetAchievementState(HotfixEnum.questCompleteCondClient.ChuShi_002);
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

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
	}
}
