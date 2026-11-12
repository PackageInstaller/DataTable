using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class ParallelScript_Support : ParallelScript
{
	private static readonly int damageTag_Skill = CommonHelper.StringToHash("132_Support_Hurt");

	private const int addStarBuffCount = 2;

	private const string areaEffectKey_Explosion = "AreaEffect_132_Support_StarBurst";

	private static readonly int areaEffectTag_Explosion = CommonHelper.StringToHash("132_Support_StarBurst");

	private static readonly int damageTag_Explosion = CommonHelper.StringToHash("132_Support_StarBoom");

	private const int perkId_21 = 513221;

	private const int addStarBuffCount_P21 = 4;

	private static readonly int damageTag_P21 = CommonHelper.StringToHash("132_Support_SectorStar");

	private const int additionalAttrId_P21 = 13221011;

	private const int perkId_22 = 513222;

	private const string areaEffectKey_Explosion_P22 = "AreaEffect_132_Support_StarBurst_P22_Big";

	private const int additionalAttrId_P22 = 13222011;

	private const int perkId_23 = 513223;

	private const string bulletTag_P23 = "132_Bullet_P23";

	private const int shieldId_23 = 13223011;

	private const int perkId_24 = 513224;

	private const string dropKey_P24 = "Item_132_Support_P24_Star";

	private static readonly FP dropPositionY_P24 = 1;

	private const string dropTag_P24 = "132_Item_P24";

	private const int perkId_25 = 513225;

	private const int additionalAttrId_P25 = 13225001;

	private const int perkId_26 = 513226;

	private const int hitDamageId_P26 = 132526001;

	private static readonly FP triggerCD_P26 = 1;

	private const int perkId_27 = 513227;

	private const int additionalAttrId_P27 = 13227001;

	private const int parameterId_P27 = 13227011;

	private const int perkId_28 = 513228;

	private static readonly int damageTag_P28 = CommonHelper.StringToHash("132_P28");

	private const int perkId_29 = 513229;

	private static readonly int damageTag_P29 = CommonHelper.StringToHash("132_Support_Hurt");

	private const int triggerTimes_P29 = 3;

	private const int parameterId_P29 = 13229011;

	private const int buffId_P29 = 13229011;

	private const int perkId_30 = 513230;

	private const int buffId_P30 = 13230011;

	private const int perkId_31 = 513231;

	private const int perkId_33 = 513233;

	private const int buffId_P33 = 13233011;

	private const int BuffMaxCount_ForMonster = 4;

	private const int BuffMaxCount_ForPlayer = 4;

	private Dictionary<long, StarBuffController> _starBuffControllerDic;

	private HashSet<long> _inTriggerSet;

	private FP _triggerTime_P26;

	private Queue<StarBuffController> _starBuffControllerPool;

	public override void OnEnable()
	{
		base.OnEnable();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513233, out var _))
		{
			int num = 0;
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.LE)
				{
					num++;
				}
			}
			foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				for (int i = 0; i < num; i++)
				{
					actorL2.buffComponent?.AddBuff(13233011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	public void OnUpdate()
	{
		if (_starBuffControllerDic == null || _starBuffControllerDic.Count <= 0)
		{
			return;
		}
		foreach (StarBuffController value in _starBuffControllerDic.Values)
		{
			value?.Update(_actor.LogicDeltaTime);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513229, out var perkLevel) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, damageTag_P29))
		{
			TryTriggerPerkLogic_P29();
		}
		if (CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, ParallelScript.damageTag_UltraSkill) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513231, out perkLevel))
		{
			monsterAdventureActor.buffComponent?.AddBuff(3011, _actor);
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnSelfBeforeHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513221, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_P21))
		{
			AdventureActor.AddFromAttr(13221011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513225, out perkLevel))
		{
			int num = 0;
			if (_starBuffControllerDic != null && _starBuffControllerDic.TryGetValue(monsterAdventureActor.Id, out var value))
			{
				num = value.GetBuffCount();
			}
			if (_inTriggerSet != null && _inTriggerSet.Contains(monsterAdventureActor.Id))
			{
				num++;
			}
			if (num > 0)
			{
				AdventureActor.AddFromAttr(13225001, _actor, num);
			}
		}
		if (!CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Explosion))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513222, out perkLevel))
		{
			AdventureActor.AddFromAttr(13222011, _actor);
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513227, out perkLevel))
		{
			return;
		}
		int num2 = 0;
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 13227011);
		if (_starBuffControllerDic != null && _starBuffControllerDic.Count > 0)
		{
			foreach (StarBuffController value2 in _starBuffControllerDic.Values)
			{
				if (num2 < scriptValue)
				{
					if (value2.GetBuffCount() > 0 || _inTriggerSet.Contains(value2.GetTargetId()))
					{
						num2++;
					}
					continue;
				}
				break;
			}
		}
		if (num2 > 0)
		{
			AdventureActor.AddFromAttr(13227001, _actor, num2);
		}
	}

	protected override void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513226, out var _) && damageEvent.from == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && (_triggerTime_P26 <= 0 || _actor.LogicTime - _triggerTime_P26 > triggerCD_P26) && HaveOrTriggeringBuff(monsterAdventureActor.Id))
		{
			ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 132526001, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			_triggerTime_P26 = _actor.LogicTime;
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor target = damageEvent.to as MonsterAdventureActor;
		int perkLevel;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, damageTag_Skill))
		{
			int buffCount = 2;
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513221, out perkLevel))
			{
				buffCount = 4;
			}
			AddBuff(target, buffCount);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513228, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, damageTag_P28))
		{
			AddBuff(target, 1);
		}
	}

	private void AddBuff(AdventureActor target, int buffCount)
	{
		if (_starBuffControllerDic == null)
		{
			_starBuffControllerDic = new Dictionary<long, StarBuffController>(10);
		}
		if (!_starBuffControllerDic.ContainsKey(target.Id))
		{
			int maxBuffCount = ((target is PlayerAdventureActor) ? 4 : 4);
			_starBuffControllerDic.Add(target.Id, GenerateStarBuffController(target, maxBuffCount));
		}
		_starBuffControllerDic.get_Item(target.Id).AddBuff(buffCount);
	}

	private void OnStarBuffReduceCount(AdventureActor target)
	{
		_actor.StartLogicCoroutine(TriggerStarBuff(target), runImmediately: true);
	}

	private IEnumerator TriggerStarBuff(AdventureActor target)
	{
		bool targetIsMonster = target is MonsterAdventureActor;
		string fxAlias = "AreaEffect_132_Support_StarBurst";
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513222, out var perkLevel))
		{
			fxAlias = "AreaEffect_132_Support_StarBurst_P22_Big";
		}
		long num = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, target.tsTransform.Position);
		if (num <= 0)
		{
			yield break;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(num);
		if (areaEffect == null)
		{
			yield break;
		}
		long targetId = target.Id;
		if (_inTriggerSet == null)
		{
			_inTriggerSet = new HashSet<long>();
		}
		_inTriggerSet.Add(targetId);
		TSVector2 position = target.tsTransform.Position;
		while (areaEffect.ActiveSelf)
		{
			if (CommonUtils.CheckTargetIsValid(target, targetId, ingoreSearchedImmunity: true))
			{
				position = target.tsTransform.Position;
			}
			areaEffect.tsTransform.Position = position;
			yield return null;
		}
		if (targetIsMonster && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513224, out perkLevel))
		{
			ILRuntimeAPI.PlayDrop(_actor, "Item_132_Support_P24_Star", position, dropPositionY_P24);
		}
		_inTriggerSet.Remove(targetId);
	}

	private void OnActorDied(IEvent evt)
	{
		if (_starBuffControllerDic == null)
		{
			return;
		}
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (!(adventureActorDiedEvent.actor == null))
		{
			if (_starBuffControllerDic.TryGetValue(adventureActorDiedEvent.actor.Id, out var value))
			{
				RecycleStarBuffController(value);
			}
			_starBuffControllerDic.Remove(adventureActorDiedEvent.actor.Id);
		}
	}

	private bool HaveOrTriggeringBuff(long targetId)
	{
		if (targetId <= 0)
		{
			return false;
		}
		bool num = _starBuffControllerDic != null && _starBuffControllerDic.TryGetValue(targetId, out var value) && value.GetBuffCount() > 0;
		bool flag = _inTriggerSet != null && _inTriggerSet.Contains(targetId);
		return num | flag;
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (adventureAreaEffectFinishEvent.owner != _actor)
		{
			return;
		}
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(adventureAreaEffectFinishEvent.entityID);
		if (areaEffect != null && areaEffect.CheckTag(areaEffectTag_Explosion) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513230, out var _))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor != null && TSVector2.DistanceSquared(playerAdventureActor.tsTransform.Position, areaEffect.tsTransform.Position) < areaEffect.hitBoxRadius * areaEffect.hitBoxRadius)
			{
				playerAdventureActor.buffComponent?.AddBuff(13230011, _actor);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (!(adventureBulletFinishEvent.owner != _actor) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513223, out var perkLevel) && string.Equals(adventureBulletFinishEvent.tag, "132_Bullet_P23"))
		{
			(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor)?.actorShield?.AddShield(13223011, _actor);
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513229, out perkLevel))
			{
				TryTriggerPerkLogic_P29();
			}
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
		if (adventureDropFinishEvent.owner != _actor || !ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513224, out var perkLevel) || !adventureDropFinishEvent.isPickUp || !string.Equals(adventureDropFinishEvent.dropTag, "132_Item_P24"))
		{
			return;
		}
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (adventureActor != null)
		{
			AddBuff(adventureActor, 1);
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513223, out perkLevel))
			{
				adventureActor?.actorShield?.AddShield(13223011, _actor);
			}
		}
	}

	private void TryTriggerPerkLogic_P29()
	{
		if (!_actor.logicVariable.GetLogicTagToggle("CanTrigger_P29"))
		{
			return;
		}
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("TriggerTimes_P29");
		num++;
		if (num >= 3)
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 13229011);
			(_actor as PlayerAdventureActor)?.playerSkillCd.ModifyResumeTimeAbs(-scriptValue, ActionKey.B);
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(13229011, _actor);
			}
			_actor.logicVariable.ToggleLogicTag("CanTrigger_P29", value: false);
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("TriggerTimes_P29", num);
		}
	}

	private void Clear()
	{
		if (_starBuffControllerDic != null && _starBuffControllerDic.Count > 0)
		{
			foreach (StarBuffController value in _starBuffControllerDic.Values)
			{
				value?.Clear();
			}
			_starBuffControllerDic.Clear();
		}
		_inTriggerSet?.Clear();
		_triggerTime_P26 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		Clear();
	}

	private StarBuffController GenerateStarBuffController(AdventureActor target, int maxBuffCount)
	{
		StarBuffController starBuffController = ((_starBuffControllerPool == null || _starBuffControllerPool.Count <= 0) ? new StarBuffController(_actor) : _starBuffControllerPool.Dequeue());
		starBuffController.Init(target, maxBuffCount, OnStarBuffReduceCount);
		return starBuffController;
	}

	private void RecycleStarBuffController(StarBuffController controller)
	{
		if (controller != null)
		{
			controller.Clear();
			if (_starBuffControllerPool == null)
			{
				_starBuffControllerPool = new Queue<StarBuffController>();
			}
			_starBuffControllerPool.Enqueue(controller);
		}
	}
}
