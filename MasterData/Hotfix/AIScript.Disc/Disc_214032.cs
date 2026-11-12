using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214032 : DiscScriptBase
{
	private const int discId = 214032;

	private List<int> skillId_s1 = new List<int> { 403201, 403202, 403203, 403204, 403205, 403206 };

	private List<int> buffId_1 = new List<int> { 4032021, 4032021, 4032021, 4032021, 4032021, 4032021 };

	private List<int> prob_l = new List<int> { 35, 35, 35, 35, 35, 35 };

	private List<int> skillId_s2 = new List<int> { 4032101, 4032102, 4032103, 4032104, 4032105 };

	private List<int> buffId_2 = new List<int> { 4032101, 4032102, 4032103, 4032104, 4032105 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214032, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214032, skillId_s2);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (actor.actorElementInfo.elementType != HotfixEnum.elementType.DE || damageEvent.skillSlotType == HotfixEnum.skillSlotType.NORMAL || lv_s1 <= 0)
		{
			return;
		}
		int num = prob_l.get_Item(stage_s1);
		if (TSRandom.Range(0, 100) >= num)
		{
			return;
		}
		target.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
		if (lv_s2 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), playerAdventureActor);
			}
		}
	}
}
