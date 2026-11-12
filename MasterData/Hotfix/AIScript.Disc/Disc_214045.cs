using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214045 : DiscScriptBase
{
	private const int discId = 214045;

	private List<int> skillId_s1 = new List<int> { 404501, 404502, 404503, 404504, 404505, 404506 };

	private List<int> buffId_1 = new List<int> { 4045000, 4045000, 4045000, 4045000, 4045000, 4045000 };

	private List<int> onceId_1 = new List<int> { 4045021, 4045022, 4045023, 4045024, 4045025, 4045026 };

	private List<int> skillId_s2 = new List<int> { 4045101, 4045102, 4045103, 4045104, 4045105 };

	private List<int> buffId_2 = new List<int> { 4045101, 4045102, 4045103, 4045104, 4045105 };

	private List<int> buffId_2_1 = new List<int> { 4045121, 4045122, 4045123, 4045124, 4045125 };

	private List<int> skillId_s3 = new List<int> { 4045201, 4045202, 4045203, 4045204, 4045205 };

	private List<int> buffId_3 = new List<int> { 4045200, 4045200, 4045200, 4045200, 4045200 };

	private List<int> buffId_3_1 = new List<int> { 4045201, 4045202, 4045203, 4045204, 4045205 };

	private List<int> buffId_3_2 = new List<int> { 4045221, 4045222, 4045223, 4045224, 4045225 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214045, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214045, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214045, skillId_s3);
		if (lv_s2 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
			{
				playerAdventureActor.buffComponent?.AddBuff(buffId_2.get_Item(stage_s2), playerAdventureActor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
		{
			target.buffComponent?.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s2 > 0)
			{
				target.buffComponent?.AddBuff(buffId_2_1.get_Item(stage_s2), actor);
			}
		}
		if (lv_s3 > 0 && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && _actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && target.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
		{
			_actor.buffComponent?.AddBuff(buffId_3.get_Item(stage_s3), actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s1 > 0 && damageEvent.to is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
		{
			AdventureActor.AddToAttr(onceId_1.get_Item(stage_s1), monsterAdventureActor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
		if (_evt != null && lv_s3 > 0 && !(_evt.triggerActor != _actor) && _actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && _actor.buffComponent.CheckBuffByBuffID(buffId_3.get_Item(stage_s3)))
		{
			if (_evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1)
			{
				_actor.buffComponent.AddBuff(buffId_3_1.get_Item(stage_s3), _actor);
			}
			else if (_evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType2)
			{
				_actor.buffComponent.AddBuff(buffId_3_2.get_Item(stage_s3), _actor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
