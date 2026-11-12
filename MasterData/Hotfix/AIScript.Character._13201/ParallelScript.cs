using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class ParallelScript : ParallelBase
{
	protected const int buffId_LightMark = 3011;

	protected static readonly int damageTag_LightMark = CommonHelper.StringToHash("132_LightTag_Hurt");

	protected static readonly int damageTag_UltraSkill = CommonHelper.StringToHash("132_Ultra");

	private const int ultraSkillId_Default = 13240000;

	private const int perkId_41 = 513241;

	private const int ultraSkillId_P41 = 13244100;

	private const int additionalAttrId_P41 = 13241001;

	private const int perkId_42 = 513242;

	private const int additionalAttrId_P42 = 13242001;

	public const int buffId_D1 = 13296111;

	public const int buffId_D2 = 13296211;

	public static readonly int damageTag_Trigger_D3 = CommonHelper.StringToHash("132_Ultra");

	public const int buffId_D3 = 13296311;

	public const int buffId_D4 = 13296411;

	public const int additionalAttrId_D5 = 13296511;

	private FP _triggerTime_D1;

	private PlayFX _playFX_D1;

	public override void OnEnable()
	{
		base.OnEnable();
		_triggerTime_D1 = 0;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513241, out var _))
		{
			(_actor as PlayerAdventureActor)?.playerSkillCd?.BindSkillIdToButton(ActionKey.D, 13244100);
		}
		else
		{
			(_actor as PlayerAdventureActor)?.playerSkillCd?.BindSkillIdToButton(ActionKey.D, 13240000);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && (adventureActorCastSkillEvent.sender as AdventureActor) is PlayerAdventureActor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(13296411, _actor);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		OnPlayerBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
		if (!(adventureActorReceiveDamageBeforeHitEvent.from == _actor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, damageTag_UltraSkill))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513241, out var _))
			{
				AdventureActor.AddFromAttr(13241001, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513242, out var _))
			{
				AdventureActor.AddFromAttr(13242001, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(13296511, _actor);
		}
		OnSelfBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
		OnPlayerDamaged(adventureActorReceiveDamageEvent);
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Trigger_D3))
			{
				monsterAdventureActor.buffComponent.AddBuff(13296311, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CommonUtils.CheckTriggerElementMarkCD(_actor, monsterAdventureActor) && CommonUtils.CheckElementMark(CommonDefine.Light, monsterAdventureActor))
			{
				TryTriggerLightMark(adventureActorReceiveDamageEvent);
			}
		}
	}

	protected virtual void OnPlayerBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void TryTriggerLightMark(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.LE } adventureElementMarkTriggerEvent && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			adventureElementMarkTriggerEvent.markActor.buffComponent.AddBuff(13296111, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}
}
