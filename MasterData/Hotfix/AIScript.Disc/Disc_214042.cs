using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214042 : DiscScriptBase
{
	private const int discId = 214042;

	private List<int> skillId_s1 = new List<int> { 404201, 404202, 404203, 404204, 404205, 404206 };

	private List<int> buffId_s1 = new List<int> { 4042021, 4042022, 4042023, 4042024, 4042025, 4042026 };

	private List<int> skillId_s2 = new List<int> { 4042101, 4042102, 4042103, 4042104, 4042105 };

	private List<int> buffId_s2 = new List<int> { 4042101, 4042102, 4042103, 4042104, 4042105 };

	private List<int> skillId_s3 = new List<int> { 4042201, 4042202, 4042203, 4042204, 4042205 };

	private List<int> count_s3 = new List<int> { 10, 10, 10, 10, 10 };

	private List<int> buffId_s3 = new List<int> { 4042201, 4042202, 4042203, 4042204, 4042205 };

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
		(int, int) discInfo = GetDiscInfo(214042, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214042, skillId_s2);
		stage_s2 = discInfo.Item1;
		lv_s2 = discInfo.Item2;
		discInfo = GetDiscInfo(214042, skillId_s3);
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

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && actor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
				{
					playerAdventureActor.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), playerAdventureActor);
				}
			}
		}
		if (lv_s3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && actor == mainCtrActor)
		{
			hitCount++;
			if (hitCount >= count_s3.get_Item(stage_s3))
			{
				hitCount = 0;
				actor.buffComponent.AddBuff(buffId_s3.get_Item(stage_s3), actor);
			}
		}
	}
}
