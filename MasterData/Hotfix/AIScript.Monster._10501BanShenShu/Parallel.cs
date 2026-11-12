using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._10501BanShenShu;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.BanShenShu_001;

	private const int killTeammateIndex_1 = 4;

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.BanShenShu_002;

	private const int notKillTeammateIndex_2 = 4;

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.BanShenShu_003;

	private readonly List<int> checkTeammateIndexList_3 = new List<int> { 1, 2, 3 };

	private const HotfixEnum.questCompleteCondClient achievementType_4 = HotfixEnum.questCompleteCondClient.BanShenShu_004;

	private bool _achievementTypeFinish_1;

	private bool _achievementTypeFinish_2;

	private bool _canFinishAchievementType_2;

	private bool _achievementTypeFinish_3;

	private int _teammateCount_3;

	private bool _achievementTypeFinish_4;

	private bool _canFinishAchievementType_4;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.BanShenShu_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.BanShenShu_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.BanShenShu_003);
		_achievementTypeFinish_4 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.BanShenShu_004);
		_canFinishAchievementType_2 = true;
		_teammateCount_3 = 0;
		foreach (int item in checkTeammateIndexList_3)
		{
			int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, item);
			List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
			if (list != null && list.Count > 0)
			{
				_teammateCount_3 += list.Count;
			}
		}
		_canFinishAchievementType_4 = true;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is MonsterAdventureActor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor && !_achievementTypeFinish_4 && _canFinishAchievementType_4)
		{
			_canFinishAchievementType_4 = adventureActorReceiveDamageEvent.damageToShieldAndHp <= 0;
		}
	}

	private void OnActorSpawn(IEvent evt)
	{
		if (!(evt is AdventurActorSpawned { sender: MonsterAdventureActor sender }) || _achievementTypeFinish_3)
		{
			return;
		}
		foreach (int item in checkTeammateIndexList_3)
		{
			int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, item);
			if (sender.dataID == teammateIdByIndex)
			{
				_teammateCount_3++;
				break;
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (!(evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } adventureActorDiedEvent))
		{
			return;
		}
		if (adventureActorDiedEvent.killer is PlayerAdventureActor || adventureActorDiedEvent.killer.IsPlayerMinion(out var _))
		{
			if (!_achievementTypeFinish_1)
			{
				int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, 4);
				List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
				if (list != null && list.Count > 0 && list.Contains(actor))
				{
					_achievementTypeFinish_1 = SetAchievementState(HotfixEnum.questCompleteCondClient.BanShenShu_001);
				}
			}
			if (!_achievementTypeFinish_2 && _canFinishAchievementType_2)
			{
				int teammateIdByIndex2 = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, 4);
				List<LogicEntity> list2 = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex2);
				if (list2 != null && list2.Count > 0)
				{
					_canFinishAchievementType_2 = !list2.Contains(actor);
				}
			}
			if (!_achievementTypeFinish_3)
			{
				foreach (int item in checkTeammateIndexList_3)
				{
					int teammateIdByIndex3 = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, item);
					if (actor.dataID == teammateIdByIndex3)
					{
						_teammateCount_3--;
						break;
					}
				}
			}
		}
		if (actor == _actor)
		{
			if (!_achievementTypeFinish_2 && _canFinishAchievementType_2)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.BanShenShu_002);
			}
			if (!_achievementTypeFinish_3 && _teammateCount_3 > 0)
			{
				_achievementTypeFinish_3 = SetAchievementState(HotfixEnum.questCompleteCondClient.BanShenShu_003);
			}
			if (!_achievementTypeFinish_4 && _canFinishAchievementType_4)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.BanShenShu_004);
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

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_canFinishAchievementType_2 = false;
		_canFinishAchievementType_4 = false;
	}
}
