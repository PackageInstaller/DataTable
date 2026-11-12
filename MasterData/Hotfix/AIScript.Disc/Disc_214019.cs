using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214019 : DiscScriptBase
{
	private const int discId = 214019;

	private List<int> skillId_s1 = new List<int> { 401901, 401902, 401903, 401904, 401905, 401906 };

	private List<int> buff_1_dmg = new List<int> { 4019001, 4019002, 4019003, 4019004, 4019005, 4019006 };

	private List<int> buff_1_extraDmg = new List<int> { 4019020, 4019020, 4019020, 4019020, 4019020, 4019020 };

	private int maxCount_1 = 10;

	private List<int> skillId_s2 = new List<int> { 4019201, 4019202, 4019203, 4019204, 4019205 };

	private List<int> buff_2_atk = new List<int> { 4019201, 4019202, 4019203, 4019204, 4019205 };

	private List<int> buff_2_extraDmg = new List<int> { 4019222, 4019222, 4019222, 4019222, 4019222 };

	private FP interval_2 = 8;

	private int stage_1;

	private int lv_s1;

	private int stage_2;

	private int lv_s2;

	private CoroutineNode corAddBuff;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		(stage_1, lv_s1) = GetDiscInfo(214019, skillId_s1);
		(stage_2, lv_s2) = GetDiscInfo(214019, skillId_s2);
		if (lv_s1 > 0)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_1_dmg.get_Item(stage_1), mainCtrActor);
			AddBuffByCard();
		}
		if (lv_s2 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_2_atk.get_Item(stage_2), playerAdventureActor);
			}
		}
		StartCoroutine(ref corAddBuff, DoAddBuff());
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		if (lv_s1 > 0)
		{
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_dmg.get_Item(stage_1));
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_extraDmg.get_Item(stage_1));
		}
		StopCoroutine(ref corAddBuff);
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

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_2_extraDmg.get_Item(stage_2), playerAdventureActor);
				}
			}
			yield return _actor.WaitTime(interval_2);
		}
	}
}
