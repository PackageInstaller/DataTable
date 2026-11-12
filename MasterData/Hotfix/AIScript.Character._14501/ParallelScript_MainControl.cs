using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class ParallelScript_MainControl : ParallelScript
{
	private string areaEffect_Base = "AreaEffect_145_SkillMain_ShotBoom";

	private const int perkId_1 = 514501;

	private int paramId_1_reduceCd = 14501011;

	private int paramId_1_RecoveryEnergy = 14501012;

	private int num_1 = 3;

	private FP radius_3 = 3;

	private FP triggerCd_1 = 1;

	private const int perkId_2 = 514502;

	private FP recoveryCd_2 = 1;

	private int paramId_2_recoverEnergy = 14502011;

	public int shieldTag_2 = CommonHelper.StringToHash("145P2HuDun");

	private FP radius_2 = 3;

	private const int perkId_4 = 514504;

	private string bullet_4 = "Bullet_145_P4_SplitBullet";

	private FP shootPosY = 1.5;

	private int shootNum_4 = 8;

	private FP startAngle_4 = 0;

	private const int perkId_5 = 514505;

	private FP cd_5 = 2;

	private int paramId_5_hitCount = 14505011;

	private int hitId_5 = 145300005;

	private const int perkId_6 = 514506;

	private int buff_6 = 14506011;

	private const int perkId_7 = 514507;

	private int buff_7 = 14507011;

	private const int perkId_8 = 514508;

	private int section_8 = 1;

	private int buff_8 = 14508011;

	private const int perkId_9 = 514509;

	private int once_9 = 14509001;

	private const int perkId_10 = 514510;

	private const int perkId_11 = 514511;

	private int section_11 = 1;

	private int buff_11 = 14511011;

	private const int perkId_12 = 514512;

	private const int perkId_13 = 514513;

	private int buff_13 = 14513011;

	private ActorSearchTarget actorSearchInfo;

	private List<DeterministicCollider> colliders = new List<DeterministicCollider>();

	private int _hitCount_5;

	private CoroutineNode corArea;

	private CoroutineNode corRecovery;

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	private FP yuanHuJuJiTriggerTime;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT", OnTriggerCharGamePlayLogicCommonEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		_hitCount_5 = 0;
		yuanHuJuJiTriggerTime = 0;
		if (GetPerk(514508))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.B);
			skillMgr.SetSkillTotalSection(ActionKey.B, skillCD.totalSectionAmount + section_8, forceMaxSection: true);
		}
		if (GetPerk(514511))
		{
			SkillInfo skillCD2 = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD2.totalSectionAmount + section_11, forceMaxSection: true);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_CHAR_GAMEPLAYLOGIC_COMMON_EVENT", OnTriggerCharGamePlayLogicCommonEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		colliders.Clear();
		skillMgr.ResetSkillTotalSection(ActionKey.B);
		skillMgr.ResetSkillTotalSection(ActionKey.A);
		StopCoroutine(ref corArea);
		StopCoroutine(ref corRecovery);
	}

	private void OnTriggerCharGamePlayLogicCommonEvent(IEvent evt)
	{
		if (evt is TriggerCharGamePlayLogicCommonEvent { normalAttackTrigger: not false } && GetPerk(514506))
		{
			_actor.buffComponent.AddBuff(buff_6, _actor);
		}
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt, bool isSelf)
	{
		base.OnCastSkill(evt, isSelf);
		if (!isSelf)
		{
			return;
		}
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (GetPerk(514511))
			{
				_actor.buffComponent.AddBuff(buff_11, _actor);
			}
		}
		else if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerk(514507))
			{
				_actor.buffComponent.AddBuff(buff_7, _actor);
			}
			if (GetPerk(514508))
			{
				_actor.buffComponent.AddBuff(buff_8, _actor);
			}
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
		if (!isSelf || !CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS_Shoot))
		{
			return;
		}
		if (GetPerk(514504))
		{
			float num = 360f / (float)shootNum_4;
			for (int i = 0; i < shootNum_4; i++)
			{
				FP degrees = (float)i * num + startAngle_4;
				TSVector2 shootDir = TSVector2.Rotate(TSVector2.up, degrees);
				TSVector2 position = monster.tsTransform.Position;
				FP positionY = shootPosY;
				ILRuntimeAPI.ShootByDirection(bullet_4, _actor, default, shootDir, position, positionY);
			}
		}
		if (evt.weapon != null)
		{
			FP radius = monster.GetRadius();
			TSVector2 normalized = (monster.tsTransform.Position - _actor.tsTransform.Position).normalized;
			TSVector2 pos = monster.tsTransform.Position - normalized * radius;
			StartCoroutine(ref corArea, DoAreaLogic(areaEffect_Base, pos, normalized.GetAngle()));
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS) && GetPerk(514509) && monster.buffComponent.CheckBuffByBuffTag(buffTag_Dark))
		{
			AdventureActor.AddFromAttr(once_9, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (flag)
		{
			if (!GetPerk(514505))
			{
				return;
			}
			int num = CommonUtils.GetScriptValue(_actor, paramId_5_hitCount).AsInt();
			_hitCount_5++;
			if (_hitCount_5 < num || !CheckPerkCd(514505L, cd_5))
			{
				return;
			}
			_hitCount_5 = 0;
			int key = TSRandom.Range(0, dicAreaEffectAim.Count);
			ILRuntimeAPI.PlayAreaEffect(_actor, dicAreaEffectAim.get_Item(key), monster.tsTransform.Position, default, (AreaEffectEntity entity) =>
			{
				AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = hitId_5;
				}
			});
			TriggerYuanHuJuJi();
		}
		else if (flag2 && GetPerk(514512))
		{
			TriggerMask(evt, monster);
		}
	}

	public override void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		base.OnTriggerMask(evt);
		if (GetPerk(514513))
		{
			_actor.buffComponent.AddBuff(buff_13, _actor);
		}
	}

	public override void OnShieldChange(AdventureActorRemoveShield evt)
	{
		if (evt.shieldTags.Contains(shieldTag_2))
		{
			StopCoroutine(ref corRecovery);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode != shootEvent || !GetPerk(514501))
		{
			return;
		}
		List<LogicEntity> hearRangeSearch = ILRuntimeAPI.GetHearRangeSearch(_actor);
		hearRangeSearch = hearRangeSearch.FindAll((LogicEntity e) => e is MonsterAdventureActor && !e.IsSearchedImmunity() && !e.IsBattleOut());
		for (int num = 0; num < num_1; num++)
		{
			int index = num % dicAreaEffectAim.Count;
			TSVector2 zero = TSVector2.zero;
			if (hearRangeSearch.Count > 0)
			{
				int index2 = num % hearRangeSearch.Count;
				zero = hearRangeSearch.get_Item(index2).tsTransform.Position;
			}
			else
			{
				TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(_actor.tsTransform.Position, 0, radius_3);
				zero = ((num < hearRangeSearch.Count) ? hearRangeSearch.get_Item(num).tsTransform.Position : tSVector);
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, dicAreaEffectAim.get_Item(index), zero, default, (AreaEffectEntity entity) =>
			{
				AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = dicAreaEffectHitId.get_Item(index);
				}
			});
			TriggerYuanHuJuJi();
		}
	}

	private void TriggerYuanHuJuJi()
	{
		if (GetPerk(514501) && _actor.LogicTime - yuanHuJuJiTriggerTime > triggerCd_1)
		{
			yuanHuJuJiTriggerTime = _actor.LogicTime;
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_1_reduceCd);
			skillMgr.ModifyResumeTimeAbs(-scriptValue, ActionKey.D);
			FP scriptValue2 = CommonUtils.GetScriptValue(_actor, paramId_1_RecoveryEnergy);
			skillMgr.AddEnergy(scriptValue2);
		}
	}

	public virtual void OnShieldAdd(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorAddShield adventureActorAddShield && adventureActorAddShield.shieldTags.Contains(shieldTag_2))
		{
			StartCoroutine(ref corRecovery, DoRecoveryEnergy());
		}
	}

	private IEnumerator DoAreaLogic(string aoe, TSVector2 pos, FP rotation)
	{
		yield return null;
		ILRuntimeAPI.PlayAreaEffect(_actor, aoe, pos, rotation);
	}

	private IEnumerator DoRecoveryEnergy()
	{
		while (true)
		{
			skillMgr.AddEnergy(CommonUtils.GetScriptValue(_actor, paramId_2_recoverEnergy));
			int index = TSRandom.Range(0, dicAreaEffectAim.Count);
			_ = TSVector2.zero;
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : TrueSyncExtensions.RandomPointInsideRing(_actor.tsTransform.Position, 0, radius_2));
			ILRuntimeAPI.PlayAreaEffect(_actor, dicAreaEffectAim.get_Item(index), position, default, (AreaEffectEntity entity) =>
			{
				AreaEffect_AttackComponent logicComponent = entity.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = dicAreaEffectHitId.get_Item(index);
				}
			});
			TriggerYuanHuJuJi();
			yield return _actor.WaitTime(recoveryCd_2);
		}
	}
}
