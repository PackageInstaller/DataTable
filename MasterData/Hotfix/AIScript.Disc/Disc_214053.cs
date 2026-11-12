using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214053 : DiscScriptBase
{
	private const int discId = 214053;

	private FP shieldCD = 30;

	private List<int> skillId_s1 = new List<int> { 405301, 405302, 405303, 405304, 405305, 405306 };

	private List<int> buffId_1_skillDmg = new List<int> { 4053001, 4053002, 4053003, 4053004, 4053005, 4053006 };

	private List<int> buffId_1_mark = new List<int> { 4053000, 4053000, 4053000, 4053000, 4053000, 4053000 };

	private List<int> shieldId_1 = new List<int> { 4053021, 4053022, 4053023, 4053024, 4053025, 4053026 };

	private List<int> skillId_s2 = new List<int> { 4053101, 4053102, 4053103, 4053104, 4053105 };

	private List<int> buffId_2_skillDmg = new List<int> { 4053101, 4053102, 4053103, 4053104, 4053105 };

	private List<int> skillId_s3 = new List<int> { 4053201, 4053202, 4053203, 4053204, 4053205 };

	private List<int> once_3_ultDmg = new List<int> { 4053221, 4053222, 4053223, 4053224, 4053225 };

	private int lv_1;

	private int lv_2;

	private int lv_3;

	private int stage_1;

	private int stage_2;

	private int stage_3;

	private FP _lastShieldTime;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214053, skillId_s1);
		stage_1 = discInfo.Item1;
		lv_1 = discInfo.Item2;
		discInfo = GetDiscInfo(214053, skillId_s2);
		stage_2 = discInfo.Item1;
		lv_2 = discInfo.Item2;
		discInfo = GetDiscInfo(214053, skillId_s3);
		stage_3 = discInfo.Item1;
		lv_3 = discInfo.Item2;
		_lastShieldTime = 0;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnMainPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			actor.buffComponent.AddBuff(buffId_1_skillDmg.get_Item(stage_1), actor);
			actor.buffComponent.AddBuff(buffId_1_mark.get_Item(stage_1), actor);
			if (lv_2 > 0)
			{
				actor.buffComponent.AddBuff(buffId_2_skillDmg.get_Item(stage_2), actor);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && !actor.isAssist && actor.buffComponent.HaveBuffNumMax(buffId_1_mark.get_Item(stage_1)))
		{
			AdventureActor.AddFromAttr(once_3_ultDmg.get_Item(stage_3), actor);
		}
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorDamaged(actor, target, damageEvent);
		if (lv_1 > 0 && !(actor == null) && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && damageEvent.damageType == HotfixEnum.damageType.SKILL && (!(_lastShieldTime > 0) || !(actor.LogicTime - _lastShieldTime <= shieldCD)))
		{
			actor.actorShield.RemoveShieldByShieldID(shieldId_1.get_Item(stage_1));
			int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1_mark.get_Item(stage_1));
			for (int i = 0; i < buffNumByID; i++)
			{
				actor.actorShield.AddShield(shieldId_1.get_Item(stage_1), actor);
			}
			_lastShieldTime = actor.LogicTime;
		}
	}
}
