#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerFireMark;

	private CommomAreaHitConfig _areaHitConfig_FireMark;

	private HitBox.HitBoxFeatureData _featureData_FireMark;

	protected int _buffId_Ink;

	protected Dictionary<int, int> _buffIdDic_Burn;

	private PlayFX _playFX;

	private HashSet<long> _triggerSet_P41;

	public override void OnEnable()
	{
		base.OnEnable();
		_buffId_Ink = 14191015;
		_buffIdDic_Burn = Config.buffIdDic_Burn;
		if (_damageTag_TriggerFireMark == null)
		{
			_damageTag_TriggerFireMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerFireMark.Clear();
		}
		_damageTag_TriggerFireMark.Add(Config.damageTag_TriggerFireMark);
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		else
		{
			_playFX.Clear();
		}
		_playFX.Play(_actor, null, "fx_14101_loop_idle_tail", default, _actor.tsTransform.Position, default);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config.eventHashCode_UltraSkill_BeginLogic)
		{
			TSVector2 position = _actor.tsTransform.Position;
			if (adventureActorCustomEvent.tsVector2ParamList != null && adventureActorCustomEvent.tsVector2ParamList.Count > 0)
			{
				position = adventureActorCustomEvent.tsVector2ParamList.get_Item(0);
			}
			_actor.StartLogicCoroutine(UltraSkillLogic(position));
		}
	}

	private IEnumerator UltraSkillLogic(TSVector2 position)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config.delayTime_UltraSkill_GenerateAreaEffect));
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Ultra_T2", position);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514142, out var _))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Ultra_P42_FireWind", position);
		}
		OnUltraSkillLogicFinish();
	}

	protected virtual void OnUltraSkillLogicFinish()
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageBeforeHitEvent))
		{
			return;
		}
		PlayerAdventureActor summoner = null;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor) && !adventureActorReceiveDamageBeforeHitEvent.from.IsPlayerMinion(out summoner))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && CommonUtils.CheckElementMark(CommonDefine.Fire, to))
		{
			AdventureActor.AddFromAttr(14196111, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (adventureActorReceiveDamageBeforeHitEvent.from == _actor || summoner == _actor) && (to.IsBossMonster() || to.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(14196511, _actor);
		}
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_D2))
			{
				AdventureActor.AddFromAttr(14196211, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor && adventureActorReceiveDamageEvent.from == _actor)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514141, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P41) && adventureActorReceiveDamageEvent.isCrit)
			{
				if (_triggerSet_P41 == null)
				{
					_triggerSet_P41 = new HashSet<long>();
				}
				if (_triggerSet_P41.Add(adventureActorReceiveDamageEvent.uniqueAttackId))
				{
					_actor.buffComponent.AddBuff(14141011, _actor);
				}
			}
			CheckAddInkAndTriggerBurn(to, adventureActorReceiveDamageEvent.hitDamageTag);
			if (CheckCanTriggerFireMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerFireMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		else if (adventureActorReceiveDamageEvent.from.IsPlayerMinion(out summoner) && summoner == _actor)
		{
			OnSelfSummonedDamaged(adventureActorReceiveDamageEvent);
			CheckAddInkAndTriggerBurn(to, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnSelfSummonedDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void CheckAddInkAndTriggerBurn(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null) && hitDamageTag != null && !monster.buffComponent.CheckBuffByBuffTag(Config.buffTag_Burn))
		{
			if (CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_AddInk))
			{
				monster.buffComponent.AddBuff(_buffId_Ink, _actor);
			}
			CheckTriggerBurn(monster, hitDamageTag);
		}
	}

	private void CheckTriggerBurn(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null || !monster.buffComponent.CheckBuffByBuffTag(Config.buffTag_Ink))
		{
			return;
		}
		for (int i = 0; i < hitDamageTag.Count; i++)
		{
			if (CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerBurn))
			{
				TriggerBurn(monster);
				OnTriggerBurn(monster);
				break;
			}
		}
	}

	protected virtual void TriggerBurn(MonsterAdventureActor monster)
	{
		if (!(monster == null))
		{
			int buffNum = monster.buffComponent.GetBuffNum(0, 0, Config.buffTag_Ink);
			if (_buffIdDic_Burn.TryGetValue(buffNum, out var value))
			{
				monster.buffComponent.AddBuff(value, _actor);
			}
			else
			{
				NovaLogger.Error("未配置对应墨汁层数的燃烧Buff");
			}
			monster.buffComponent.RemoveBuffByTag(Config.buffTag_Ink);
		}
	}

	protected virtual void OnTriggerBurn(MonsterAdventureActor monster)
	{
	}

	private bool CheckCanTriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (_damageTag_TriggerFireMark == null || _damageTag_TriggerFireMark.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Fire, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerFireMark.Count; i++)
			{
				int hitTag = _damageTag_TriggerFireMark.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void TriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null))
		{
			monster.buffComponent?.RemoveBuffByTag(CommonDefine.Fire);
			if (_featureData_FireMark == null)
			{
				_featureData_FireMark = new HitBox.HitBoxFeatureData
				{
					StiffDuration = Config.stiffDuration_FireMark,
					hitStrenth = Config.hitStrenth_FireMark
				};
			}
			if (_areaHitConfig_FireMark == null)
			{
				_areaHitConfig_FireMark = new CommomAreaHitConfig
				{
					fxAlias = "fx_14101_base_FireTag_Trigger",
					hittedEffectAlias = "fx_14101_hit_Fire",
					hitDamageId = 141000001,
					hitFlags = HitBox.FeatureFlag.Stiff,
					hitFeatureData = _featureData_FireMark,
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig_FireMark.position = monster.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig_FireMark, Config.hitRadius_FireMark, 0);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Fire, HotfixEnum.AdventureActorElementTriggerType.FireElementTriggerType2, _actor, monster, "FireMark_Trigger_Effect_01");
			OnTriggerFireMark(monster, hitDamageTag);
		}
	}

	protected virtual void OnTriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent && adventureAreaEffectFinishEvent.owner == _actor && (adventureAreaEffectFinishEvent.sender as AreaEffectEntity).CheckTag(Config.areaTag_UltraSkill) && CommonUtils.HavePersonalPerk(_actor.dataID, 514143, out var _))
		{
			_actor.StartLogicCoroutine(PerkLogic_P43(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P43()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config.delay_GenerateAreaEffect_P43), runImmediately: true);
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Ultra_P43_DragonBreathe", activedPlayerActor.tsTransform.Position, activedPlayerActor.tsTransform.Rotation);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent) || !ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4) || adventureElementMarkTriggerEvent.elementType != HotfixEnum.elementType.FE)
		{
			return;
		}
		foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			if (item == _actor || (item.IsPlayerMinion(out var summoner) && summoner == _actor))
			{
				((AdventureActor)item).buffComponent.AddBuff(14196411, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_playFX?.Stop();
		_playFX?.Clear();
		_triggerSet_P41?.Clear();
	}
}
