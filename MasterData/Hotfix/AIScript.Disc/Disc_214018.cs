using System;
using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214018 : DiscScriptBase
{
	private const int discId = 214018;

	private List<int> skillId_s1 = new List<int> { 401801, 401802, 401803, 401804, 401805, 401806 };

	private List<int> buff_1_dmg = new List<int> { 4018001, 4018002, 4018003, 4018004, 4018005, 4018006 };

	private List<int> buff_1_extraDmg = new List<int> { 4018020, 4018020, 4018020, 4018020, 4018020, 4018020 };

	private int maxCount_1 = 10;

	private int stage_1;

	private int lv_s1;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_INFO", OnUpdateFateCardInfo);
		(stage_1, lv_s1) = GetDiscInfo(214018, skillId_s1);
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
