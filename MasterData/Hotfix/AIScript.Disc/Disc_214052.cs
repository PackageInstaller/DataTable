using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214052 : DiscScriptBase
{
	private const int discId = 214052;

	private List<int> skillId_s1 = new List<int> { 405201, 405202, 405203, 405204, 405205, 405206 };

	private List<int> buffId_1 = new List<int> { 4052000, 4052000, 4052000, 4052000, 4052000, 4052000 };

	private List<int> onceId_1 = new List<int> { 4052001, 4052002, 4052003, 4052004, 4052005, 4052006 };

	private List<int> buffId_1_atk = new List<int> { 4052021, 4052022, 4052023, 4052024, 4052025, 4052026 };

	private List<int> skillId_s2 = new List<int> { 4052101, 4052102, 4052103, 4052104, 4052105 };

	private List<int> buffId_2_1 = new List<int> { 4052121, 4052122, 4052123, 4052124, 4052125 };

	private List<int> buffId_2_2 = new List<int> { 4052141, 4052142, 4052143, 4052144, 4052145 };

	private List<int> skillId_s3 = new List<int> { 4052201, 4052202, 4052203, 4052204, 4052205 };

	private List<int> buffId_3_kla = new List<int> { 4052200, 4052200, 4052200, 4052200, 4052200, 4052200 };

	private List<int> onceId_3 = new List<int> { 4052201, 4052202, 4052203, 4052204, 4052205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private int _activeKlaBuffId;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214052, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214052, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214052, skillId_s3);
		if (lv_s1 > 0)
		{
			_activeKlaBuffId = ((lv_s3 > 0) ? buffId_3_kla.get_Item(stage_s1) : buffId_1.get_Item(stage_s1));
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s1 > 0 && IsEarthVanguard(actor) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			actor.buffComponent.AddBuff(_activeKlaBuffId, actor);
			if (lv_s2 > 0)
			{
				int buffID = ((lv_s3 > 0) ? buffId_2_2.get_Item(stage_s2) : buffId_2_1.get_Item(stage_s2));
				actor.buffComponent.AddBuff(buffID, actor);
			}
			if (actor.buffComponent.GetBuffNumByID(_activeKlaBuffId) >= 2)
			{
				actor.buffComponent.AddBuff(buffId_1_atk.get_Item(stage_s1), actor);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && IsEarthVanguard(actor))
		{
			if (damageEvent.damageType == HotfixEnum.damageType.SKILL && actor.buffComponent.GetBuffNumByID(_activeKlaBuffId) >= 1)
			{
				AdventureActor.AddFromAttr(onceId_1.get_Item(stage_s1), actor);
			}
			if (lv_s3 > 0 && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE && actor.buffComponent.GetBuffNumByID(_activeKlaBuffId) >= 3)
			{
				AdventureActor.AddFromAttr(onceId_3.get_Item(stage_s3), actor);
			}
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
