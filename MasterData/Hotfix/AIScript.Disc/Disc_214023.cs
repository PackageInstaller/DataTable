using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214023 : DiscScriptBase
{
	private const int discId = 214023;

	private List<int> skillId_s1 = new List<int> { 402301, 402302, 402303, 402304, 402305, 402306 };

	private List<int> buff_1_dmg = new List<int> { 4023001, 4023002, 4023003, 4023004, 4023005, 4023006 };

	private List<int> buff_1_extra = new List<int> { 4023020, 4023020, 4023020, 4023020, 4023020, 4023020 };

	private List<int> skillId_s3 = new List<int> { 4023201, 4023202, 4023203, 4023204, 4023205 };

	private List<int> buff_3_dmg = new List<int> { 4023201, 4023202, 4023203, 4023204, 4023205 };

	private List<int> buff_3_extra = new List<int> { 4023240, 4023240, 4023240, 4023240, 4023240, 4023240 };

	private List<int> count_3 = new List<int> { 10, 10, 10, 10, 10 };

	private int stage_1;

	private int lv_s1;

	private int stage_3;

	private int lv_s3;

	private int killCount;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		killCount = 0;
		(int, int) discInfo = GetDiscInfo(214023, skillId_s1);
		stage_1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214023, skillId_s3);
		stage_3 = discInfo.Item1;
		lv_s3 = discInfo.Item2;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				if (lv_s1 > 0)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_1_dmg.get_Item(stage_1), _actor);
				}
				if (lv_s3 > 0)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_3_dmg.get_Item(stage_3), _actor);
				}
			}
		}
		AddBuffByCard();
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
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_extra.get_Item(stage_1));
			int allFateCardCount = ModuleController<AdventureModuleController>.Instance.GetAllFateCardCount();
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_1_extra.get_Item(stage_1), _actor, allFateCardCount);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor obj = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (obj == null || monsterAdventureActor == null || lv_s3 < 1 || !evt.isKill || ++killCount < count_3.get_Item(stage_3))
		{
			return;
		}
		killCount = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_3_extra.get_Item(stage_3), _actor);
			}
		}
	}
}
