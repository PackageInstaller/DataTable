using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214062 : DiscScriptBase
{
	private const int discId = 214062;

	private const int jueZeThreshold_3 = 3;

	private List<int> skillId_s1 = new List<int> { 406201, 406202, 406203, 406204, 406205, 406206 };

	private List<int> buffId_1_jueze = new List<int> { 4062000, 4062000, 4062000, 4062000, 4062000, 4062000 };

	private List<int> onceId_1_teamWaterDmg = new List<int> { 4062001, 4062002, 4062003, 4062004, 4062005, 4062006 };

	private List<int> buffId_1_markDmg = new List<int> { 4062011, 4062012, 4062013, 4062014, 4062015, 4062016 };

	private List<int> skillId_s2 = new List<int> { 4062101, 4062102, 4062103, 4062104, 4062105 };

	private List<int> buffId_2_atk = new List<int> { 4062101, 4062102, 4062103, 4062104, 4062105 };

	private List<int> debuffId_2_tomorrow = new List<int> { 4062100, 4062100, 4062100, 4062100, 4062100 };

	private List<int> onceId_2_waterSkillDmg = new List<int> { 4062111, 4062112, 4062113, 4062114, 4062115 };

	private List<int> skillId_s3 = new List<int> { 4062201, 4062202, 4062203, 4062204, 4062205 };

	private List<int> buffId_3_teamAtk = new List<int> { 4062201, 4062202, 4062203, 4062204, 4062205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214062, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214062, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214062, skillId_s3);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s1 > 0 && evt.elementType == HotfixEnum.elementType.WE && !(evt.triggerActor != _actor) && IsWater(_actor))
		{
			AddJueZe();
		}
	}

	protected override void OnMainPlayerActorReceiveDamage(AdventureActor damageSource, PlayerAdventureActor actor, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorReceiveDamage(damageSource, actor, damageEvent);
		if (lv_s1 > 0 && IsWater(actor))
		{
			AddJueZe();
		}
	}

	private void AddJueZe()
	{
		_actor.buffComponent.AddBuff(buffId_1_jueze.get_Item(stage_s1), _actor);
		if (_actor.buffComponent.HaveBuffNumMax(buffId_1_jueze.get_Item(stage_s1)))
		{
			_actor.buffComponent.AddBuff(buffId_1_markDmg.get_Item(stage_s1), _actor);
			if (lv_s2 > 0)
			{
				_actor.buffComponent.AddBuff(buffId_2_atk.get_Item(stage_s2), _actor);
			}
		}
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s2 > 0 && IsWater(actor) && _actor.buffComponent.HaveBuffNumMax(buffId_1_jueze.get_Item(stage_s1)))
		{
			target.buffComponent.AddBuff(debuffId_2_tomorrow.get_Item(stage_s2), actor);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && IsWater(actor) && _actor.buffComponent.GetBuffNumByID(buffId_1_jueze.get_Item(stage_s1)) >= 3)
		{
			AdventureActor.AddFromAttr(onceId_1_teamWaterDmg.get_Item(stage_s1), actor);
		}
		if (lv_s2 > 0 && damageEvent.damageType == HotfixEnum.damageType.SKILL && target.buffComponent.CheckBuffByBuffID(debuffId_2_tomorrow.get_Item(stage_s2)))
		{
			AdventureActor.AddFromAttr(onceId_2_waterSkillDmg.get_Item(stage_s2), actor);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (lv_s3 > 0 && evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.eventInfo.buffId == debuffId_2_tomorrow.get_Item(stage_s2) && adventureActorGetBuff.from is PlayerAdventureActor playerAdventureActor && !(playerAdventureActor != _actor) && IsWater(playerAdventureActor))
		{
			AddBuffToGroup(buffId_3_teamAtk.get_Item(stage_s3));
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (lv_s1 > 0 && evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == buffId_1_jueze.get_Item(stage_s1) && adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor && !(playerAdventureActor != _actor) && !_actor.buffComponent.HaveBuffNumMax(buffId_1_jueze.get_Item(stage_s1)))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_1_markDmg.get_Item(stage_s1));
			if (lv_s2 > 0)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_2_atk.get_Item(stage_s2));
			}
		}
	}

	private bool IsWater(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE;
		}
		return false;
	}
}
