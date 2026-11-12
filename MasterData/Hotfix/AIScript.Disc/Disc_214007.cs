using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214007 : DiscScriptBase
{
	private const int discId = 214007;

	private static readonly List<int> skillIds_1 = new List<int> { 4007000, 4007001, 4007002, 4007003, 4007004 };

	private static readonly List<int> buffIdList_1_1_1 = new List<int> { 4007000, 4007001, 4007002, 4007003, 4007004 };

	private static readonly List<int> buffIdList_1_1_2 = new List<int> { 4007005, 4007005, 4007005, 4007005, 4007005 };

	private const int buffId_1_2 = 4007006;

	private const int additionalAttrId_1_3_1 = 4007009;

	private const int additionalAttrId_1_3_2 = 4007010;

	private const int buffId_1_4 = 4007007;

	private const int buffId_1_5 = 4007008;

	private static readonly List<int> skillIds_2 = new List<int> { 40071, 0, 0, 0, 0 };

	private const int buffId_2 = 4007100;

	private static readonly List<int> skillIds_3 = new List<int> { 40072, 0, 0, 0, 0 };

	private const int additionalAttrId_3 = 4007200;

	private const int buffId_3 = 4007201;

	private int _discSkillLevel_1;

	private int _discSkillStage_1;

	private int _discSkillLevel_2;

	private int _discSkillLevel_3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214007, skillIds_1);
		_discSkillStage_1 = discInfo.Item1;
		_discSkillLevel_1 = discInfo.Item2;
		_discSkillLevel_2 = GetDiscInfo(214007, skillIds_2).Item2;
		_discSkillLevel_3 = GetDiscInfo(214007, skillIds_3).Item2;
		if (_discSkillLevel_1 > 0)
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (CheckActorIsLE(actorL))
				{
					actorL.buffComponent.AddBuff(buffIdList_1_1_1.get_Item(_discSkillStage_1), actorL);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ADD_SHIELD", OnAddShield);
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		if (_discSkillLevel_1 > 1 && castSkillEvent.sender is PlayerAdventureActor playerAdventureActor && CheckActorIsLE(playerAdventureActor, checkAssit: true) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			playerAdventureActor.buffComponent.AddBuff(4007006, playerAdventureActor);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (_discSkillLevel_1 > 2 && CheckActorIsLE(actor, checkAssit: true) && damageEvent.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			AdventureActor.AddFromAttr(4007009, actor);
			if (target.isStun)
			{
				AdventureActor.AddFromAttr(4007010, actor);
			}
		}
		if (_discSkillLevel_3 > 0 && CheckActorIsLE(actor) && (target.buffComponent.CheckBuffByBuffTag(CommonDefine.Light) || target.buffComponent.CheckBuffByBuffID(4007201)))
		{
			AdventureActor.AddFromAttr(4007200, actor);
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (_discSkillLevel_1 > 0 && CheckActorIsLE(actor, checkAssit: true, isAssist: true) && damageEvent.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			target.buffComponent.AddBuff(buffIdList_1_1_2.get_Item(_discSkillStage_1), actor);
		}
		if (_discSkillLevel_2 > 0 && CheckActorIsLE(actor) && (damageEvent.skillSlotType == HotfixEnum.skillSlotType.B || damageEvent.skillSlotType == HotfixEnum.skillSlotType.D) && damageEvent.onceAttackTargetCount >= 3)
		{
			actor.buffComponent.AddBuff(4007100, actor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
		base.OnElementMarkTrigger(_evt);
		if (_discSkillLevel_3 > 0 && _evt.triggerActor is PlayerAdventureActor playerAdventureActor && CheckActorIsLE(playerAdventureActor) && _evt.elementType == HotfixEnum.elementType.LE)
		{
			_evt.markActor.buffComponent.AddBuff(4007201, playerAdventureActor);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (_discSkillLevel_1 > 3)
		{
			AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
			if (adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Light) && adventureActorGetBuff.from is PlayerAdventureActor playerAdventureActor && CheckActorIsLE(playerAdventureActor, checkAssit: true, isAssist: true))
			{
				playerAdventureActor.buffComponent.AddBuff(4007007, playerAdventureActor);
			}
		}
	}

	private void OnAddShield(IEvent evt)
	{
		if (_discSkillLevel_1 > 4 && evt is AdventureActorAddShield { from: PlayerAdventureActor playerAdventureActor } && CheckActorIsLE(playerAdventureActor, checkAssit: true, isAssist: true))
		{
			playerAdventureActor.buffComponent.AddBuff(4007008, playerAdventureActor);
		}
	}

	private bool CheckActorIsLE(PlayerAdventureActor actor, bool checkAssit = false, bool isAssist = false)
	{
		if (actor == null)
		{
			return false;
		}
		if (actor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			if (checkAssit)
			{
				return actor.isAssist == isAssist;
			}
			return true;
		}
		return false;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ADD_SHIELD", OnAddShield);
		_discSkillLevel_1 = 0;
		_discSkillLevel_2 = 0;
		_discSkillLevel_3 = 0;
	}
}
