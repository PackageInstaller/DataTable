using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Disc;

public class Disc_213012 : DiscScriptBase
{
	private const int discId = 213012;

	private List<int> skillId_s2 = new List<int> { 30121, 100101, 100101, 100101, 100101 };

	private int count_s2 = 3012100;

	private int buff_s2 = 3012100;

	private int lv_s2;

	private int s2_count;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		s2_count = 0;
		int item = GetDiscInfo(213012, skillId_s2).Item2;
		if (item > 0)
		{
			lv_s2 = item;
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.NORMAL || lv_s2 <= 0 || actor.actorElementInfo.elementType != HotfixEnum.elementType.DE)
		{
			return;
		}
		s2_count++;
		int num = CommonUtils.GetScriptValue(_actor, count_s2).AsInt();
		if (s2_count < num)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s2, actor);
			}
		}
		s2_count = 0;
	}
}
