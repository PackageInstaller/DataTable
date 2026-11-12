using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214013 : DiscScriptBase
{
	private const int discId = 214013;

	private List<int> skillId_s1 = new List<int> { 4013000, 4013001, 4013002, 4013003, 4013004 };

	private List<int> buff_s1v1_1 = new List<int> { 4013000, 4013001, 4013002, 4013003, 4013004 };

	private List<int> buff_s1v1_2 = new List<int> { 4013005, 4013005, 4013005, 4013005, 4013005 };

	private int once_s1v2 = 2019;

	private int buff_s1v3 = 4013006;

	private int lv_s1;

	private int stage_s1;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214013, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (lv_s1 >= 1 && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s1v1_1.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		PlayerAdventureActor playerAdventureActor = damageEvent.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (!(playerAdventureActor == null) && !(monsterAdventureActor == null) && lv_s1 >= 2 && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
		{
			AdventureActor.AddFromAttr(once_s1v2, playerAdventureActor);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.from as PlayerAdventureActor;
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (!(playerAdventureActor == null) && !(monsterAdventureActor == null) && lv_s1 >= 3 && playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
		{
			monsterAdventureActor.buffComponent.AddBuff(buff_s1v3, playerAdventureActor);
		}
	}

	protected override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		if (lv_s1 >= 1)
		{
			PlayerAdventureActor player = evt.player;
			if (player.isAssist && player.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				player.buffComponent.AddBuff(buff_s1v1_2.get_Item(stage_s1), player);
			}
		}
	}

	protected override void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
		if (lv_s1 >= 1)
		{
			PlayerAdventureActor player = evt.player;
			if (player.isAssist && player.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				player.buffComponent.RemoveBuffByBuffId(buff_s1v1_2.get_Item(stage_s1));
			}
		}
	}
}
