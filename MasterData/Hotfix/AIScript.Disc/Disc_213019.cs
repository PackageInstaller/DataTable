using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_213019 : DiscScriptBase
{
	private const int discId = 213019;

	private List<int> skillId_s1 = new List<int> { 3019000, 3019001, 3019002, 3019003, 3019004 };

	private int count_s1v3 = 10;

	private int buff_s1v3_dmg = 4022004;

	private int energy_s1v3 = 5;

	private int lv_s1;

	private Dictionary<int, int> dicCount = new Dictionary<int, int>();

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		lv_s1 = GetDiscInfo(213019, skillId_s1).Item2;
		if (lv_s1 < 3)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				dicCount.Add(playerAdventureActor.dataID, 0);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		dicCount.Clear();
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(playerAdventureActor == null) && !(monsterAdventureActor == null) && evt.isKill && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && lv_s1 >= 3 && dicCount.TryGetValue(playerAdventureActor.dataID, out var value))
		{
			if (++value > count_s1v3)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s1v3_dmg, playerAdventureActor);
				playerAdventureActor.AddEnergy(energy_s1v3);
				value = 0;
			}
			dicCount.set_Item(playerAdventureActor.dataID, value);
		}
	}
}
