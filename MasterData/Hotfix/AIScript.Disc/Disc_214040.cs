using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214040 : DiscScriptBase
{
	private const int discId = 214040;

	private List<int> skillId_s1 = new List<int> { 404001, 404002, 404003, 404004, 404005, 404006 };

	private List<int> buffId_s1 = new List<int> { 4040001, 4040002, 4040003, 4040004, 4040005, 4040006 };

	private List<int> once_s1 = new List<int> { 4040007, 4040008, 4040009, 4040010, 4040011, 4040012 };

	private List<int> skillId_s3 = new List<int> { 4040201, 4040202, 4040203, 4040204, 4040205 };

	private List<int> buffId_s3 = new List<int> { 4040201, 4040202, 4040203, 4040204, 4040205 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s3;

	private int stage_s3;

	private int count;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		count = 0;
		(stage_s1, lv_s1) = GetDiscInfo(214040, skillId_s1);
		(stage_s3, lv_s3) = GetDiscInfo(214040, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && lv_s1 > 0 && lv_s3 > 0 && adventureActorRemoveBuff.sender is PlayerAdventureActor { isAssist: false } playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE && adventureActorRemoveBuff.eventInfo.buffId == buffId_s1.get_Item(stage_s1) && adventureActorRemoveBuff.eventInfo.removeType == BuffManager.BuffRemoveType.TimeFinish)
		{
			playerAdventureActor.buffComponent.AddBuffNum(buffId_s3.get_Item(stage_s3), count, playerAdventureActor);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.from != null && damageEvent.from is PlayerAdventureActor playerAdventureActor && damageEvent.to as MonsterAdventureActor != null && lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			playerAdventureActor.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), playerAdventureActor);
			count = playerAdventureActor.buffComponent.GetBuffNumByID(buffId_s1.get_Item(stage_s1));
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s1 > 0 && !actor.isAssist && actor.actorElementInfo.elementType == HotfixEnum.elementType.FE && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
		{
			int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_s1.get_Item(stage_s1));
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(once_s1.get_Item(stage_s1), actor, buffNumByID);
			}
		}
	}
}
