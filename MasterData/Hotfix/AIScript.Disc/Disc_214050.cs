using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214050 : DiscScriptBase
{
	private const int discId = 214050;

	private List<int> skillId_s1 = new List<int> { 405001, 405002, 405003, 405004, 405005, 405006 };

	private List<int> buffId_1 = new List<int> { 4050000, 4050000, 4050000, 4050000, 4050000, 4050000 };

	private List<int> onceId_1 = new List<int> { 4050021, 4050022, 4050023, 4050024, 4050025, 4050026 };

	private List<int> skillId_s2 = new List<int> { 4050101, 4050102, 4050103, 4050104, 4050105 };

	private List<int> buffId_2 = new List<int> { 4050101, 4050102, 4050103, 4050104, 4050105 };

	private List<int> buffId_2_1 = new List<int> { 4050121, 4050122, 4050123, 4050124, 4050125 };

	private List<int> skillId_s3 = new List<int> { 4050201, 4050202, 4050203, 4050204, 4050205 };

	private List<int> buffId_3_1 = new List<int> { 4050201, 4050202, 4050203, 4050204, 4050205 };

	private List<int> buffId_3_2 = new List<int> { 4050221, 4050222, 4050223, 4050224, 4050225 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214050, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214050, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214050, skillId_s3);
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

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnReceiveDamage(damageEvent);
		if (lv_s1 > 0 && damageEvent.from is MonsterAdventureActor monsterAdventureActor && damageEvent.to is MonsterAdventureActor && monsterAdventureActor.IsPlayerMinion(out var summoner) && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && summoner.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && _actor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			_actor.buffComponent?.AddBuff(buffId_1.get_Item(stage_s1), monsterAdventureActor);
			if (lv_s2 > 0)
			{
				_actor.buffComponent?.AddBuff(buffId_2_1.get_Item(stage_s2), monsterAdventureActor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && _actor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			_actor.buffComponent?.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s2 > 0)
			{
				_actor.buffComponent?.AddBuff(buffId_2_1.get_Item(stage_s2), actor);
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s1 > 0 && damageEvent.to is MonsterAdventureActor && damageEvent.from is PlayerAdventureActor playerAdventureActor && _actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)) && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			AdventureActor.AddFromAttr(onceId_1.get_Item(stage_s1), playerAdventureActor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
		if (_evt == null || lv_s3 <= 0 || lv_s1 <= 0 || _evt.triggerActor != _actor)
		{
			return;
		}
		bool flag = _actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1));
		if ((_actor.actorElementInfo.elementType == HotfixEnum.elementType.DE) & flag)
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
