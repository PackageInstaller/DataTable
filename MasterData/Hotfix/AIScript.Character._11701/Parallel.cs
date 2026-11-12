using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11701;

public class Parallel : ParallelBase
{
	public const int buff_m1 = 11796111;

	private int onceId_m2 = 11796211;

	public const int buff_m3 = 11796311;

	private int buff_m4 = 11796411;

	public const int buff_m5 = 11796511;

	private static readonly int lightBoomHit = CommonHelper.StringToHash("lightBoomHit");

	private readonly string lightAreaEffect = "AreaEffect_117_B1_LightTag_Boom";

	private readonly int attackTag_normal = CommonHelper.StringToHash("117_Normal_Hit");

	private readonly int attackTag_skill = CommonHelper.StringToHash("117_B1_Skill_Hit");

	private readonly int attackTag_skill2 = CommonHelper.StringToHash("117_B2_Skill_Hit");

	private readonly int attackTag_ultra = CommonHelper.StringToHash("117_Ultra_Hit");

	private const string tipsKey_TriggerMark = "LightMark_Trigger_Effect_02";

	private readonly int hit_num = 4;

	private readonly FP hit_Duration = 10;

	private readonly FP hit_freq = 0.5;

	private const int hitDamageId_1 = 117400001;

	private readonly FP hitRadius_1 = 20;

	private const string hittedFxPath_1 = "fx_11701_hit_skill0";

	private readonly FP stiffDuration_1 = 0.5f;

	private readonly FP hitStrenth_1 = 4;

	public static readonly int perk_41 = 511741;

	private readonly string bulletQLTag = "qiling";

	public const int buff_p41 = 11741011;

	public static readonly int perk_42 = 511742;

	private FP hit_freq_p42 = 0.25;

	public const int attri_p42 = 11742001;

	public static readonly int perk_43 = 511743;

	private const int buff_p43 = 11743011;

	public static readonly int perk_1 = 511701;

	public static readonly string event_p1 = "117_Perk01";

	private readonly int buff_p1 = 11701011;

	public static readonly int perk_2 = 511702;

	private readonly int onceId_02 = 11702011;

	private const int perk_3 = 511703;

	private readonly FP _linkCheckRange_normal = 4;

	private const int _maxLinkTime = 5;

	private const int _hitDamageId_normal = 117503001;

	private const string _hitFxPath = "fx_11701_bullet_atk_1";

	private readonly FP _linkHitInterval = 0.35;

	private const int _hitDamageId_normal_for_secend = 117503002;

	private const string _hitFxPath_for_secend = "fx_11701_hit_atk_1";

	private readonly FP _doubleHitInterval = 0.5;

	public const int perk_4 = 511704;

	private readonly FP duration_p4 = 6;

	private const int range_p4 = 8;

	private const int numMax_p4 = 3;

	private readonly FP hitInterval_p4 = 1;

	private const string selfFx_p4 = "fx_11701_loop_perk9_Current";

	private readonly int damageId_p4 = 117504001;

	private readonly string fxAlias_p4 = "fx_11701_bullet_atk_2";

	public const int perk_5 = 511705;

	private readonly FP cd_p5 = 3;

	private const int attri_p5 = 11705001;

	private const string bullet_p5 = "Bullet_11701_Main_Skill_Thunder_P05_AOE";

	private FP delayTrigger = 0.5;

	public const int perk_6 = 511706;

	public const int buff_p6 = 11706011;

	public const int perk_7 = 511707;

	public const int buff_p7 = 11707011;

	private const int perk_8 = 511708;

	private const int buff_p8 = 11708011;

	private const int parameterId_p8 = 11708011;

	private const int onceId_8 = 11708001;

	public const int perk_9 = 511709;

	private const int buff_p9 = 11709011;

	public const int perk_10 = 511710;

	private const int buff_p10 = 11710011;

	private const int perk_11 = 511711;

	private readonly FP cd_p11 = 0;

	private const int buff_p11 = 11711011;

	private const int perk_12 = 511712;

	private readonly FP cd_p12 = 6;

	private const int parameterId_p12 = 11712011;

	private readonly string areaEffectAlias_perk_12 = "AreaEffect_117_Perk12_Repel";

	private const int perk_13 = 511713;

	private const int buff_10 = 11713011;

	public const int perk_21 = 511721;

	private const int oneceId_21 = 11721011;

	public const int perk_22 = 511722;

	private const int oneceId_22 = 11722011;

	public const int perk_23 = 511723;

	public const int perk_24 = 511724;

	private const int perk_25 = 511725;

	private const int attri_p25 = 11725001;

	public const int perk_26 = 511726;

	public const int parameterId_p26 = 11726011;

	private const int onceId_26 = 11726001;

	public const int perk_27 = 511727;

	private FP interval_p27 = 1;

	private const int attri_p27 = 11727001;

	public const int perk_28 = 511728;

	private const int count_p28 = 3;

	private static readonly int areaTag_28 = CommonHelper.StringToHash("117_B2_Area");

	public const int parameterId_p28 = 11728011;

	private const int onceId_28 = 11728001;

	private static readonly int areaTag_28_24 = CommonHelper.StringToHash("117_B2_Area");

	private const int count_p28_24 = 3;

	private const int perk_29 = 511729;

	private const int parameterId_p29 = 11729011;

	private const int buff_29 = 11729011;

	public const int perk_30 = 511730;

	public const int buff_p30 = 11730011;

	private const int perk_31 = 511731;

	private const int buff_31 = 3011;

	private const int onceId_31 = 11731001;

	public const int perk_33 = 511733;

	public const int buff_p33 = 11733011;

	public static int mainSkill_index;

	public static Dictionary<long, FP> dicArea_p27 = new Dictionary<long, FP>();

	private CommomAreaHitConfig _areaHitConfig_1;

	private HitBox.HitBoxFeatureData _featureData_1;

	private FP dazhaoDuration;

	private FP dazhaoHitTime;

	private FP hitPreD;

	private CoroutineNode _waitForDoubleHitCoroutine;

	private CoroutineNode _waitForLinkHitCoroutine;

	private int _linkTimes;

	private List<LogicEntity> _ridList = new List<LogicEntity>();

	private FP duration_p4_t;

	private FP hitInterval_p4_t;

	private FP hitInterval_p5_t;

	private bool iAddP28;

	private PlayFX playFx;

	private bool canTriP4;

	private bool canTriP5;

	private bool canTriP8;

	private TSVector2 targetPos;

	public override void OnEnable()
	{
		base.OnEnable();
		iAddP28 = false;
		dazhaoDuration = 0;
		dazhaoHitTime = 0;
		mainSkill_index = 0;
		duration_p4_t = 0;
		hitInterval_p4_t = 0;
		hitInterval_p5_t = 0;
		canTriP4 = false;
		canTriP5 = false;
		canTriP8 = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReciveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		hitPreD = hit_freq;
		if (GetPerk(perk_1))
		{
			_actor.buffComponent.AddBuff(buff_p1, _actor);
		}
		if (GetPerk(perk_42))
		{
			hitPreD = hit_freq_p42;
		}
		if (GetPerk(511728))
		{
			iAddP28 = true;
			ILRuntimeAPI.FixAreaEffectMaxCountByHashCode(areaTag_28, 3);
			ILRuntimeAPI.FixAreaEffectMaxCountByHashCode(areaTag_28_24, 3);
		}
		if (!GetPerk(511733))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor.buffComponent?.AddBuff(11733011, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReciveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ClearExtraHit();
		dicArea_p27.Clear();
		if (iAddP28)
		{
			ILRuntimeAPI.FixAreaEffectMaxCountByHashCode(areaTag_28, -3);
			ILRuntimeAPI.FixAreaEffectMaxCountByHashCode(areaTag_28_24, -3);
		}
		if (playFx != null)
		{
			playFx.Stop();
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if ((evt as AdventureElementMarkTriggerEvent).elementType == HotfixEnum.elementType.LE && CheckTalentLevel(4))
		{
			_actor.buffComponent.AddBuff(buff_m4, _actor);
		}
	}

	protected void OnReciveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (!(_actor == null) && !(adventureActorReceiveAttackEvent.to == null) && adventureActorReceiveAttackEvent.hitDamageTag != null && adventureActorReceiveAttackEvent.from == _actor)
		{
			AdventureActor adventureActor = adventureActorReceiveAttackEvent.to as AdventureActor;
			if (CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, attackTag_skill) && GetPerk(511707) && adventureActor != null)
			{
				adventureActor.buffComponent?.AddBuff(11707011, _actor);
			}
			if (GetPerk(511731) && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, attackTag_ultra) && adventureActorReceiveAttackEvent.to is AdventureActor adventureActor2)
			{
				adventureActor2.buffComponent.AddBuff(3011, _actor);
			}
			if (adventureActor != null && CommonUtils.CheckElementMark(CommonDefine.LightMark1, adventureActor) && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, attackTag_ultra) && GetPerk(perk_43))
			{
				_actor.buffComponent?.AddBuff(11743011, _actor);
			}
		}
	}

	protected virtual void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.to == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null || !(adventureActorReceiveDamageBeforeHitEvent.from == _actor))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor;
		if (adventureActor != null && CommonUtils.CheckElementMark(CommonDefine.LightMark1, adventureActor))
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_ultra) && CheckTalentLevel(2))
			{
				AdventureActor.AddFromAttr(onceId_m2, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill) && GetPerk(511705))
			{
				AdventureActor.AddFromAttr(11705001, _actor);
				if (CheckPerkCd(511705L, cd_p5))
				{
					hitInterval_p5_t = delayTrigger;
					canTriP5 = true;
					targetPos = adventureActor.tsTransform.Position;
				}
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill) && GetPerk(511708) && canTriP8)
			{
				AdventureActor.SetFromForceCrit(val: true);
				AdventureActor.AddFromAttr(11708001, _actor);
				_actor.buffComponent.RemoveBuffByBuffId(11708011);
				canTriP8 = false;
				CheckPerkCd(511708L, CommonUtils.GetScriptValue(_actor, 11708011));
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill) && GetPerk(511709))
			{
				_actor.buffComponent.AddBuff(11709011, _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_normal) && GetPerk(511706))
		{
			_actor.buffComponent.AddBuff(11706011, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill) && GetPerk(perk_2) && mainSkill_index > 0)
		{
			int num = (mainSkill_index - 1) % 4;
			num++;
			AdventureActor.AddFromAttr(onceId_02, _actor, num);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill2) && GetPerk(511721))
		{
			AdventureActor.AddFromAttr(11721011, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill2) && GetPerk(511722))
		{
			AdventureActor.AddFromAttr(11722011, _actor);
		}
		if (GetPerk(511725) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill2) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.originEpicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(11725001, _actor);
		}
		if (GetPerk(511726) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill2))
		{
			AdventureActor.AddFromAttr(11726001, _actor);
		}
		if (GetPerk(511727) && dicArea_p27.ContainsKey(adventureActorReceiveDamageBeforeHitEvent.areaEffectId))
		{
			int num2 = TSMath.FloorToInt((_actor.LogicTime - dicArea_p27.get_Item(adventureActorReceiveDamageBeforeHitEvent.areaEffectId)) / interval_p27);
			if (num2 > 0)
			{
				AdventureActor.AddFromAttr(11727001, _actor, num2);
			}
		}
		if (GetPerk(511728) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_skill2))
		{
			AdventureActor.AddFromAttr(11728001, _actor);
		}
		if (GetPerk(511731) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_ultra))
		{
			AdventureActor.AddFromAttr(11731001, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_ultra) && GetPerk(perk_42))
		{
			AdventureActor.AddFromAttr(11742001, _actor);
		}
	}

	protected virtual void OnDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor == null || adventureActorReceiveDamageEvent.to == null || adventureActorReceiveDamageEvent.hitDamageTag == null)
		{
			return;
		}
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor)
			{
				if (CommonUtils.CheckElementMark(CommonDefine.LightMark1, monsterAdventureActor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_skill) && GetPerk(511703))
				{
					ExtraHit(monsterAdventureActor, firstCheck: true);
				}
				if (CheckTalentLevel(3) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_ultra))
				{
					monsterAdventureActor.buffComponent.AddBuff(11796311, _actor);
				}
				bool flag = false;
				if (CommonUtils.CheckTriggerElementMarkCD(_actor, monsterAdventureActor) && CommonUtils.CheckElementMark(CommonDefine.LightMark1, monsterAdventureActor))
				{
					if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_ultra) && GetPerk(511711, cd_p11))
					{
						_actor.buffComponent?.AddBuff(11711011, _actor);
						flag = true;
					}
					else if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, lightBoomHit))
					{
						flag = true;
					}
				}
				if (flag)
				{
					OnLightTrigger(monsterAdventureActor);
				}
			}
			if (adventureActorReceiveDamageEvent.isKill)
			{
				if (GetPerk(511710) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_skill))
				{
					_actor.buffComponent?.AddBuff(11710011, _actor);
				}
				if (CheckTalentLevel(5))
				{
					_actor.buffComponent?.AddBuff(11796511, _actor);
				}
			}
			if (GetPerk(511729) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_skill2) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 11729011))
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
				if (playerAdventureActor != null)
				{
					playerAdventureActor.buffComponent.AddBuff(11729011, _actor);
				}
			}
		}
		else if (adventureActorReceiveDamageEvent.to == _actor && adventureActorReceiveDamageEvent.attackType == DamageType.Melee && GetPerk(511712))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 11712011);
			if (TSRandom.Range(0, 100) <= scriptValue && CheckPerkCd(511712L, cd_p12))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias_perk_12, _actor.tsTransform.Position);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent)
		{
			AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
			if (!(adventureActor == null) && !(adventureActor != _actor))
			{
				_ = adventureActorCastSkillEvent.skillEventInfo.skillSlotType;
				_ = 4;
			}
		}
	}

	private void OnBulletBorn(IEvent _evt)
	{
		if (_evt is AdventureBulletBornEvent adventureBulletBornEvent && adventureBulletBornEvent.owner == _actor)
		{
			_ = adventureBulletBornEvent.tag == bulletQLTag;
		}
	}

	private void OnBulletFinish(IEvent _evt)
	{
		if (_evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner == _actor && adventureBulletFinishEvent.tag == bulletQLTag)
		{
			if (GetPerk(perk_41))
			{
				_actor.buffComponent.RemoveBuffByBuffId(11741011);
			}
			if (CheckTalentLevel(1))
			{
				Singleton<BuffManager>.Instance.RemoveBufftoGroup(11796111);
			}
			if (CheckTalentLevel(5))
			{
				_actor.buffComponent?.RemoveBuffByBuffId(11796511);
			}
		}
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (_actor != null && _actor.Id == adventureAreaEnterExitEvent.owner.Id && adventureAreaEnterExitEvent.triggerCollider?.Entity != null && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && GetPerk(511730) && SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor != null && adventureAreaEnterExitEvent.triggerCollider.Entity.Id == SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.Id && areaEffectEntity.CheckTag(areaTag_28))
		{
			if (adventureAreaEnterExitEvent.iEnter)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(11730011, _actor);
			}
			else
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.RemoveBuffByBuffId(11730011);
			}
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id && dicArea_p27.ContainsKey(adventureAreaEffectFinishEvent.entityID))
		{
			dicArea_p27.Remove(adventureAreaEffectFinishEvent.entityID);
		}
	}

	private void OnMainSkillHit()
	{
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, 8, (List<LogicEntity> result) =>
		{
			int count = result.Count;
			int num = 0;
			if (count >= 0)
			{
				for (int i = 0; i < count; i++)
				{
					MonsterAdventureActor monsterAdventureActor = result.get_Item(i) as MonsterAdventureActor;
					if (monsterAdventureActor != null)
					{
						ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, damageId_p4, null, fxAlias_p4, attackFxPlayOnTarget: true);
						num++;
					}
					if (num >= 3)
					{
						break;
					}
				}
			}
		}, isConfront: true);
	}

	private void OnUltraSkillHit()
	{
		if (_featureData_1 == null)
		{
			_featureData_1 = new HitBox.HitBoxFeatureData();
		}
		_featureData_1.StiffDuration = stiffDuration_1;
		_featureData_1.hitStrenth = hitStrenth_1;
		if (_areaHitConfig_1 == null)
		{
			_areaHitConfig_1 = new CommomAreaHitConfig();
		}
		_areaHitConfig_1.position = _actor.tsTransform.Position;
		_areaHitConfig_1.hitDamageId = 117400001;
		_areaHitConfig_1.hitFlags = HitBox.FeatureFlag.Stiff;
		_areaHitConfig_1.hitFeatureData = _featureData_1;
		_areaHitConfig_1.hittedEffectAlias = "fx_11701_hit_skill0";
		_areaHitConfig_1.damageImmuneDuration = -1;
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, hitRadius_1, (List<LogicEntity> result) =>
		{
			int count = result.Count;
			if (count >= 0)
			{
				List<LogicEntity> list = new List<LogicEntity>();
				for (int i = 0; i < count; i++)
				{
					if (result.get_Item(i) is MonsterAdventureActor)
					{
						list.Add(result.get_Item(i));
					}
					if (list.Count >= hit_num)
					{
						break;
					}
				}
				if (list.Count > 0)
				{
					ILRuntimeAPI.HitActors(_actor, list, _areaHitConfig_1);
				}
			}
		}, isConfront: true);
	}

	private void OnShootBullet()
	{
		ILRuntimeAPI.Shoot("Bullet_11701_Main_Skill_Thunder_P05_AOE", _actor, default, _actor.tsTransform.Position, 1, targetPos, null, AimType.Position);
	}

	private void ExtraHit(LogicEntity target, bool firstCheck = false)
	{
		if (_linkTimes >= 5)
		{
			ClearExtraHit();
			return;
		}
		_ridList.Add(target);
		ILRuntimeAPI.SearchByRange(target as AdventureActor, _linkCheckRange_normal, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int num = result.Count - 1; num >= 0; num--)
				{
					if (_ridList.Contains(result.get_Item(num)) || result.get_Item(num) is PlayerAdventureActor)
					{
						result.RemoveAt(num);
					}
				}
			}
			if (result.Count == 0)
			{
				if (firstCheck)
				{
					_waitForDoubleHitCoroutine = _actor.StartLogicCoroutine(WaitForDoubleHit());
				}
				else
				{
					ClearExtraHit();
				}
			}
			else
			{
				LogicEntity logicEntity = result.get_Item(0);
				AdventureActor actor = _actor;
				AdventureActor target2 = logicEntity as AdventureActor;
				GameObject gameObject = target.gameObject;
				ILRuntimeAPI.HitActor(actor, target2, 117503001, null, "fx_11701_bullet_atk_1", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, default, HitBox.HurtAnimType.Small, 0, gameObject);
				_linkTimes++;
				_waitForLinkHitCoroutine = _actor.StartLogicCoroutine(WaitForLinkHit(logicEntity));
			}
		});
	}

	private IEnumerator WaitForDoubleHit()
	{
		AdventureActor target = _actor.aimLockedTarget as AdventureActor;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_doubleHitInterval));
		if (target != null && target.actorHealthInfo.isAlive)
		{
			ILRuntimeAPI.HitActor(_actor, target, 117503002, null, "fx_11701_hit_atk_1", attackFxPlayOnTarget: true, HitBox.FeatureFlag.None, null, -1);
		}
		ClearExtraHit();
	}

	private IEnumerator WaitForLinkHit(LogicEntity target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_linkHitInterval));
		ExtraHit(target);
	}

	private void ClearExtraHit()
	{
		if (_waitForDoubleHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForDoubleHitCoroutine);
			_waitForDoubleHitCoroutine = null;
		}
		if (_waitForLinkHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForLinkHitCoroutine);
			_waitForLinkHitCoroutine = null;
		}
		_ridList.Clear();
		_linkTimes = 0;
	}

	private void OnLightTrigger(AdventureActor _monster)
	{
		if (GetPerk(511713))
		{
			_actor.buffComponent.AddBuff(11713011, _actor);
		}
		_monster.buffComponent.RemoveBuffByTag(CommonDefine.LightMark1);
		if (ILRuntimeAPI.PlayAreaEffect(_actor, lightAreaEffect, _monster.tsTransform.Position) > 0)
		{
			CommonUtils.TriggerElementMarkEvent(CommonDefine.LightMark1, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1, _actor, _monster, "LightMark_Trigger_Effect_02");
		}
	}

	public void OnUpdate()
	{
		dazhaoDuration -= _actor.LogicDeltaTime;
		dazhaoHitTime += _actor.LogicDeltaTime;
		duration_p4_t -= _actor.LogicDeltaTime;
		hitInterval_p4_t += _actor.LogicDeltaTime;
		hitInterval_p5_t -= _actor.LogicDeltaTime;
		if (_actor.logicVariable.GetLogicTagToggle("117DazhaoKaishi"))
		{
			dazhaoHitTime = hitPreD;
			dazhaoDuration = hit_Duration;
			_actor.logicVariable.ToggleLogicTag("117DazhaoKaishi", value: false);
		}
		if (dazhaoDuration > 0 && dazhaoHitTime >= hitPreD)
		{
			dazhaoHitTime = 0;
			OnUltraSkillHit();
		}
		if (_actor.logicVariable.GetLogicTagToggle("117p4SkillTrigger"))
		{
			_actor.PlayFX("fx_11701_loop_perk9_Current");
			if (playFx == null)
			{
				playFx = new PlayFX();
			}
			else
			{
				playFx.Stop();
			}
			playFx.Play(_actor, null, "fx_11701_loop_perk9_Current", 0, _actor.tsTransform.Position, TSVector2.zero);
			canTriP4 = true;
			duration_p4_t = duration_p4;
			_actor.logicVariable.ToggleLogicTag("117p4SkillTrigger", value: false);
		}
		if (duration_p4_t > 0)
		{
			if (hitInterval_p4_t >= hitInterval_p4)
			{
				hitInterval_p4_t = 0;
				OnMainSkillHit();
			}
		}
		else if (canTriP4)
		{
			canTriP4 = false;
			playFx.Stop();
		}
		if (canTriP5 && hitInterval_p5_t <= 0)
		{
			canTriP5 = false;
			OnShootBullet();
		}
		if (!canTriP8 && GetPerk(511708) && CheckPerkCd(511708L, CommonUtils.GetScriptValue(_actor, 11708011)))
		{
			_actor.buffComponent.AddBuff(11708011, _actor);
			canTriP8 = true;
		}
	}
}
