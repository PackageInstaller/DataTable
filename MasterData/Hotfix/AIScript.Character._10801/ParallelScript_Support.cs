using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class ParallelScript_Support : ParallelScript
{
	private static readonly int damageTag_Skill = CommonHelper.StringToHash("108_Support_Skill");

	private const int shootTimes = 3;

	private static readonly FP shootInterval = 0.1f;

	private const int shootRound = 1;

	private const string bulletKey = "Bullet_108_B2_Skill";

	private static readonly TSVector2 centerOffset_NoTarget = new TSVector2(0, 5);

	private static readonly FP bulletOffset = 2;

	private static readonly FP bulletRandomRadius = 2;

	private const string bulletTag_Skill = "Bullet108B2Skill";

	private static readonly int damageTag_Bullet = CommonHelper.StringToHash("108_B2");

	private const int perkId_21 = 510821;

	private const string areaEffectPath_21 = "AreaEffect_108_B2P21_Skill_FirePit";

	private const int perkId_22 = 510822;

	private const int shootTimes_22 = 5;

	private const int additionalAttrId_22 = 10852211;

	private const int perkId_23 = 510823;

	private const int buffId_23 = 10852311;

	private const int additionalAttrId_23 = 10852311;

	private const int perkId_24 = 510824;

	private readonly FP searchRadius_24 = 10;

	private readonly FP shootInterval_24 = 0.1f;

	private const int additionalAttrId_24 = 10852411;

	private const int perkId_25 = 510825;

	private const int buffId_25 = 1011;

	private const int hitDamageId_25 = 108525001;

	private readonly FP hitRadius_25 = 5;

	private const string hitFxPath_25 = "fx_10801_b1_skill_fire_tab_burst_strengthen";

	private const string hittedFxPath_25 = "fx_10801_hit_common_middle";

	private readonly FP stiffDuration_25 = 0.5f;

	private readonly FP hitStrenth_25 = 4;

	private readonly FP triggerCD_25 = 0.5;

	private const int perkId_26 = 510826;

	private const int buffId_26 = 10852601;

	private const int perkId_27 = 510827;

	private const int parameterId_27 = 10852711;

	private const int additionalAttrId_27 = 10852701;

	private const int perkId_28 = 510828;

	private const int parameterId_28 = 10852801;

	private static readonly int damageTag_28 = CommonHelper.StringToHash("108_Support_Skill");

	private const int additionalAttrId_28 = 10852801;

	private const int perkId_29 = 510829;

	private const int shootRound_29 = 2;

	private readonly FP interval_EveryRound_29 = 1;

	private const int parameterId_29 = 10852901;

	private static readonly int damageTag_29 = CommonHelper.StringToHash("108_Support_Skill");

	private const int additionalAttrId_29 = 10852901;

	private const int perkId_30 = 510830;

	private const int additionalAttrId_30 = 10853001;

	private const int perkId_31 = 510831;

	private const int buffId_31 = 1011;

	private const int parameterId_31 = 10853101;

	private readonly FP cd_31 = 1;

	private const int additionalAttrId_31 = 10853101;

	private const int perkId_33 = 510833;

	private const int additionalAttrId_33 = 10853301;

	private FP _lastCastSkillTime;

	private CommomAreaHitConfig _areaHitConfig;

	private FP _lastTriggerTime_25;

	private FP _lastTriggerTime_31;

	public override void OnEnable()
	{
		base.OnEnable();
		_lastCastSkillTime = 0;
		_lastTriggerTime_25 = 0;
		_lastTriggerTime_31 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("KASIMIRA_SKILL_SHOOT", OnReceiveShootEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void OnReceiveShootEvent(IEvent evt)
	{
		KasimiraSkillShootEvent kasimiraSkillShootEvent = evt as KasimiraSkillShootEvent;
		int num = 3;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510822, out var perkLevel))
		{
			num = 5;
		}
		int num2 = 1;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510829, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 10852901);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				num2 = 2;
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510824, out perkLevel))
		{
			if (kasimiraSkillShootEvent.target == null)
			{
				TSVector2 centerPosition = _actor.tsTransform.Position + _actor.tsTransform.Left * centerOffset_NoTarget.x + _actor.tsTransform.Forward * centerOffset_NoTarget.y;
				_actor.StartLogicCoroutine(ShootLogic_NoTarget(kasimiraSkillShootEvent.shootPosition, centerPosition, num, shootInterval, num2));
			}
			else
			{
				_actor.StartLogicCoroutine(ShootLogic_24(kasimiraSkillShootEvent.shootPosition, kasimiraSkillShootEvent.target, num, num2));
			}
		}
		else if (kasimiraSkillShootEvent.target == null)
		{
			TSVector2 centerPosition2 = _actor.tsTransform.Position + _actor.tsTransform.Left * centerOffset_NoTarget.x + _actor.tsTransform.Forward * centerOffset_NoTarget.y;
			_actor.StartLogicCoroutine(ShootLogic_NoTarget(kasimiraSkillShootEvent.shootPosition, centerPosition2, num, shootInterval, num2));
		}
		else
		{
			_actor.StartLogicCoroutine(ShootLogic(kasimiraSkillShootEvent.shootPosition, kasimiraSkillShootEvent.target, num, num2));
		}
	}

	private IEnumerator ShootLogic_NoTarget(TSVector2 shootPosition, TSVector2 centerPosition, int shootTimes, FP shootInterval, int shootRound)
	{
		for (int round = 0; round < shootRound; round++)
		{
			if (round > 0)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval_EveryRound_29));
			}
			for (int times = 0; times < shootTimes; times++)
			{
				if (times > 0)
				{
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootInterval));
				}
				TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(centerPosition, 0, bulletRandomRadius);
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 targetPosition = tSVector;
				ILRuntimeAPI.Shoot("Bullet_108_B2_Skill", actor, range, shootPosition, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private IEnumerator ShootLogic(TSVector2 shootPosition, LogicEntity target, int shootTimes, int shootRound)
	{
		TSVector2 defaultPosition = target.tsTransform.Position;
		for (int round = 0; round < shootRound; round++)
		{
			if (round > 0)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval_EveryRound_29));
			}
			for (int times = 0; times < shootTimes; times++)
			{
				if (times > 0)
				{
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootInterval));
				}
				int num = times % 5;
				TSVector2 center = defaultPosition;
				if (!target.IsDead())
				{
					center = target.tsTransform.Position;
				}
				switch (num)
				{
				case 1:
					center += new TSVector2(-bulletOffset, 0);
					break;
				case 2:
					center += new TSVector2(bulletOffset, 0);
					break;
				case 3:
					center += new TSVector2(0, -bulletOffset);
					break;
				case 4:
					center += new TSVector2(0, bulletOffset);
					break;
				}
				center = TrueSyncExtensions.RandomPointInsideRing(center, 0, bulletRandomRadius);
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 targetPosition = center;
				ILRuntimeAPI.Shoot("Bullet_108_B2_Skill", actor, range, shootPosition, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private IEnumerator ShootLogic_24(TSVector2 shootPosition, LogicEntity target, int shootTimes, int shootRound)
	{
		List<TSVector2> positionList = new List<TSVector2> { target.tsTransform.Position };
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, target.tsTransform.Position, searchRadius_24, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int i = 0; i < result.Count; i++)
				{
					if (result.get_Item(i) is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.Id != target.Id && !monsterAdventureActor.IsDead())
					{
						positionList.Add(monsterAdventureActor.tsTransform.Position);
					}
				}
			}
		}, isConfront: true);
		for (int round = 0; round < shootRound; round++)
		{
			if (round > 0)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval_EveryRound_29));
			}
			int index = 0;
			for (int times = 0; times < shootTimes; times++)
			{
				if (times > 0)
				{
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(shootInterval_24));
				}
				TSVector2 tSVector = positionList.get_Item(index);
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 targetPosition = tSVector;
				ILRuntimeAPI.Shoot("Bullet_108_B2_Skill", actor, range, shootPosition, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
				index++;
				index = ((index < positionList.Count) ? index : 0);
			}
		}
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		_lastCastSkillTime = _actor.LogicTime;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510828, out var _))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 10852801);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				_playerSkillCd.ResetSkillCD(ActionKey.B);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner != null && adventureBulletFinishEvent.owner.Id == _actor.Id && string.Equals(adventureBulletFinishEvent.tag, "Bullet108B2Skill") && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510821, out var _) && !string.IsNullOrEmpty("AreaEffect_108_B2P21_Skill_FirePit"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_108_B2P21_Skill_FirePit", adventureBulletFinishEvent.bulletPosition);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510826, out var perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, damageTag_Bullet))
		{
			monsterAdventureActor.buffComponent?.AddBuff(10852601, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510831, out perkLevel) && (_lastTriggerTime_31 <= 0 || _actor.LogicTime - _lastTriggerTime_31 > cd_31) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, ParallelScript.damageTag_UltraSkill))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 10853101);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				(attackEvent.to as MonsterAdventureActor).buffComponent.AddBuff(1011, _actor);
				_lastTriggerTime_31 = _actor.LogicTime;
			}
		}
	}

	protected override void OnBeforePlayerHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforePlayerHit(beforeHitEvent);
		PlayerAdventureActor playerAdventureActor = beforeHitEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510827, out var _))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 10852711);
			if (_lastCastSkillTime > 0 && _actor.LogicTime - _lastCastSkillTime <= scriptValue && (monsterAdventureActor.isStun || monsterAdventureActor.isToughnessBrokenState))
			{
				AdventureActor.AddFromAttr(10852701, _actor);
			}
		}
		if (beforeHitEvent.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510833, out var _) && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			AdventureActor.AddFromAttr(10853301, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510822, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Skill))
		{
			AdventureActor.AddFromAttr(10852211, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510823, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Skill))
		{
			AdventureActor.AddFromAttr(10852311, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510824, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Skill))
		{
			AdventureActor.AddFromAttr(10852411, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510828, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_28))
		{
			AdventureActor.AddFromAttr(10852801, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510829, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_29))
		{
			AdventureActor.AddFromAttr(10852901, _actor);
		}
		if (beforeHitEvent.elementType == HotfixEnum.elementType.FE && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510830, out perkLevel) && (monsterAdventureActor.isStun || monsterAdventureActor.isToughnessBrokenState) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Bullet))
		{
			AdventureActor.AddFromAttr(10853001, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510831, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, ParallelScript.damageTag_UltraSkill))
		{
			AdventureActor.AddFromAttr(10853101, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, damageTag_Bullet) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510823, out var _))
		{
			monsterAdventureActor.buffComponent?.AddBuff(10852311, _actor);
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510825, out var _) && (_lastTriggerTime_25 <= 0 || _actor.LogicTime - _lastTriggerTime_25 > triggerCD_25) && actor.buffComponent.CheckBuff(0, 1011, 0, _actor))
		{
			if (_areaHitConfig == null)
			{
				_areaHitConfig = new CommomAreaHitConfig
				{
					fxAlias = "fx_10801_b1_skill_fire_tab_burst_strengthen",
					hitDamageId = 108525001,
					hitFlags = (HitBox.FeatureFlag.Stiff | HitBox.FeatureFlag.AddBuffForTarget),
					hitFeatureData = new HitBox.HitBoxFeatureData
					{
						buffIdsForTarget = new List<int> { 1011 },
						StiffDuration = stiffDuration_25,
						hitStrenth = hitStrenth_25
					},
					hittedEffectAlias = "fx_10801_hit_common_middle",
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig.position = actor.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_25, 0);
			_lastTriggerTime_25 = _actor.LogicTime;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("KASIMIRA_SKILL_SHOOT", OnReceiveShootEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		_lastCastSkillTime = 0;
		_lastTriggerTime_25 = 0;
		_lastTriggerTime_31 = 0;
	}
}
