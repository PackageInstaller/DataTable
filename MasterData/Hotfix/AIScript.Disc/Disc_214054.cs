using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214054 : DiscScriptBase
{
	private const int discId = 214054;

	private List<int> skillId_s1 = new List<int> { 405401, 405402, 405403, 405404, 405405, 405406 };

	private List<int> buffId_1 = new List<int> { 4054000, 4054000, 4054000, 4054000, 4054000, 4054000 };

	private List<int> debuffId_1 = new List<int> { 4054001, 4054002, 4054003, 4054004, 4054005, 4054006 };

	private List<int> onceId_1 = new List<int> { 4054021, 4054022, 4054023, 4054024, 4054025, 4054026 };

	private List<int> skillId_s2 = new List<int> { 4054101, 4054102, 4054103, 4054104, 4054105 };

	private List<int> buffId_2_1 = new List<int> { 4054121, 4054122, 4054123, 4054124, 4054125 };

	private List<int> buffId_2_2 = new List<int> { 4054141, 4054142, 4054143, 4054144, 4054145 };

	private List<int> skillId_s3 = new List<int> { 4054201, 4054202, 4054203, 4054204, 4054205 };

	private List<int> buffId_3_spa = new List<int> { 4054200, 4054200, 4054200, 4054200, 4054200, 4054200 };

	private List<int> buffId_3_atk = new List<int> { 4054201, 4054202, 4054203, 4054204, 4054205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private int _activeSpaBuffId;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214054, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214054, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214054, skillId_s3);
		if (lv_s1 > 0)
		{
			_activeSpaBuffId = ((lv_s3 > 0) ? buffId_3_spa.get_Item(stage_s1) : buffId_1.get_Item(stage_s1));
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnPlayerActorCastSkillEnd(PlayerAdventureActor actor, AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkillEnd(actor, castSkillEvent);
		if (lv_s1 > 0 && IsEarthVanguard(actor) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			actor.buffComponent.AddBuff(_activeSpaBuffId, actor);
			if (lv_s2 > 0)
			{
				int buffID = ((lv_s3 > 0) ? buffId_2_2.get_Item(stage_s2) : buffId_2_1.get_Item(stage_s2));
				actor.buffComponent.AddBuff(buffID, actor);
			}
			if (lv_s3 > 0 && actor.buffComponent.GetBuffNumByID(_activeSpaBuffId) >= 3)
			{
				actor.buffComponent.AddBuff(buffId_3_atk.get_Item(stage_s3), actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && IsEarthVanguard(actor) && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.buffComponent.GetBuffNumByID(_activeSpaBuffId) >= 1)
		{
			target.buffComponent.AddBuff(debuffId_1.get_Item(stage_s1), actor);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && IsEarthVanguard(actor) && damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.buffComponent.GetBuffNumByID(_activeSpaBuffId) >= 2)
		{
			AdventureActor.AddFromAttr(onceId_1.get_Item(stage_s1), actor);
		}
	}

	private bool IsEarthVanguard(AdventureActor actor)
	{
		if (actor == null)
		{
			return false;
		}
		PlayerAdventureActor playerAdventureActor = actor as PlayerAdventureActor;
		if (playerAdventureActor == null)
		{
			return false;
		}
		if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard;
		}
		return false;
	}
}
