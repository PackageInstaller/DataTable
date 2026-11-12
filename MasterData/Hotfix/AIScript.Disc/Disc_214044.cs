using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214044 : DiscScriptBase
{
	private const int discId = 214044;

	private List<int> skillId_s1 = new List<int> { 404401, 404402, 404403, 404404, 404405, 404406 };

	private List<int> buffId_s1 = new List<int> { 4044021, 4044022, 4044023, 4044024, 4044025, 4044026 };

	private List<int> skillId_s2 = new List<int> { 4044101, 4044102, 4044103, 4044104, 4044105 };

	private List<int> buffId_s2 = new List<int> { 4044101, 4044102, 4044103, 4044104, 4044105 };

	private List<int> once_s2 = new List<int> { 4044121, 4044122, 4044123, 4044124, 4044125 };

	private List<int> skillId_s3 = new List<int> { 4044201, 4044202, 4044203, 4044204, 4044205 };

	private List<int> count_s3 = new List<int> { 10, 10, 10, 10, 10 };

	private List<int> buffId_s3 = new List<int> { 4044201, 4044202, 4044203, 4044204, 4044205 };

	private List<int> once_s3 = new List<int> { 4044221, 4044222, 4044223, 4044224, 4044225 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	private int lv_s3;

	private int stage_s3;

	private int hitCount;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214044, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214044, skillId_s2);
		stage_s2 = discInfo.Item1;
		lv_s2 = discInfo.Item2;
		discInfo = GetDiscInfo(214044, skillId_s3);
		stage_s3 = discInfo.Item1;
		lv_s3 = discInfo.Item2;
		hitCount = 0;
		if (lv_s2 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_s2.get_Item(stage_s2), playerAdventureActor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor monster, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, monster, damageEvent);
		if (lv_s3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.buffComponent.CheckBuffByBuffID(buffId_s3.get_Item(stage_s3)))
		{
			AdventureActor.AddFromAttr(once_s3.get_Item(stage_s3), actor);
		}
	}

	protected override void OnBeforeMainPlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor monster, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforeMainPlayerActorHit(actor, monster, damageEvent);
		if (lv_s2 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && damageEvent.damageType == HotfixEnum.damageType.SKILL && monster.buffComponent.CheckBuffByBuffID(buffId_s1.get_Item(stage_s1)))
		{
			AdventureActor.AddFromAttr(once_s2.get_Item(stage_s2), actor);
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			target.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), actor);
		}
		if (lv_s3 <= 0 || actor.actorElementInfo.elementType != HotfixEnum.elementType.SE || !(actor == mainCtrActor) || damageEvent.damageType != HotfixEnum.damageType.SKILL || !target.buffComponent.CheckBuffByBuffID(buffId_s1.get_Item(stage_s1)))
		{
			return;
		}
		hitCount++;
		if (hitCount < count_s3.get_Item(stage_s3))
		{
			return;
		}
		hitCount = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_s3.get_Item(stage_s3), playerAdventureActor);
			}
		}
	}
}
