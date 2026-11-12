using System;
using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214020 : DiscScriptBase
{
	private const int discId = 214020;

	private List<int> skillId_s1 = new List<int> { 402001, 402002, 402003, 402004, 402005, 402006 };

	private List<int> buff_1_dmg = new List<int> { 4020001, 4020002, 4020003, 4020004, 4020005, 4020006 };

	private List<int> buff_1_extraDmg = new List<int> { 4020020, 4020020, 4020020, 4020020, 4020020, 4020020 };

	private int maxCount_1 = 10;

	private int stage_1;

	private int lv_s1;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		(stage_1, lv_s1) = GetDiscInfo(214020, skillId_s1);
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
		if (lv_s1 > 0)
		{
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_dmg.get_Item(stage_1));
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_1_extraDmg.get_Item(stage_1));
		}
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
}
