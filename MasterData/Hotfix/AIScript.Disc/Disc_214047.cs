using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214047 : DiscScriptBase
{
	private const int discId = 214047;

	private List<int> skillId_s1 = new List<int> { 404701, 404702, 404703, 404704, 404705, 404706 };

	private List<int> buffId_1 = new List<int> { 4047000, 4047000, 4047000, 4047000, 4047000, 4047000 };

	private List<int> count_1 = new List<int> { 10, 10, 10, 10, 10, 10 };

	private List<int> onceId_1 = new List<int> { 4047001, 4047002, 4047003, 4047004, 4047005, 4047006 };

	private List<int> count_1_2 = new List<int> { 20, 20, 20, 20, 20, 20 };

	private List<int> onceId_1_2 = new List<int> { 4047021, 4047022, 4047023, 4047024, 4047025, 4047026 };

	private List<int> skillId_s2 = new List<int> { 4047101, 4047102, 4047103, 4047104, 4047105 };

	private List<int> onceId_2 = new List<int> { 4047121, 4047122, 4047123, 4047124, 4047125 };

	private List<int> skillId_s3 = new List<int> { 4047201, 4047202, 4047203, 4047204, 4047205 };

	private List<int> onceId_3 = new List<int> { 4047201, 4047202, 4047203, 4047204, 4047205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214047, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214047, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214047, skillId_s3);
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && _actor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			_actor.buffComponent?.AddBuff(buffId_1.get_Item(stage_s1), actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s1 <= 0 || !(damageEvent.to is MonsterAdventureActor))
		{
			return;
		}
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
		if (buffNumByID > 0)
		{
			if (buffNumByID >= count_1.get_Item(stage_s1) && damageEvent.elementType == HotfixEnum.elementType.WE && damageEvent.from is AdventureActor adventureActor && (adventureActor is PlayerAdventureActor || adventureActor.IsPlayerMinion(out var _)))
			{
				AdventureActor.AddFromAttr(onceId_1.get_Item(stage_s1), adventureActor);
			}
			if (buffNumByID >= count_1_2.get_Item(stage_s1) && damageEvent.damageType == HotfixEnum.damageType.SKILL && damageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				AdventureActor.AddFromAttr(onceId_1_2.get_Item(stage_s1), playerAdventureActor);
			}
			if (lv_s2 > 0)
			{
				AdventureActor.AddFromAttr(onceId_2.get_Item(stage_s2), _actor, buffNumByID);
			}
			if (lv_s3 > 0)
			{
				AdventureActor.AddFromAttr(onceId_3.get_Item(stage_s3), _actor, buffNumByID);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
