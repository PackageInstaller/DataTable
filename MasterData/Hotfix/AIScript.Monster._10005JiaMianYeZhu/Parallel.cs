using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.JiaMianYeZhu_001;

	private static readonly List<int> checkSkillId_1 = new List<int> { 1000510, 1000511, 1000505 };

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.JiaMianYeZhu_002;

	private static readonly int checkHitTag_2 = CommonHelper.StringToHash("YeZhu_Dash");

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.JiaMianYeZhu_003;

	private static readonly List<int> checkSkillId_3 = new List<int> { 1000510, 1000511, 1000505 };

	private static readonly FP checkTime_3 = 12;

	private static readonly int checkHitTag_3 = CommonHelper.StringToHash("YeZhu_ThoudsandDash");

	private const int needHitTimes_3 = 3;

	private const HotfixEnum.questCompleteCondClient achievementType_4 = HotfixEnum.questCompleteCondClient.JiaMianYeZhu_004;

	private bool _achievementTypeFinish_1;

	private bool _achievementTypeFinish_2;

	private bool _canFinishAchievementType_2;

	private bool _achievementTypeFinish_3;

	private FP _checkStartTime_3;

	private int _hitTimes_3;

	private bool _achievementTypeFinish_4;

	private bool _canFinishAchievementType_4;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.JiaMianYeZhu_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.JiaMianYeZhu_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.JiaMianYeZhu_003);
		_achievementTypeFinish_4 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.JiaMianYeZhu_004);
		_canFinishAchievementType_2 = true;
		_checkStartTime_3 = -1;
		_hitTimes_3 = 0;
		_canFinishAchievementType_4 = true;
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (adventureActorCastSkillEvent.sender as MonsterAdventureActor == _actor && !_achievementTypeFinish_3 && checkSkillId_3.Contains(adventureActorCastSkillEvent.skillEventInfo.skillId))
		{
			_checkStartTime_3 = _actor.LogicTime;
			_hitTimes_3 = 0;
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (adventureActorCastSkillEndEvent.sender as MonsterAdventureActor == _actor && !_achievementTypeFinish_1 && checkSkillId_1.Contains(adventureActorCastSkillEndEvent.skillEventInfo.skillId) && _actor.logicVariable.GetLogicTagToggle("ThousandDashInterrupt"))
		{
			_achievementTypeFinish_1 = SetAchievementState(HotfixEnum.questCompleteCondClient.JiaMianYeZhu_001);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from is MonsterAdventureActor) || !(adventureActorReceiveDamageEvent.to is PlayerAdventureActor))
		{
			return;
		}
		if (!_achievementTypeFinish_2 && _canFinishAchievementType_2)
		{
			_canFinishAchievementType_2 = !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, checkHitTag_2);
		}
		if (!_achievementTypeFinish_3 && _checkStartTime_3 >= 0 && _checkStartTime_3 + checkTime_3 > _actor.LogicTime && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, checkHitTag_3))
		{
			_hitTimes_3++;
			if (_hitTimes_3 >= 3)
			{
				_achievementTypeFinish_3 = SetAchievementState(HotfixEnum.questCompleteCondClient.JiaMianYeZhu_003);
			}
		}
		if (!_achievementTypeFinish_4 && _canFinishAchievementType_4)
		{
			_canFinishAchievementType_4 = adventureActorReceiveDamageEvent.damageToShieldAndHp <= 0;
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == _actor)
		{
			if (!_achievementTypeFinish_2 && _canFinishAchievementType_2)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.JiaMianYeZhu_002);
			}
			if (!_achievementTypeFinish_4 && _canFinishAchievementType_4)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.JiaMianYeZhu_004);
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		_canFinishAchievementType_2 = false;
		_checkStartTime_3 = -1;
		_hitTimes_3 = 0;
		_canFinishAchievementType_4 = false;
	}
}
