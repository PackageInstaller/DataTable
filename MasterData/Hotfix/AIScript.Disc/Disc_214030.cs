using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214030 : DiscScriptBase
{
	private const int discId = 214030;

	private const int buffId_esd = 4029999;

	private List<int> skillId_s1 = new List<int> { 4029000, 4029001, 4029002, 4029003, 4029004 };

	private List<int> buff_1 = new List<int> { 4029000, 4029001, 4029002, 4029003, 4029004 };

	private List<int> skillId_s2 = new List<int> { 40291, 40291, 40291, 40291, 40291 };

	private List<int> once_2 = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> skillId_s3 = new List<int> { 40292, 40292, 40292, 40292, 40292 };

	private List<int> once_3_1 = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> once_3_2 = new List<int> { 0, 0, 0, 0, 0 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214030, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214030, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214030, skillId_s3);
		if (lv_s1 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_1.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s2 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.LE && target != null && target.buffComponent.CheckBuffByBuffID(4029999))
		{
			AdventureActor.AddFromAttr(once_2.get_Item(stage_s2), actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s3 > 0)
		{
			if (damageEvent.from is MonsterAdventureActor monsterAdventureActor && damageEvent.to is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && monsterAdventureActor.buffComponent.CheckBuffByBuffID(4029999))
			{
				AdventureActor.AddFromAttr(once_3_1.get_Item(stage_s3), monsterAdventureActor);
			}
			if (damageEvent.from is PlayerAdventureActor playerAdventureActor2 && damageEvent.to is MonsterAdventureActor monsterAdventureActor2 && playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.LE && monsterAdventureActor2.buffComponent.CheckBuffByBuffID(4029999))
			{
				AdventureActor.AddFromAttr(once_3_2.get_Item(stage_s3), playerAdventureActor2);
			}
		}
	}

	protected override void OnReceiveAttack(AdventureActorReceiveAttackEvent damageEvt, MonsterAdventureActor monster)
	{
		if (lv_s1 > 0 && !monster.buffComponent.CheckBuffByBuffID(4029999))
		{
			monster.buffComponent.AddBuff(4029999, damageEvt.from as AdventureActor);
		}
	}
}
