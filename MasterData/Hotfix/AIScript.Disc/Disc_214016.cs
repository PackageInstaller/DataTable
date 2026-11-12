using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214016 : DiscScriptBase
{
	private const int discId = 214016;

	private List<int> skillId_s1 = new List<int> { 401601, 401602, 401603, 401604, 401605, 401606 };

	private List<int> buffId_1 = new List<int> { 4016000, 4016000, 4016000, 4016000, 4016000, 4016000 };

	private List<int> buffId_1_atk = new List<int> { 4016001, 4016002, 4016003, 4016004, 4016005, 4016006 };

	private List<int> buffId_1_skill = new List<int> { 4016021, 4016022, 4016023, 4016024, 4016025, 4016026 };

	private List<int> skillId_s2 = new List<int> { 4016101, 4016102, 4016103, 4016104, 4016105 };

	private List<int> buffId_2 = new List<int> { 4016121, 4016122, 4016123, 4016124, 4016125 };

	private List<int> skillId_s3 = new List<int> { 4016201, 4016202, 4016203, 4016204, 4016205 };

	private List<int> buffId_3 = new List<int> { 4016201, 4016202, 4016203, 4016204, 4016205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnProactiveReduceSkillSection);
		(stage_s1, lv_s1) = GetDiscInfo(214016, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214016, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214016, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnProactiveReduceSkillSection);
	}

	private void OnProactiveReduceSkillSection(IEvent evt)
	{
		if (evt is AdventureActorProactiveReduceSkillSectionEvent { skillEventInfo: not null, sender: PlayerAdventureActor sender } adventureActorProactiveReduceSkillSectionEvent && lv_s1 > 0 && !sender.isAssist && sender.actorElementInfo.elementType == HotfixEnum.elementType.AE && adventureActorProactiveReduceSkillSectionEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			sender.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), sender);
			if (lv_s2 > 0)
			{
				sender.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), sender);
			}
			if (lv_s3 > 0)
			{
				sender.buffComponent.AddBuff(buffId_3.get_Item(stage_s3), sender);
			}
		}
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		PlayerAdventureActor playerAdventureActor = castSkillEvent.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && lv_s1 > 0 && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			playerAdventureActor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), playerAdventureActor);
			if (lv_s2 > 0)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), playerAdventureActor);
			}
			if (lv_s3 > 0)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_3.get_Item(stage_s3), playerAdventureActor);
			}
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (!(damageEvent.from != null) || !(damageEvent.from is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || lv_s1 <= 0 || !playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId_1.get_Item(stage_s1)))
		{
			return;
		}
		int buffNum = playerAdventureActor.buffComponent.GetBuffNum(buffId_1.get_Item(stage_s1), 0);
		if (buffNum > 0)
		{
			if (damageEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_1_atk.get_Item(stage_s1));
				monsterAdventureActor.buffComponent.AddBuffNum(buffId_1_atk.get_Item(stage_s1), buffNum, playerAdventureActor);
			}
			else if (damageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_1_skill.get_Item(stage_s1));
				monsterAdventureActor.buffComponent.AddBuffNum(buffId_1_skill.get_Item(stage_s1), buffNum, playerAdventureActor);
			}
		}
	}
}
