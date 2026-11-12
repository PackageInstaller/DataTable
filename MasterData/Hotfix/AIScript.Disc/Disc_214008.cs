using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214008 : DiscScriptBase
{
	private const int discId = 214008;

	private List<int> skillId_s1 = new List<int> { 400801, 400802, 400803, 400804, 400805, 400806 };

	private List<int> buffId_1 = new List<int> { 4008000, 4008000, 4008000, 4008000, 4008000, 4008000 };

	private List<int> count_1 = new List<int> { 10, 10, 10, 10, 10, 10 };

	private List<int> onceId_1 = new List<int> { 4008001, 4008002, 4008003, 4008004, 4008005, 4008006 };

	private List<int> count_1_2 = new List<int> { 20, 20, 20, 20, 20, 20 };

	private List<int> onceId_1_2 = new List<int> { 4008021, 4008022, 4008023, 4008024, 4008025, 4008026 };

	private List<int> skillId_s2 = new List<int> { 4008101, 4008102, 4008103, 4008104, 4008105 };

	private List<int> onceId_2 = new List<int> { 4008121, 4008122, 4008123, 4008124, 4008125 };

	private List<int> skillId_s3 = new List<int> { 4008201, 4008202, 4008203, 4008204, 4008205 };

	private List<int> onceId_3 = new List<int> { 4008201, 4008202, 4008203, 4008204, 4008205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214008, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214008, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214008, skillId_s3);
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
		{
			target.buffComponent?.AddBuff(buffId_1.get_Item(stage_s1), actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s1 <= 0 || !(damageEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		int buffNumByID = monsterAdventureActor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
		if (buffNumByID <= 0)
		{
			return;
		}
		if (buffNumByID >= count_1.get_Item(stage_s1))
		{
			AdventureActor.AddToAttr(onceId_1.get_Item(stage_s1), monsterAdventureActor);
		}
		if (buffNumByID >= count_1_2.get_Item(stage_s1))
		{
			AdventureActor.AddToAttr(onceId_1_2.get_Item(stage_s1), monsterAdventureActor);
		}
		if (damageEvent.from is PlayerAdventureActor playerAdventureActor && _actor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			if (lv_s2 > 0 && playerAdventureActor == _actor)
			{
				AdventureActor.AddFromAttr(onceId_2.get_Item(stage_s2), _actor, buffNumByID);
			}
			if (lv_s3 > 0)
			{
				AdventureActor.AddFromAttr(onceId_3.get_Item(stage_s3), playerAdventureActor, buffNumByID);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
