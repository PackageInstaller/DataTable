using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214061 : DiscScriptBase
{
	private const int discId = 214061;

	private List<int> skillId_s1 = new List<int> { 406101, 406102, 406103, 406104, 406105, 406106 };

	private List<int> buffId_1 = new List<int> { 4061001, 4061002, 4061003, 4061004, 4061005, 4061006 };

	private List<int> debuffId_1_skillDmg = new List<int> { 4061011, 4061012, 4061013, 4061014, 4061015, 4061016 };

	private List<int> debuffId_1_markDmg = new List<int> { 4061021, 4061022, 4061023, 4061024, 4061025, 4061026 };

	private List<int> skillId_s2 = new List<int> { 4061101, 4061102, 4061103, 4061104, 4061105 };

	private List<int> buffId_2_memory = new List<int> { 4061111, 4061112, 4061113, 4061114, 4061115 };

	private List<int> skillId_s3 = new List<int> { 4061201, 4061202, 4061203, 4061204, 4061205 };

	private List<int> buffId_3_teamSkillDmg = new List<int> { 4061201, 4061202, 4061203, 4061204, 4061205 };

	private List<int> buffId_3_markDmg = new List<int> { 4061211, 4061212, 4061213, 4061214, 4061215 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214061, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214061, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214061, skillId_s3);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected override void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnMainPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s1 > 0 && IsWater(actor))
		{
			HotfixEnum.skillSlotType skillSlotType = castSkillEvent.skillEventInfo.skillSlotType;
			if (skillSlotType == HotfixEnum.skillSlotType.B || skillSlotType == HotfixEnum.skillSlotType.D)
			{
				actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.buffComponent.CheckBuffByBuffID(buffId_1.get_Item(stage_s1)))
		{
			target.buffComponent.AddBuff(debuffId_1_skillDmg.get_Item(stage_s1), actor);
			target.buffComponent.AddBuff(debuffId_1_markDmg.get_Item(stage_s1), actor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s2 > 0 && evt.elementType == HotfixEnum.elementType.WE && !(evt.triggerActor != _actor) && IsWater(_actor))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(buffId_2_memory.get_Item(stage_s2), buffNumByID, _actor);
			}
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (lv_s3 <= 0 || !(evt is AdventureActorGetBuff adventureActorGetBuff) || adventureActorGetBuff.eventInfo.buffId != buffId_2_memory.get_Item(stage_s2) || !(adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor) || playerAdventureActor != _actor || !IsWater(playerAdventureActor))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (!(actorL == null) && !(actorL.buffComponent == null) && actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				actorL.buffComponent.AddBuff(buffId_3_teamSkillDmg.get_Item(stage_s3), actorL);
			}
		}
		if (_actor.buffComponent.HaveBuffNumMax(buffId_2_memory.get_Item(stage_s2)))
		{
			_actor.buffComponent.AddBuff(buffId_3_markDmg.get_Item(stage_s3), _actor);
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (lv_s3 > 0 && evt is AdventureActorRemoveBuff adventureActorRemoveBuff && adventureActorRemoveBuff.eventInfo.buffId == buffId_2_memory.get_Item(stage_s2) && adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor && !(playerAdventureActor != _actor) && !_actor.buffComponent.HaveBuffNumMax(buffId_2_memory.get_Item(stage_s2)))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_3_markDmg.get_Item(stage_s3));
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
