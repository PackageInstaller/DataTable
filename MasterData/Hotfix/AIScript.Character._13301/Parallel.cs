using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._13301;

public class Parallel : ParallelBase
{
	private static readonly int windBoomHit = CommonHelper.StringToHash("133WindTagBoom");

	private readonly string windAreaEffect = "AreaEffect_133_WindMark1_Bloom";

	private const string tipsKey_TriggerMark = "WindMark_Trigger_Effect_01";

	private readonly int ultraDamageTag = CommonHelper.StringToHash("133Ultra");

	private readonly string ult_Bullet_Tag = "133Ultra_Tornado";

	private readonly int atk_Tag = CommonHelper.StringToHash("133Hit");

	private readonly int atk_skillMainTag = CommonHelper.StringToHash("133_B1");

	private readonly int atk_skillSupportTag = CommonHelper.StringToHash("133Petal");

	private readonly int atk_normalTag = CommonHelper.StringToHash("133_Atk");

	public static readonly int flowerEffectTag = CommonHelper.StringToHash("133petalRegion");

	private readonly int flowerEffectTag_F = CommonHelper.StringToHash("133petalRegion_child_base");

	private readonly int flowerEffectTag_C = CommonHelper.StringToHash("133petalRegion_child_23");

	private readonly string flowerBulletTag = "133_BulletPetal";

	private static readonly int windAreaTag = CommonHelper.StringToHash("133_WindTag");

	private static readonly int flowerAreaHitTag = CommonHelper.StringToHash("133_B2_PetalRegion");

	private readonly int atk_Sup32 = CommonHelper.StringToHash("133_Sup32");

	private readonly int atkSkill_Tag = CommonHelper.StringToHash("133_TalentSkill");

	private readonly int buff_m1 = 13396111;

	private readonly int scriptPamCount_m2 = 13396212;

	private readonly int scriptPamCd_m2 = 13396211;

	private readonly int buff_m2 = 13396211;

	private readonly int buff_m3 = 13396311;

	private int buff_m4 = 13396411;

	private int onceId_m5 = 13396511;

	private const int perk_31 = 513331;

	private const int buffId_31 = 2011;

	public const int perk_41 = 513341;

	private const int buffId_41 = 13354111;

	public const int perk_42 = 513342;

	public const int buffId_42 = 13354211;

	public const int scriptPam_42 = 13354211;

	private const int perk_43 = 513343;

	private const int buffId_43 = 13354311;

	public const int perk_01 = 513301;

	public const int buff_01 = 13350111;

	public const int perk_02 = 513302;

	public const int addPercent = 5;

	public const int perk_03 = 513303;

	public const int perk_04 = 513304;

	public const string area_04 = "AreaEffect_13301_B1P4_Wind";

	public const string area_04_2 = "AreaEffect_13301_B1P4_Wind2";

	private const int perk_05 = 513305;

	private const int buffId_05 = 13350511;

	private const int onceId_05 = 13350501;

	public const int perk_06 = 513306;

	private readonly FP cd_06 = 1;

	public const int buff_06 = 13350611;

	private const int hitId_06 = 133506001;

	private const string hitFx_06 = "FX/ActorCommon/fx_common_hit_wind_strike";

	private const string selfFx_06 = "Actor/Character/13301/FX/fx_13301_base_hit_Wind_Perk06";

	private const int perk_07 = 513307;

	private const int onceId_07 = 13350701;

	private readonly FP cd_07 = 1;

	public const int perk_08 = 513308;

	public const int buffId_08 = 13350811;

	private const int perk_09 = 513309;

	private const int num_09 = 2;

	private const int onceId_09 = 13350901;

	public const int perk_10 = 513310;

	public const int buffId_10 = 13351011;

	private const int perk_11 = 513311;

	private const int buffId_11 = 13351111;

	private const int perk_12 = 513312;

	private const int buffId_12 = 13351211;

	private const int parameterId_12 = 13351211;

	public const int perk_13 = 513313;

	public const int buffId_13 = 13351311;

	private const int num_13 = 1;

	public const int perk_21 = 513321;

	private readonly FP cd_21 = 2.5;

	public const int num_21 = 3;

	private const string powerEntity_21 = "13301_B2_flower";

	private readonly TSVector leftOffset = new TSVector(1.2, 2, 0);

	private readonly TSVector rightOffset = new TSVector(-1.2, 2, 0);

	private int totleCount;

	private const int perk_22 = 513322;

	private const int onceId_22 = 13352211;

	public static readonly int perk_23 = 513323;

	private readonly string areaEffect_23 = "AreaEffect_13301_PetalRegion_Perk23";

	public static readonly string time_event = "133_PetalRegion_Extra";

	public static readonly FP time_23 = 9;

	private const int cd_23 = 1;

	private static readonly int perk_24 = 513324;

	private const int cd_24 = 1;

	private const string area_24 = "AreaEffect_13301_B2P24_PetalRegionAtk";

	private const string area_24_1 = "AreaEffect_13301_B2P23P24_PetalRegionAtk";

	private readonly int perk_25 = 513325;

	private const int buffId_25 = 13352511;

	private const int perk_26 = 513326;

	private const int onceId_26 = 13352601;

	private readonly FP per_26 = 10;

	private readonly int perk_27 = 513327;

	private const int onceId_27 = 13352701;

	private const int buffId_27 = 13352711;

	private readonly int perk_28 = 513328;

	private const int onceId_28_base = 13352801;

	private readonly int num_28 = 3;

	private const int onceId_28_plus = 13352802;

	protected readonly int perk_29 = 513329;

	private const int buffId_29 = 13352911;

	protected readonly int perk_30 = 513330;

	private const string area_30 = "AreaEffect_13301_B2P30_Boom";

	private const string area_30_23 = "AreaEffect_13301_B2P30P23_Boom";

	private const int onceId_30 = 13353001;

	protected readonly int perk_32 = 513332;

	private const int OnceId_32 = 13353201;

	protected readonly int perk_33 = 513333;

	private const int buffId_33 = 13353311;

	public static FP normalComboTime;

	public static FP perk2_Time;

	public static bool iMainSkill;

	public static int iSupoortSkillNum;

	private FP time_21;

	private List<long> list_p24 = new List<long>(10);

	private List<AreaEffectEntity> flowerAreas = new List<AreaEffectEntity>(4);

	private PlayFX playFX;

	public static FP time_To23;

	public static int ultWindCount;

	private FP cd_m2;

	public override void OnEnable()
	{
		base.OnEnable();
		totleCount = 0;
		normalComboTime = 0;
		ultWindCount = 0;
		time_To23 = 0;
		iMainSkill = false;
		iSupoortSkillNum = 0;
		cd_m2 = 0;
		time_21 = 0;
		list_p24.Clear();
		flowerAreas.Clear();
		if (GetPerk(513311))
		{
			_actor.buffComponent.AddBuff(13351111, _actor);
		}
		if (GetPerk(513313))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		if (GetPerk(perk_33))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && (playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard || playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance))
				{
					playerAdventureActor.buffComponent?.AddBuff(13353311, _actor);
				}
			}
		}
		if (GetPerk(513341))
		{
			_actor.buffComponent.AddBuff(13354111, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_FINISH", OnWeaponFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		flowerAreas.Clear();
		playFX?.Stop();
		playFX?.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_FINISH", OnWeaponFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void OnActorDied(IEvent evt)
	{
		if ((evt as AdventureActorDiedEvent).actor is MonsterAdventureActor monsterAdventureActor && list_p24.Contains(monsterAdventureActor.Id))
		{
			list_p24.Remove(monsterAdventureActor.Id);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent obj = evt as AdventureElementMarkTriggerEvent;
		AdventureActor triggerActor = obj.triggerActor;
		if (obj.elementType == HotfixEnum.elementType.AE && triggerActor != null && CheckTalentLevel(4))
		{
			_actor.buffComponent.AddBuff(buff_m4, _actor);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorCastSkillEvent.sender as PlayerAdventureActor;
		if (playerAdventureActor == null || playerAdventureActor.Id != _actor.Id || adventureActorCastSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B || (object)playerAdventureActor == null)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor2 = playerAdventureActor;
		if (CheckTalentLevel(2) && _actor.LogicTime > cd_m2)
		{
			string localData = playerAdventureActor2.GetLocalData("skillHit_m2");
			if (string.IsNullOrEmpty(localData))
			{
				playerAdventureActor2.SetLocalData("skillHit_m2", 0.ToString());
			}
			else if (CommonHelper.ParseStringParamToInt(localData) >= (int)(long)CommonUtils.GetScriptValue(_actor, scriptPamCount_m2))
			{
				cd_m2 = _actor.LogicTime + CommonUtils.GetScriptValue(_actor, scriptPamCd_m2);
				playerAdventureActor2.SetLocalData("skillHit_m2", 0.ToString());
				playerAdventureActor2.buffComponent?.AddBuff(buff_m2, playerAdventureActor2);
			}
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.to == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null || adventureActorReceiveDamageBeforeHitEvent.from == null)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_Sup32) && GetPerk(perk_32) && totleCount > 0)
		{
			AdventureActor.AddFromAttr(13353201, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, flowerAreaHitTag))
		{
			if (GetPerk(perk_28))
			{
				AdventureActor.AddFromAttr(13352801, _actor);
				if (list_p24.Count >= num_28)
				{
					AdventureActor.AddFromAttr(13352802, _actor);
				}
			}
			if (GetPerk(perk_30))
			{
				AdventureActor.AddFromAttr(13353001, _actor);
			}
		}
		if (CheckTalentLevel(5) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_Tag) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(onceId_m5, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_skillMainTag))
		{
			if (GetPerk(513307))
			{
				int num = (int)(long)((_actor.LogicTime - perk2_Time) / cd_07);
				num = ((num < 1) ? 1 : num);
				AdventureActor.AddFromAttr(13350701, _actor, num);
			}
			if (GetPerk(513305))
			{
				AdventureActor.AddFromAttr(13350501, _actor);
				monsterAdventureActor.buffComponent.AddBuff(13350511, _actor);
			}
			if (GetPerk(513309) && adventureActorReceiveDamageBeforeHitEvent.onceAttackTargetCount >= 2)
			{
				AdventureActor.AddFromAttr(13350901, _actor);
			}
		}
		else if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_skillSupportTag))
		{
			if (GetPerk(513322))
			{
				AdventureActor.AddFromAttr(13352211, _actor);
			}
			if (GetPerk(513326))
			{
				AdventureActor.AddFromAttr(13352601, _actor);
			}
			if (GetPerk(perk_27))
			{
				AdventureActor.AddFromAttr(13352701, _actor);
			}
		}
		if (GetPerk(513312) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_normalTag) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 13351211))
		{
			monsterAdventureActor.buffComponent.AddBuff(13351211, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_skillSupportTag) && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && GetPerk(513326) && monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && TSRandom.Range(0, 100) < per_26)
		{
			monsterAdventureActor.Kill(_actor);
		}
		if (adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor2 && adventureActorReceiveDamageEvent.from is AdventureActor adventureActor && adventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			if (adventureActor.Id != _actor.Id && list_p24.Contains(monsterAdventureActor2.Id) && flowerAreas.Count > 0 && GetPerk(perk_24, 1))
			{
				for (int i = 0; i < flowerAreas.Count; i++)
				{
					string fxAlias = "AreaEffect_13301_B2P24_PetalRegionAtk";
					if (flowerAreas.get_Item(i).CheckChildTag(flowerEffectTag_C))
					{
						fxAlias = "AreaEffect_13301_B2P23P24_PetalRegionAtk";
					}
					ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, flowerAreas.get_Item(i).tsTransform.Position);
				}
			}
			if (time_To23 > 0 && adventureActor.Id != _actor.Id && !list_p24.Contains(monsterAdventureActor2.Id) && GetPerk(perk_23, 1))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_23, monsterAdventureActor2.tsTransform.Position);
			}
		}
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor3 && adventureActorReceiveDamageEvent.hitDamageTag != null)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atkSkill_Tag))
			{
				if (CheckTalentLevel(2) && _actor is PlayerAdventureActor playerAdventureActor)
				{
					string localData = playerAdventureActor.GetLocalData("skillHit_m2");
					if (string.IsNullOrEmpty(localData))
					{
						playerAdventureActor.SetLocalData("skillHit_m2", 1.ToString());
					}
					else
					{
						int num = CommonHelper.ParseStringParamToInt(localData);
						playerAdventureActor.SetLocalData("skillHit_m2", (num + 1).ToString());
					}
				}
				if (CheckTalentLevel(3))
				{
					monsterAdventureActor3.buffComponent?.AddBuff(buff_m3, _actor);
				}
			}
			if (GetPerk(perk_25) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_skillSupportTag))
			{
				monsterAdventureActor3.buffComponent.AddBuff(13352511, _actor);
			}
			if (GetPerk(perk_29) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, flowerAreaHitTag))
			{
				monsterAdventureActor3.buffComponent.AddBuff(13352911, _actor);
			}
			if (GetPerk(513331) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, ultraDamageTag))
			{
				monsterAdventureActor3.buffComponent.AddBuff(2011, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, ultraDamageTag) && GetPerk(513343))
			{
				monsterAdventureActor3.buffComponent.AddBuff(13354311, _actor);
			}
			OnTriggerWind(adventureActorReceiveDamageEvent);
		}
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id && adventureActorReceiveDamageEvent.from is MonsterAdventureActor target && iMainSkill && GetPerk(513306) && CheckPerkCd(513306L, cd_06))
		{
			if (playFX == null)
			{
				playFX = new PlayFX();
			}
			playFX.Play(_actor, "Actor/Character/13301/FX/fx_13301_base_hit_Wind_Perk06", 1f, _actor.transform.position, _actor.transform.rotation);
			ILRuntimeAPI.HitActor(_actor, target, 133506001, "FX/ActorCommon/fx_common_hit_wind_strike");
		}
	}

	private void ClearFlowerByChildTag(int tag)
	{
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.areaEffects.FindAll((LogicEntity areaEffect) => ((AreaEffectEntity)areaEffect).CheckChildTag(tag));
		for (int num = 0; num < list.Count; num++)
		{
			AreaEffectEntity areaEffectEntity = list.get_Item(num) as AreaEffectEntity;
			SceneSingleton<AreaEffectManager>.Instance.StopAreaEffect(areaEffectEntity.Id);
		}
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (!(_actor != null) || _actor.Id != adventureAreaEnterExitEvent.owner.Id || !(adventureAreaEnterExitEvent.triggerCollider?.Entity != null) || !(adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity) || !areaEffectEntity.CheckChildTag(flowerEffectTag) || !(adventureAreaEnterExitEvent.triggerCollider.Entity is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (adventureAreaEnterExitEvent.iEnter)
		{
			if (!flowerAreas.Contains(areaEffectEntity))
			{
				flowerAreas.Add(areaEffectEntity);
			}
			list_p24.Add(monsterAdventureActor.Id);
		}
		else
		{
			if (flowerAreas.Contains(areaEffectEntity))
			{
				flowerAreas.Remove(areaEffectEntity);
			}
			list_p24.Remove(adventureAreaEnterExitEvent.triggerCollider.Entity.Id);
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (!(_actor != null) || adventureAreaEffectFinishEvent.owner.Id != _actor.Id || !(adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity))
		{
			return;
		}
		areaEffectEntity.CheckChildTag(flowerEffectTag_F);
		if (areaEffectEntity.CheckChildTag(flowerEffectTag))
		{
			if (flowerAreas.Contains(areaEffectEntity))
			{
				flowerAreas.Remove(areaEffectEntity);
			}
			if (GetPerk(perk_30) && areaEffectEntity.CheckChildTag(flowerEffectTag_F))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13301_B2P30_Boom", areaEffectEntity.tsTransform.Position);
			}
			else if (GetPerk(perk_30) && areaEffectEntity.CheckChildTag(flowerEffectTag_C))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13301_B2P30P23_Boom", areaEffectEntity.tsTransform.Position);
			}
			totleCount--;
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (_actor != null && adventureAreaEffectBeginEvent.owner.Id == _actor.Id && adventureAreaEffectBeginEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckChildTag(flowerEffectTag))
		{
			totleCount++;
		}
	}

	public void OnTriggerWind(AdventureActorReceiveDamageEvent damageEvt)
	{
		if (damageEvt.to is MonsterAdventureActor monsterAdventureActor)
		{
			bool flag = false;
			if (CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, windBoomHit))
			{
				flag = true;
			}
			else if (GetPerk(513311) && CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, ultraDamageTag))
			{
				flag = true;
			}
			if (!CommonUtils.CheckTriggerElementMarkCD(_actor, monsterAdventureActor))
			{
				flag = false;
			}
			if (flag && CommonUtils.CheckElementMark(CommonDefine.Wind, monsterAdventureActor))
			{
				monsterAdventureActor.buffComponent.RemoveBuffByTag(CommonDefine.Wind);
				ILRuntimeAPI.PlayAreaEffect(_actor, windAreaEffect, monsterAdventureActor.tsTransform.Position);
				CommonUtils.TriggerElementMarkEvent(CommonDefine.Wind, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2, _actor, monsterAdventureActor, "WindMark_Trigger_Effect_01");
			}
		}
	}

	private void OnWeaponBorn(IEvent evt)
	{
		AdventureWeaponBornEvent adventureWeaponBornEvent = evt as AdventureWeaponBornEvent;
		if (!(adventureWeaponBornEvent.owner != null) || (adventureWeaponBornEvent.owner.Id != _actor.Id && adventureWeaponBornEvent.owner.Id != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id))
		{
			return;
		}
		if (adventureWeaponBornEvent.sender is AdventureRotateWeapon adventureRotateWeapon)
		{
			if (!string.Equals(adventureRotateWeapon.weaponTag, ult_Bullet_Tag))
			{
				return;
			}
			if (GetPerk(513342))
			{
				adventureRotateWeapon._duration = CommonUtils.GetScriptValue(_actor, 13354211);
			}
			if (CheckTalentLevel(1))
			{
				ultWindCount++;
				if (ultWindCount == 1)
				{
					Singleton<BuffManager>.Instance?.AddBufftoGroup(buff_m1, _actor);
				}
			}
		}
		else if (adventureWeaponBornEvent.sender is AdventureBullet adventureBullet && string.Equals(adventureBullet.bulletTag, flowerBulletTag))
		{
			if (GetPerk(513322) && adventureBullet.TryGetComponent<WeaponFeatureTraceTarget>(out var component))
			{
				component.iActive = true;
			}
			if (GetPerk(perk_27))
			{
				_actor.buffComponent.AddBuff(13352711, _actor);
			}
		}
	}

	private void OnWeaponFinish(IEvent evt)
	{
		AdventureWeaponFinishEvent adventureWeaponFinishEvent = evt as AdventureWeaponFinishEvent;
		if (adventureWeaponFinishEvent.owner != null && (adventureWeaponFinishEvent.owner.Id == _actor.Id || adventureWeaponFinishEvent.owner.Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id) && adventureWeaponFinishEvent.sender is AdventureRotateWeapon adventureRotateWeapon && string.Equals(adventureRotateWeapon.weaponTag, ult_Bullet_Tag))
		{
			ultWindCount--;
			if (ultWindCount == 0)
			{
				Singleton<BuffManager>.Instance?.RemoveBufftoGroup(buff_m1);
			}
		}
	}

	public void OnUpdate()
	{
		if (time_To23 >= 0)
		{
			time_To23 -= _actor.LogicDeltaTime;
			if (time_To23 < 0)
			{
				ClearFlowerByChildTag(flowerEffectTag);
			}
		}
		if (iSupoortSkillNum <= 0)
		{
			return;
		}
		time_21 -= _actor.LogicDeltaTime;
		if (!(time_21 <= 0))
		{
			return;
		}
		time_21 = cd_21;
		GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias("13301_B2_flower");
		if (fXByAlias != null)
		{
			FlowerEntity flowerEntity = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, _actor.transform.rotation) as FlowerEntity;
			if (iSupoortSkillNum % 2 > 0)
			{
				flowerEntity.OnTrigger(leftOffset, _actor);
			}
			else
			{
				flowerEntity.OnTrigger(rightOffset, _actor);
			}
		}
		iSupoortSkillNum--;
	}
}
