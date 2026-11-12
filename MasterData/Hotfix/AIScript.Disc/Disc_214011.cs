using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214011 : DiscScriptBase
{
	private const int discId = 214011;

	private List<int> skillId_s3 = new List<int> { 40112, 0, 0, 0, 0 };

	private const int onceID = 4011200;

	private int skill3_level;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		skill3_level = GetDiscSkillv(214011, skillId_s3);
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (skill3_level >= 1 && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && target.monsterToughnessInfo.isToughnessBroken)
		{
			AdventureActor.AddFromAttr(4011200, actor);
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}
}
