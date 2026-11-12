using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Disc;

public class Disc_213011 : DiscScriptBase
{
	private const int discId = 213011;

	private List<int> skillId_s3 = new List<int> { 30112, 100101, 100101, 100101, 100101 };

	private int hitDmg_s3 = 3011200;

	private int lv_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		lv_s3 = GetDiscInfo(213011, skillId_s3).Item2;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.to as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.from as MonsterAdventureActor;
		if (!(playerAdventureActor == null) && !(monsterAdventureActor == null) && lv_s3 > 0 && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			ILRuntimeAPI.HitActor(playerAdventureActor, monsterAdventureActor, hitDmg_s3);
		}
	}
}
