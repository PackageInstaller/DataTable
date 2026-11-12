using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214057 : DiscScriptBase
{
	private const int discId = 214057;

	private int buffTag_Dark = CommonHelper.StringToHash("DarkAnZhuo");

	private List<int> skillId_s1 = new List<int> { 405701, 405702, 405703, 405704, 405705, 405706 };

	private List<int> buffId_1 = new List<int> { 4057000, 4057000, 4057000, 4057000, 4057000, 4057000 };

	private List<int> debuffId_1 = new List<int> { 4057001, 4057002, 4057003, 4057004, 4057005, 4057006 };

	private List<int> debuffId_2 = new List<int> { 4057021, 4057022, 4057023, 4057024, 4057025, 4057026 };

	private List<int> skillId_s2 = new List<int> { 4057101, 4057102, 4057103, 4057104, 4057105 };

	private List<int> onceId_2 = new List<int> { 4057101, 4057102, 4057103, 4057104, 4057105 };

	private List<int> buffId_2 = new List<int> { 4057121, 4057122, 4057123, 4057124, 4057125 };

	private List<int> skillId_s3 = new List<int> { 4057201, 4057202, 4057203, 4057204, 4057205 };

	private List<int> onceId_3 = new List<int> { 4057201, 4057202, 4057203, 4057204, 4057205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214057, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214057, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214057, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
		{
			actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s2 > 0)
			{
				actor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 <= 0)
		{
			return;
		}
		int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
		if (buffNumByID > 0)
		{
			if (damageEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				target.buffComponent.RemoveBuffByBuffId(debuffId_1.get_Item(stage_s1));
				target.buffComponent.AddBuffNum(debuffId_1.get_Item(stage_s1), buffNumByID, actor);
			}
			else if (damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				target.buffComponent.RemoveBuffByBuffId(debuffId_2.get_Item(stage_s1));
				target.buffComponent.AddBuffNum(debuffId_2.get_Item(stage_s1), buffNumByID, actor);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (actor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			if (lv_s2 > 0 && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE && target.buffComponent.CheckBuffByBuffTag(buffTag_Dark))
			{
				AdventureActor.AddFromAttr(onceId_2.get_Item(stage_s2), actor);
			}
			if (lv_s3 > 0 && damageEvent.damageType == HotfixEnum.damageType.NORMAL && (target.IsBossMonster() || target.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
			{
				AdventureActor.AddFromAttr(onceId_3.get_Item(stage_s3), actor);
			}
		}
	}
}
