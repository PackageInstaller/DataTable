using System;
using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214022 : DiscScriptBase
{
	private const int discId = 214022;

	private List<int> skillId_s1 = new List<int> { 402201, 402202, 402203, 402204, 402205, 402206 };

	private List<int> buff_1_dmg = new List<int> { 4022001, 4022002, 4022003, 4022004, 4022005, 4022006 };

	private List<int> buff_1_extraDmg = new List<int> { 4022020, 4022020, 4022020, 4022020, 4022020, 4022020 };

	private int maxCount_1 = 10;

	private List<int> skillId_s2 = new List<int> { 4022201, 4022202, 4022203, 4022204, 4022205 };

	private int killCount_2 = 50;

	private List<int> once_2_normal = new List<int> { 4022201, 4022202, 4022203, 4022204, 4022205 };

	private List<int> once_2_boss = new List<int> { 4022206, 4022207, 4022208, 4022209, 4022210 };

	private int stage_1;

	private int stage_2;

	private int lv_s1;

	private int lv_s2;

	private int count;

	private bool trigger;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		count = 0;
		trigger = false;
		(stage_1, lv_s1) = GetDiscInfo(214022, skillId_s1);
		(stage_2, lv_s2) = GetDiscInfo(214022, skillId_s2);
		if (lv_s1 > 0)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_1_dmg.get_Item(stage_1), mainCtrActor);
			AddBuffByCard();
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
	}

	private void OnUpdateFateCardInfo(IEvent evt)
	{
		if (evt is ActorRefreshFateCardInfo)
		{
			AddBuffByCard();
		}
	}

	private void AddBuffByCard()
	{
		if (lv_s1 > 0)
		{
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_extraDmg.get_Item(stage_1));
			int allFateCardCount = ModuleController<AdventureModuleController>.Instance.GetAllFateCardCount();
			allFateCardCount = Math.Min(allFateCardCount, maxCount_1);
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_1_extraDmg.get_Item(stage_1), mainCtrActor, allFateCardCount);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s2 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			if (target.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL)
			{
				AdventureActor.AddFromAttr(once_2_normal.get_Item(stage_2), actor);
			}
			else if (trigger)
			{
				AdventureActor.AddFromAttr(once_2_boss.get_Item(stage_2), actor);
			}
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (lv_s2 > 0 && damageEvent.to is MonsterAdventureActor monsterAdventureActor && !monsterAdventureActor.IsPlayerMinion(out var _) && !trigger && damageEvent.isKill && monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL)
		{
			count++;
			trigger = count >= killCount_2;
		}
	}
}
