using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214015 : DiscScriptBase
{
	private const int discId = 214015;

	private List<int> skillId_s1 = new List<int> { 401501, 401502, 401503, 401504, 401505, 401506 };

	private List<int> buffId_s1 = new List<int> { 4015020, 4015020, 4015020, 4015020, 4015020, 4015020 };

	private List<int> maxCount_s1 = new List<int> { 5, 5, 5, 5, 5, 5 };

	private List<int> buffId_s1_skill = new List<int> { 4015021, 4015022, 4015023, 4015024, 4015025, 4015026 };

	private List<int> skillId_s2 = new List<int> { 4015101, 4015102, 4015103, 4015104, 4015105 };

	private List<int> buffId_s2 = new List<int> { 4015126, 4015127, 4015128, 4015129, 4015130 };

	private List<int> skillId_s3 = new List<int> { 4015201, 4015202, 4015203, 4015204, 4015205 };

	private List<int> once_s3 = new List<int> { 4015201, 4015202, 4015203, 4015204, 4015205 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	private int lv_s3;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214015, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214015, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214015, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		if (lv_s2 > 0 && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			PlayerAdventureActor playerAdventureActor = castSkillEvent.sender as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_s2.get_Item(stage_s2), playerAdventureActor);
			}
		}
	}

	protected override void OnBeforeMainPlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforeMainPlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && lv_s3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.AE && target.buffComponent.CheckBuffByBuffID(buffId_s1.get_Item(stage_s1)))
		{
			AdventureActor.AddFromAttr(once_s3.get_Item(stage_s3), actor);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (!(damageEvent.from != null) || !(damageEvent.from is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.SKILL && playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), playerAdventureActor);
			if (monsterAdventureActor.buffComponent.GetBuffNumByID(buffId_s1.get_Item(stage_s1)) >= maxCount_s1.get_Item(stage_s1))
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_s1.get_Item(stage_s1));
				monsterAdventureActor.buffComponent.AddBuff(buffId_s1_skill.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}
}
