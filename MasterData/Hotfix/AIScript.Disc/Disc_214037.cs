using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214037 : DiscScriptBase
{
	private const int discId = 214037;

	private List<int> skillId_s1 = new List<int> { 403701, 403702, 403703, 403704, 403705, 403706 };

	private List<int> buff_1_dmg = new List<int> { 4037027, 4037028, 4037029, 4037030, 4037031, 4037032 };

	private List<int> skillId_s2 = new List<int> { 4037101, 4037102, 4037103, 4037104, 4037105 };

	private List<int> buff_2_dmg = new List<int> { 4037101, 4037102, 4037103, 4037104, 4037105 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214037, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214037, skillId_s2);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	private void OnHpChanged(IEvent evt)
	{
		if (lv_s2 <= 0)
		{
			return;
		}
		AdventureActorHpChangedEvent adventureActorHpChangedEvent = (AdventureActorHpChangedEvent)evt;
		if (!(adventureActorHpChangedEvent.sender is PlayerAdventureActor playerAdventureActor) || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.SE || !adventureActorHpChangedEvent.isCovery)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buff_2_dmg.get_Item(stage_s2), _actor);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		if (evt.elementType == HotfixEnum.elementType.SE && lv_s1 > 0)
		{
			PlayerAdventureActor playerAdventureActor = evt.triggerActor as PlayerAdventureActor;
			MonsterAdventureActor monsterAdventureActor = evt.markActor as MonsterAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && monsterAdventureActor != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_1_dmg.get_Item(stage_s1), _actor);
			}
		}
	}
}
