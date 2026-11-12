using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214009 : DiscScriptBase
{
	private const int discId = 214009;

	private List<int> buffId_wind = new List<int> { 4009000, 4009001, 4009002, 4009003, 4009004 };

	private List<int> skillId_s1 = new List<int> { 4009000, 4009001, 4009002, 4009003, 4009004 };

	private const int buffId_tag = 4009099;

	private readonly int cd_tag = 8;

	private const int onece_id = 2008;

	private List<int> skillId_s2 = new List<int> { 40091, 0, 0, 0, 0 };

	private int buffId_s2 = 4009100;

	private List<int> skillId_s3 = new List<int> { 40092, 0, 0, 0, 0 };

	private int buffId_s3 = 4009200;

	private int shieldId_s3 = 4009201;

	private FP currenCD;

	private int skillLevel_1;

	private int skillLevel_2;

	private int skillLevel_3;

	private bool behit;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		currenCD = 0;
		behit = false;
		(int, int) discInfo = GetDiscInfo(214009, skillId_s1);
		int item = discInfo.Item1;
		skillLevel_1 = discInfo.Item2;
		skillLevel_2 = GetDiscInfo(214009, skillId_s2).Item2;
		skillLevel_3 = GetDiscInfo(214009, skillId_s3).Item2;
		if (skillLevel_1 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_wind.get_Item(item), _actor);
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
		if (skillLevel_1 >= 1 && actor.actorElementInfo.elementType == HotfixEnum.elementType.AE && target.buffComponent.CheckBuffByBuffID(4009099))
		{
			AdventureActor.AddFromAttr(2008, actor);
		}
	}

	protected override void OnToughnessState(MonsterToughnessStateChangeEvent evt)
	{
		base.OnToughnessState(evt);
		if (skillLevel_2 >= 1 && evt.isToughnessBroken && evt.actor.buffComponent.CheckBuffByBuffID(4009099))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_s2, _actor);
		}
	}

	protected override void OnActorDied(AdventureActorDiedEvent evt)
	{
		base.OnActorDied(evt);
		if (skillLevel_2 >= 1 && evt.actor.buffComponent.CheckBuffByBuffID(4009099))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_s2, _actor);
		}
	}

	protected override void OnMainPlayerActorReceiveDamage(AdventureActor damageSource, PlayerAdventureActor actor, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorReceiveDamage(damageSource, actor, damageEvent);
		if (!behit && skillLevel_3 >= 1)
		{
			behit = true;
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_s3, _actor);
			actor.actorShield.AddShield(shieldId_s3, _actor);
		}
	}

	public void OnUpdate()
	{
		if (skillLevel_1 < 1 || cd_tag < 0)
		{
			return;
		}
		currenCD += _actor.LogicDeltaTime;
		if (currenCD > cd_tag)
		{
			currenCD = 0;
			List<LogicEntity> hearRangeSearch = ILRuntimeAPI.GetHearRangeSearch(_actor);
			if (hearRangeSearch != null && hearRangeSearch.Count > 0)
			{
				(hearRangeSearch.get_Item(TSRandom.Range(0, hearRangeSearch.Count)) as AdventureActor).buffComponent.AddBuff(4009099, _actor);
			}
		}
	}
}
