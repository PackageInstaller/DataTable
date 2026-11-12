using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private const string _skillSplitThrow_bigBullet_tag = "skillSplitThrow_bigBullet";

	private const string _skillSplitThrow_smallBullet_tag = "skillSplitThrow_smallBullet";

	private readonly string _skillSplitThrow_bullet_alias = "Slime_SplitThrow_Born";

	private readonly int _skillSplitThrow_summon_rate_first = 50;

	private readonly int _skillSplitThrow_summon_id_first = 5000312;

	private readonly int _skillSplitThrow_summon_id_second = 5000312;

	private readonly string _skillSplitThrow_summon_tag = "skillSplitThrow_summon";

	private readonly int _skillSplitThrow_summon_maxCount = 2;

	private readonly int _skillSplitThrow_inner_radius = 3;

	private readonly int _skillSplitThrow_outer_radius = 5;

	private readonly int _selectPointMaxCount = 15;

	private const string _skillSlide_bullet_tag = "skillSlide_bullet";

	private readonly int _skillSlide_summon_rate_first = 50;

	private readonly int _skillSlide_summon_id_first = 5000314;

	private readonly int _skillSlide_summon_id_second = 5000314;

	private readonly string _skillSlide_summon_tag = "skillSlide_summon";

	private int _skillSplitThrowSummonCount;

	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.ShiLaiMuWang_001;

	private const string checkLogicTag_1 = "IsBurst";

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.ShiLaiMuWang_002;

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.ShiLaiMuWang_003;

	private const string checkLogicTag_3 = "IsBurst";

	private static readonly int checkHitTag_3 = CommonHelper.StringToHash("DaShiLaiMu_KuoSanBo");

	private const HotfixEnum.questCompleteCondClient achievementType_4 = HotfixEnum.questCompleteCondClient.ShiLaiMuWang_004;

	private static readonly List<int> checkSkillId_4 = new List<int> { 0, 0 };

	private const string checkLogicTag_4 = "slideFinish";

	private static readonly FP checkTime_4 = 13.3;

	private static readonly List<int> checkTeammateIndex_4 = new List<int> { 1, 2 };

	private const HotfixEnum.questCompleteCondClient achievementType_5 = HotfixEnum.questCompleteCondClient.ShiLaiMuWang_005;

	private static readonly List<int> checkSkillId_5 = new List<int> { 5008113, 5008193 };

	private const string checkLogicTag_5 = "slideFinish";

	private bool _achievementTypeFinish_1;

	private bool _achievementTypeFinish_2;

	private bool _achievementTypeFinish_3;

	private bool _hitPlayer_3;

	private bool _achievementTypeFinish_4;

	private bool _canCheck_4;

	private FP _checkTime_4;

	private bool _forceFailed_4;

	private bool _achievementTypeFinish_5;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		_skillSplitThrowSummonCount = 0;
	}

	private void OnBulletFinish(IEvent iEvent)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = iEvent as AdventureBulletFinishEvent;
		switch (adventureBulletFinishEvent.tag)
		{
		case "skillSplitThrow_bigBullet":
			SplitBullet(adventureBulletFinishEvent.bulletPosition);
			break;
		case "skillSplitThrow_smallBullet":
		{
			int monsterId = _skillSplitThrow_summon_id_first;
			TSVector2 normalized = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - adventureBulletFinishEvent.bulletPosition).normalized;
			if (TSRandom.value * 100 < _skillSplitThrow_summon_rate_first)
			{
				monsterId = _skillSplitThrow_summon_id_second;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, adventureBulletFinishEvent.bulletPosition, normalized);
			break;
		}
		case "skillSlide_bullet":
		{
			int monsterId = _skillSlide_summon_id_first;
			TSVector2 normalized = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - adventureBulletFinishEvent.bulletPosition).normalized;
			if (TSRandom.value * 100 < _skillSlide_summon_rate_first)
			{
				monsterId = _skillSlide_summon_id_second;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, adventureBulletFinishEvent.bulletPosition, normalized);
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("skillSlideSummonCount");
			_actor.logicVariable.SetLogicTagValue("skillSlideSummonCount", logicTagValue + 1);
			break;
		}
		}
	}

	private void SplitBullet(TSVector2 position)
	{
		int num = _skillSplitThrow_summon_maxCount - _skillSplitThrowSummonCount;
		if (num > 0)
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			switch (num)
			{
			case 1:
				Shoot(position, forward);
				break;
			case 2:
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 180);
				Shoot(position, forward);
				break;
			case 3:
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 120);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 120);
				Shoot(position, forward);
				break;
			case 4:
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 90);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 90);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 90);
				Shoot(position, forward);
				break;
			case 5:
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 72);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 72);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 72);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 72);
				Shoot(position, forward);
				break;
			case 6:
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 60);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 60);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 60);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 60);
				Shoot(position, forward);
				forward = TSVector2.Rotate(forward, 60);
				Shoot(position, forward);
				break;
			}
		}
	}

	private void Shoot(TSVector2 shootPosition, TSVector2 direction)
	{
		int num = TSRandom.Range(_skillSplitThrow_inner_radius, _skillSplitThrow_outer_radius);
		TSVector2 tSVector = shootPosition + direction * num;
		if (!_actor.QueryPositionReachable(tSVector))
		{
			tSVector = GetRandomPoint(shootPosition);
		}
		if (shootPosition != tSVector)
		{
			string skillSplitThrow_bullet_alias = _skillSplitThrow_bullet_alias;
			AdventureActor actor = _actor;
			TSVector2 targetPosition = tSVector;
			ILRuntimeAPI.Shoot(skillSplitThrow_bullet_alias, actor, default, shootPosition, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			_skillSplitThrowSummonCount++;
		}
	}

	private TSVector2 GetRandomPoint(TSVector2 position)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(_skillSplitThrow_outer_radius, _skillSplitThrow_inner_radius, position);
		return ILRuntimeAPI.GetRandomPointInShape(_actor, deterministicCircleShape, isReachable: true, _selectPointMaxCount);
	}

	protected override void OnActorDied(IEvent iEvent)
	{
		base.OnActorDied(iEvent);
		AdventureActorDiedEvent adventureActorDiedEvent = iEvent as AdventureActorDiedEvent;
		if (!(adventureActorDiedEvent.actor is PlayerAdventureActor))
		{
			if (((MonsterAdventureActor)adventureActorDiedEvent.actor).monsterInfo.Tag1 == _skillSplitThrow_summon_tag)
			{
				_skillSplitThrowSummonCount--;
			}
			if (((MonsterAdventureActor)adventureActorDiedEvent.actor).monsterInfo.Tag1 == _skillSlide_summon_tag)
			{
				FP logicTagValue = _actor.logicVariable.GetLogicTagValue("skillSlideSummonCount");
				_actor.logicVariable.SetLogicTagValue("skillSlideSummonCount", logicTagValue - 1);
			}
			OnActorDied(adventureActorDiedEvent);
		}
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShiLaiMuWang_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShiLaiMuWang_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShiLaiMuWang_003);
		_achievementTypeFinish_4 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShiLaiMuWang_004);
		_achievementTypeFinish_5 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShiLaiMuWang_005);
		_hitPlayer_3 = false;
		_canCheck_4 = false;
		_checkTime_4 = 0;
		_forceFailed_4 = false;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor)
		{
			if (!_achievementTypeFinish_2 && (adventureActorReceiveDamageEvent.lostControlType & LostControlType.AirBorne) != 0)
			{
				_achievementTypeFinish_2 = SetAchievementState(HotfixEnum.questCompleteCondClient.ShiLaiMuWang_002);
			}
			if (!_achievementTypeFinish_3 && !_hitPlayer_3)
			{
				_hitPlayer_3 = CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, checkHitTag_3);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (adventureActorCastSkillEvent.sender is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor == _actor && !_achievementTypeFinish_4 && checkSkillId_4.Contains(adventureActorCastSkillEvent.skillEventInfo.skillId))
		{
			_canCheck_4 = true;
		}
	}

	public void OnUpdate()
	{
		if (_canCheck_4)
		{
			if (_actor.logicVariable.GetLogicTagToggle("slideFinish"))
			{
				_checkTime_4 += _actor.LogicDeltaTime;
				if (!(_checkTime_4 >= checkTime_4))
				{
					return;
				}
				if (!_forceFailed_4)
				{
					bool flag = false;
					for (int i = 0; i < checkTeammateIndex_4.Count; i++)
					{
						int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, checkTeammateIndex_4.get_Item(i));
						if (ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex).Count > 0)
						{
							flag = true;
							break;
						}
					}
					if (!flag)
					{
						_achievementTypeFinish_4 = SetAchievementState(HotfixEnum.questCompleteCondClient.ShiLaiMuWang_004);
					}
				}
				_canCheck_4 = false;
			}
			else
			{
				_checkTime_4 = 0;
			}
		}
		else
		{
			_checkTime_4 = 0;
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (!_achievementTypeFinish_4 && checkSkillId_4.Contains(adventureActorCastSkillEndEvent.skillEventInfo.skillId) && !_actor.logicVariable.GetLogicTagToggle("slideFinish"))
		{
			_canCheck_4 = false;
		}
		if (!_achievementTypeFinish_5 && checkSkillId_5.Contains(adventureActorCastSkillEndEvent.skillEventInfo.skillId) && !_actor.logicVariable.GetLogicTagToggle("slideFinish"))
		{
			_achievementTypeFinish_5 = SetAchievementState(HotfixEnum.questCompleteCondClient.ShiLaiMuWang_005);
		}
	}

	private void OnActorDied(AdventureActorDiedEvent diedEvent)
	{
		if (!(diedEvent.actor is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (diedEvent.killer == _actor && !_achievementTypeFinish_4 && _canCheck_4 && !_forceFailed_4)
		{
			for (int i = 0; i < checkTeammateIndex_4.Count; i++)
			{
				int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, checkTeammateIndex_4.get_Item(i));
				List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
				if (((list.Count > 0) ? (list.get_Item(0) as MonsterAdventureActor) : null) == monsterAdventureActor)
				{
					_forceFailed_4 = true;
					break;
				}
			}
		}
		if (diedEvent.actor == _actor)
		{
			if (!_achievementTypeFinish_1 && !_actor.logicVariable.GetLogicTagToggle("IsBurst"))
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.ShiLaiMuWang_001);
			}
			if (!_achievementTypeFinish_3 && _actor.logicVariable.GetLogicTagToggle("IsBurst") && _hitPlayer_3)
			{
				SetAchievementState(HotfixEnum.questCompleteCondClient.ShiLaiMuWang_003);
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
