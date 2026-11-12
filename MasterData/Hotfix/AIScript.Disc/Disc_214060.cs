using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214060 : DiscScriptBase
{
	private const int discId = 214060;

	private const int gloryThreshold_10 = 10;

	private const int gloryThreshold_20 = 20;

	private List<int> skillId_s1 = new List<int> { 406001, 406002, 406003, 406004, 406005, 406006 };

	private List<int> buffId_1 = new List<int> { 4060000, 4060000, 4060000, 4060000, 4060000, 4060000 };

	private List<int> onceId_1_wind = new List<int> { 4060011, 4060012, 4060013, 4060014, 4060015, 4060016 };

	private List<int> onceId_1_normal = new List<int> { 4060021, 4060022, 4060023, 4060024, 4060025, 4060026 };

	private List<int> skillId_s2 = new List<int> { 4060101, 4060102, 4060103, 4060104, 4060105 };

	private List<int> onceId_2 = new List<int> { 4060111, 4060112, 4060113, 4060114, 4060115 };

	private List<int> skillId_s3 = new List<int> { 4060201, 4060202, 4060203, 4060204, 4060205 };

	private List<int> onceId_3 = new List<int> { 4060211, 4060212, 4060213, 4060214, 4060215 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214060, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214060, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214060, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && IsWindBalance(actor) && (damageEvent.damageType == HotfixEnum.damageType.NORMAL || damageEvent.damageType == HotfixEnum.damageType.SKILL) && IsWind(_actor))
		{
			_actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), _actor);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0)
		{
			int num = (IsWind(_actor) ? _actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1)) : 0);
			if (num >= 10)
			{
				AdventureActor.AddFromAttr(onceId_1_wind.get_Item(stage_s1), actor);
			}
			if (num >= 20 && IsWind(actor) && damageEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				AdventureActor.AddFromAttr(onceId_1_normal.get_Item(stage_s1), actor);
			}
			if (lv_s2 > 0 && actor == _actor && damageEvent.damageType == HotfixEnum.damageType.SKILL && num > 0)
			{
				AdventureActor.AddFromAttr(onceId_2.get_Item(stage_s2), actor, num);
			}
			if (lv_s3 > 0 && IsWind(actor) && IsWind(_actor) && _actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
			{
				AdventureActor.AddFromAttr(onceId_3.get_Item(stage_s3), actor);
			}
		}
	}

	private bool IsWind(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE;
		}
		return false;
	}

	private bool IsWindBalance(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance;
		}
		return false;
	}
}
