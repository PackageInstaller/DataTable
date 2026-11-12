using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214026 : DiscScriptBase
{
	private const int discId = 214026;

	private List<int> skillId_s2 = new List<int> { 4026101, 4026102, 4026103, 4026104, 4026105 };

	private List<int> count_2 = new List<int> { 20, 20, 20, 20, 20 };

	private List<int> buff_2_atk = new List<int> { 4026101, 4026102, 4026103, 4026104, 4026105 };

	private int lv_s2;

	private int stage_s2;

	private int curCount;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		curCount = 0;
		(stage_s2, lv_s2) = GetDiscInfo(214026, skillId_s2);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		if (lv_s2 > 0 && !actor.buffComponent.CheckBuffByBuffID(buff_2_atk.get_Item(stage_s2)))
		{
			curCount++;
			if (curCount >= count_2.get_Item(stage_s2))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_2_atk.get_Item(stage_s2), actor);
				curCount = 0;
			}
		}
	}
}
