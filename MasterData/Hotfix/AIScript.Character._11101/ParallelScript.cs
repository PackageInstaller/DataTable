using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11101;

public class ParallelScript : ParallelBase
{
	public int buffA = 4011;

	public int buffB = 4100;

	public int buffB_Ulta = 4100;

	public int buffBTag = CommonHelper.StringToHash("Frozen");

	public int hitTag_normal_3 = CommonHelper.StringToHash("111_Attack_H2");

	public int hitTag_ice = CommonHelper.StringToHash("111_AddWaterTag");

	public int hitTag_Normal = CommonHelper.StringToHash("Normal");

	public int hitTag_Skill = CommonHelper.StringToHash("Skill");

	public int hitTag_Ultra = CommonHelper.StringToHash("Ultra");

	public int hitTag_S2P5 = CommonHelper.StringToHash("S2_P05");

	public FP InvincibleTune = 0;

	private const string tipsKey_TriggerMark = "WaterMark_Trigger_Effect_05";

	protected static readonly int buffTag_Cold = CommonHelper.StringToHash("Cold");

	private static readonly int damageTag_TriggerWaterCorrosion = CommonHelper.StringToHash("WaterTagTrigger");

	private const string areaEffectKey_TriggerWaterCorrosion = "AreaEffect_11101_WaterTag1_Boom";

	protected const int maxCount_ColdBuff = 3;

	private const int buffId_Cold = 4021;

	private const int buffId_Freezing = 4100;

	private const int perkId_10 = 511110;

	private const int parameterId_10 = 11151011;

	private int buffId_10 = 11151011;

	private const int perkId_1 = 511141;

	private FP interval_1 = 1;

	private string areaEffect_1 = "AreaEffect_11101_Ultra_P41_IceFall";

	private const int perkId_2 = 511142;

	private int maxCount_2 = 10;

	private int once_2 = 11154201;

	private int buffId_F1 = 11196111;

	private int once_F2 = 11196211;

	private int buffId_F3 = 11196311;

	private int paramId_F3_prob = 11196311;

	private int buffId_F4 = 11196411;

	private int once_F5 = 11196511;

	public PlayerSkillCd skillMgr;

	private CoroutineNode corTimer;

	private CoroutineNode corArea;

	private AreaEffectEntity areaEntity_A;

	private AreaEffectEntity areaEntity_B;

	private AreaEffectEntity areaEntity_C;

	private FP accTime_A;

	private FP accTime_B;

	private FP accTime_C;

	private List<LogicEntity> targetList = new List<LogicEntity>();

	private static readonly int tag = CommonHelper.StringToHash("boom");

	public static readonly int areaTag_A = CommonHelper.StringToHash("Ultra_Area_A");

	public static readonly int areaTag_B = CommonHelper.StringToHash("Ultra_Area_B");

	public static readonly int areaTag_C = CommonHelper.StringToHash("Ultra_Area_C");

	private int curCount_2;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnMonsterKilled);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		areaEntity_A = null;
		areaEntity_B = null;
		areaEntity_C = null;
		accTime_A = 0;
		accTime_B = 0;
		accTime_C = 0;
		curCount_2 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnMonsterKilled);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StopCoroutine(ref corArea);
		StopCoroutine(ref corTimer);
		perkCd.Clear();
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPrefectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveAttackEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && monsterAdventureActor != null)
		{
			OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
		}
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnFinishReload(IEvent evt)
	{
		AdventureActorFinishReload adventureActorFinishReload = evt as AdventureActorFinishReload;
		if (_actor != null && adventureActorFinishReload.sender as AdventureActor == _actor)
		{
			OnFinishReload(adventureActorFinishReload);
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (_actor != null && adventureAreaEffectBeginEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectBegin(adventureAreaEffectBeginEvent);
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectFinish(adventureAreaEffectFinishEvent);
		}
	}

	private void OnAreaEffectEnd(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
		{
			OnAreaEffectEnd(adventureAreaEffectFinishEvent);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnMonsterKilled(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorDiedEvent.actor as MonsterAdventureActor;
		if (adventureActorDiedEvent.killer == _actor && monsterAdventureActor != null)
		{
			OnMonsterKilled(adventureActorDiedEvent, monsterAdventureActor);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent evt2 = evt as AdventureElementMarkTriggerEvent;
		OnElementMarkTrigger(evt2);
	}

	public virtual void OnPrefectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.EnableInvincible();
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.DisableInvincible();
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra) && GetPerkLv(511142, out var _) && areaEntity_A != null)
		{
			int count = Mathf.Min(maxCount_2, curCount_2);
			AdventureActor.AddFromAttr(once_2, _actor, count);
		}
		if (CheckTalentLevel(2) && CommonUtils.CheckElementMark(CommonDefine.WaterMark1, monster))
		{
			AdventureActor.AddFromAttr(once_F2, _actor);
		}
		if (CheckTalentLevel(5) && !monster.IsBossMonster())
		{
			AdventureActor.AddFromAttr(once_F5, _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_ice) && !monster.buffComponent.CheckBuffByBuffTag(buffBTag))
		{
			monster.buffComponent.AddBuff(buffA, _actor);
		}
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (GetPerkLv(511142, out var _) && evt.isKill)
		{
			curCount_2++;
		}
		if (CheckTalentLevel(3) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_F3_prob);
			if (TSRandom.Range(0, 100) < scriptValue)
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F3, _actor);
			}
		}
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	public virtual void OnMonsterKilled(AdventureActorDiedEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(evt.entityID);
		if (!(areaEffect != null))
		{
			return;
		}
		if (areaEffect.CheckTag(areaTag_A))
		{
			areaEntity_A = areaEffect;
			accTime_A = 0;
			if (GetPerkLv(511141, out var _))
			{
				targetList.Clear();
				StartCoroutine(ref corArea, DoAreaLogic(areaEffect_1, areaEntity_A.hitBoxRadius));
			}
		}
		else if (areaEffect.CheckTag(areaTag_B))
		{
			areaEntity_B = areaEffect;
			accTime_B = 0;
		}
		else if (areaEffect.CheckTag(areaTag_C))
		{
			areaEntity_C = areaEffect;
			accTime_C = 0;
		}
		if (CheckTalentLevel(1) && (areaEffect.CheckTag(areaTag_A) || areaEffect.CheckTag(areaTag_B) || areaEffect.CheckTag(areaTag_C)))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_F1, _actor);
		}
	}

	public virtual void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
		if (areaEntity_A != null && evt.entityID == areaEntity_A.Id)
		{
			StopCoroutine(ref corArea);
			areaEntity_A = null;
			foreach (LogicEntity target in targetList)
			{
				(target as AdventureActor).ClearTag(tag);
			}
			curCount_2 = 0;
		}
		if (areaEntity_B != null && evt.entityID == areaEntity_B.Id)
		{
			areaEntity_B = null;
		}
		if (areaEntity_C != null && evt.entityID == areaEntity_C.Id)
		{
			areaEntity_C = null;
		}
		if (CheckTalentLevel(1) && areaEntity_A == null && areaEntity_B == null && areaEntity_C == null)
		{
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buffId_F1);
		}
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		if (CheckTalentLevel(4) && evt.elementType == HotfixEnum.elementType.WE)
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
		}
	}

	private IEnumerator DoAreaLogic(string aoe, FP radius)
	{
		yield return null;
		LogicEntity lastEntity = null;
		List<LogicEntity> list = new List<LogicEntity>();
		while (true)
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, areaEntity_A.tsTransform.Position, radius, isConfront: true, includeSelf: false, list);
			if (list != null && list.Count > 0)
			{
				list.Sort((LogicEntity x, LogicEntity y) => (x as AdventureActor).GetTagCount(tag) - (y as AdventureActor).GetTagCount(tag));
				for (int num = 0; num < list.Count; num++)
				{
					if (list.get_Item(num) != lastEntity)
					{
						lastEntity = list.get_Item(num);
						break;
					}
				}
				(lastEntity as AdventureActor).AddTag(tag);
				targetList.Add(lastEntity);
				ILRuntimeAPI.PlayAreaEffect(_actor, aoe, lastEntity.tsTransform.Position);
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval_1));
		}
	}

	private IEnumerator DoTimer()
	{
		yield return _actor.WaitTime(InvincibleTune);
		_actor.DisableInvincible();
	}

	public virtual bool TriggerMask(MonsterAdventureActor monster, IList<int> hitDamageTag, bool ignoreHitTag = false)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.WaterMark1, monster) && (CommonUtils.CheckHitByTag(hitDamageTag, damageTag_TriggerWaterCorrosion) | ignoreHitTag) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.WaterMark1);
			monster.buffComponent.AddBuff(4021, _actor);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11101_WaterTag1_Boom", monster.tsTransform.Position);
			if (monster.buffComponent.GetBuffNum(0, 0, buffTag_Cold) >= 3)
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_Cold);
				monster.buffComponent.AddBuff(4100, _actor);
				if (GetPerkLv(511110, out var _))
				{
					skillMgr.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 11151011), ActionKey.B);
					_actor.buffComponent.AddBuff(buffId_10, _actor);
				}
			}
			CommonUtils.TriggerElementMarkEvent(CommonDefine.WaterMark1, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType1, _actor, monster, "WaterMark_Trigger_Effect_05");
			return true;
		}
		return false;
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
