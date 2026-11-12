using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214029 : DiscScriptBase
{
	private const int discId = 214029;

	private List<int> skillId_s1 = new List<int> { 402901, 402902, 402903, 402904, 402905, 402906 };

	private List<int> buffId_1_skillDmg = new List<int> { 4029001, 4029002, 4029003, 4029004, 4029005, 4029006 };

	private List<int> buffId_1_mark = new List<int> { 4029000, 4029000, 4029000, 4029000, 4029000, 4029000 };

	private List<int> buffId_1_debuff = new List<int> { 4029021, 4029022, 4029023, 4029024, 4029025, 4029026 };

	private List<int> skillId_s2 = new List<int> { 4029101, 4029102, 4029103, 4029104, 4029105 };

	private List<int> buffId_2_crit = new List<int> { 4029121, 4029122, 4029123, 4029124, 4029125 };

	private List<int> skillId_s3 = new List<int> { 4029201, 4029202, 4029203, 4029204, 4029205 };

	private List<int> once_3_fireDmg = new List<int> { 4029201, 4029202, 4029203, 4029204, 4029205 };

	private int lv_1;

	private int lv_2;

	private int lv_3;

	private int stage_1;

	private int stage_2;

	private int stage_3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_1, lv_1) = GetDiscInfo(214029, skillId_s1);
		(stage_2, lv_2) = GetDiscInfo(214029, skillId_s2);
		(stage_3, lv_3) = GetDiscInfo(214029, skillId_s3);
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
				actor.buffComponent.AddBuff(buffId_2_crit.get_Item(stage_2), actor);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && !actor.isAssist && actor.buffComponent.HaveBuffNumMax(buffId_1_mark.get_Item(stage_1)))
		{
			AdventureActor.AddFromAttr(once_3_fireDmg.get_Item(stage_3), actor);
		}
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorDamaged(actor, target, damageEvent);
		if (lv_1 > 0 && !(actor == null) && !(target == null) && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1_mark.get_Item(stage_1));
			target.buffComponent.RemoveBuffByBuffId(buffId_1_debuff.get_Item(stage_1));
			target.buffComponent.AddBuffNum(buffId_1_debuff.get_Item(stage_1), buffNumByID, actor);
		}
	}
}
