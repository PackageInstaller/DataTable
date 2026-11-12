using System;
using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214021 : DiscScriptBase
{
	private const int discId = 214021;

	private List<int> skillId_s1 = new List<int> { 402101, 402102, 402103, 402104, 402105, 402106 };

	private List<int> buff_1_dmg = new List<int> { 4021001, 4021002, 4021003, 4021004, 4021005, 4021006 };

	private List<int> buff_1_extraDmg = new List<int> { 4021020, 4021020, 4021020, 4021020, 4021020, 4021020 };

	private int maxCount_1 = 10;

	private List<int> skillId_s3 = new List<int> { 4021201, 4021202, 4021203, 4021204, 4021205 };

	private List<int> buff_s3_extra = new List<int> { 4021240, 4021240, 4021240, 4021240, 4021240 };

	private int count_s3 = 10;

	private int killCount;

	private int stage_1;

	private int lv_s1;

	private int stage_3;

	private int lv_s3;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		killCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		(stage_1, lv_s1) = GetDiscInfo(214021, skillId_s1);
		(stage_3, lv_s3) = GetDiscInfo(214021, skillId_s3);
		if (lv_s1 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_1_dmg.get_Item(stage_1), playerAdventureActor);
			}
		}
		AddBuffByCard();
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor obj = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (obj == null || monsterAdventureActor == null || lv_s3 < 1 || !evt.isKill || ++killCount < count_s3)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buff_s3_extra.get_Item(stage_3));
				playerAdventureActor.buffComponent.AddBuff(buff_s3_extra.get_Item(stage_3), playerAdventureActor);
			}
		}
		killCount = 0;
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
		if (lv_s1 <= 0)
		{
			return;
		}
		int allFateCardCount = ModuleController<AdventureModuleController>.Instance.GetAllFateCardCount();
		allFateCardCount = Math.Min(allFateCardCount, maxCount_1);
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buff_1_extraDmg.get_Item(stage_1));
				playerAdventureActor.buffComponent.AddBuffNum(buff_1_extraDmg.get_Item(stage_1), allFateCardCount, playerAdventureActor);
			}
		}
	}
}
