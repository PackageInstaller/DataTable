using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214031 : DiscScriptBase
{
	private const int discId = 214031;

	private readonly List<int> skillId_s1 = new List<int> { 4031000, 4031001, 4031002, 4031003, 4031004 };

	private readonly List<int> buffId_1 = new List<int> { 4031000, 4031001, 4031002, 4031003, 4031004 };

	private readonly List<FP> hpPercentls = new List<FP> { 0.6, 0.6, 0.6, 0.6, 0.6 };

	private readonly List<int> onceId_ls = new List<int> { 2020, 2020, 2020, 2020, 2020 };

	private List<int> skillId_s2 = new List<int> { 40311 };

	private List<int> once_2 = new List<int> { 0, 0, 0, 0, 0 };

	private List<int> skillId_s3 = new List<int> { 40311 };

	private List<int> buff_3_atk = new List<int> { 4031000, 4031001, 4031002, 4031003, 4031004 };

	private List<int> buff_3_hp = new List<int> { 4031000, 4031001, 4031002, 4031003, 4031004 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected bool iState => _actor.actorHealthInfo.hpPercentage >= hpPercentls.get_Item(stage_s1);

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214031, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214031, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214031, skillId_s3);
		if (lv_s1 > 0)
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
				{
					playerAdventureActor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), playerAdventureActor);
				}
			}
		}
		if (lv_s3 <= 0 || !iState)
		{
			return;
		}
		for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buff_3_atk.get_Item(stage_s3), playerAdventureActor2);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (iState && lv_s2 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && target != null && (target.IsBossMonster() || target.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
		{
			AdventureActor.AddFromAttr(once_2.get_Item(stage_s2), actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (damageEvent.from is MonsterAdventureActor fromActor && damageEvent.to is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && lv_s2 > 0 && iState)
		{
			AdventureActor.AddFromAttr(once_2.get_Item(stage_s2), fromActor);
		}
	}

	protected override void OnLevelSuccess()
	{
		base.OnLevelSuccess();
		if (lv_s3 >= 1)
		{
			_actor.buffComponent.AddBuff(buff_3_hp.get_Item(stage_s3), _actor);
		}
	}
}
