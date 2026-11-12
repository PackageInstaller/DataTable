using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214017 : DiscScriptBase
{
	private const int discId = 214017;

	private List<int> skillId_s1 = new List<int> { 401701, 401702, 401703, 401704, 401705, 401706 };

	private List<int> buffId_s1_atk = new List<int> { 4017001, 4017002, 4017003, 4017004, 4017005, 4017006 };

	private List<int> maxCount_s1 = new List<int> { 10, 10, 10, 10, 10, 10 };

	private int buffId_s1_burn = 4017099;

	private List<int> buffId_s1_hurt = new List<int> { 4017021, 4017022, 4017023, 4017024, 4017025, 4017026 };

	private int count_s1_1 = 3;

	private int count_s1_2 = 1;

	private List<int> skillId_s3 = new List<int> { 4017201, 4017202, 4017203, 4017204, 4017205 };

	private List<int> buffId_s3_crit1 = new List<int> { 4017201, 4017202, 4017203, 4017204, 4017205 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s3;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_SHOOT_COST", AccumulateCostAmmo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		(stage_s1, lv_s1) = GetDiscInfo(214017, skillId_s1);
		(stage_s3, lv_s3) = GetDiscInfo(214017, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_SHOOT_COST", AccumulateCostAmmo);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		PlayerAdventureActor playerAdventureActor = castSkillEvent.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && lv_s1 > 0 && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			AddBuff(playerAdventureActor, count_s1_1);
		}
	}

	protected void AddBuff(PlayerAdventureActor player, int count)
	{
		player.buffComponent.AddBuffNum(buffId_s1_atk.get_Item(stage_s1), count, player);
		if (lv_s3 > 0)
		{
			player.buffComponent.AddBuffNum(buffId_s3_crit1.get_Item(stage_s3), count, player);
		}
	}

	private void AccumulateCostAmmo(IEvent evt)
	{
		if (lv_s1 > 0)
		{
			AdeventrueShootCost adeventrueShootCost = evt as AdeventrueShootCost;
			if (adeventrueShootCost.sender is PlayerAdventureActor { isAssist: false } playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				AddBuff(playerAdventureActor, adeventrueShootCost.cost * count_s1_2);
			}
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (lv_s1 > 0)
		{
			AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
			if (adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor && adventureActorGetBuff.eventInfo.buffId == buffId_s1_atk.get_Item(stage_s1) && playerAdventureActor.buffComponent.GetBuffNumByID(buffId_s1_atk.get_Item(stage_s1)) >= maxCount_s1.get_Item(stage_s1))
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_s1_burn, playerAdventureActor);
			}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (lv_s1 <= 0)
		{
			return;
		}
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor && adventureActorRemoveBuff.eventInfo.buffId == buffId_s1_burn)
		{
			playerAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_s1_atk.get_Item(stage_s1));
			if (lv_s3 > 0)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_s3_crit1.get_Item(stage_s3));
			}
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.from != null && damageEvent.from is PlayerAdventureActor playerAdventureActor)
		{
			MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null && lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.NORMAL && playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId_s1_burn))
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_s1_hurt.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}
}
