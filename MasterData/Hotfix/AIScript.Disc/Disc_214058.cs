using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Disc;

public class Disc_214058 : DiscScriptBase
{
	private const int discId = 214058;

	private List<int> skillId_s1 = new List<int> { 405801, 405802, 405803, 405804, 405805, 405806 };

	private List<int> buffId_1 = new List<int> { 4058000, 4058000, 4058000, 4058000, 4058000, 4058000 };

	private List<int> buffId_1_darkDmg = new List<int> { 4058021, 4058022, 4058023, 4058024, 4058025, 4058026 };

	private List<int> onceId_1_darkDmg = new List<int> { 4058021, 4058022, 4058023, 4058024, 4058025, 4058026 };

	private List<int> skillId_s2 = new List<int> { 4058101, 4058102, 4058103, 4058104, 4058105 };

	private List<int> buffId_2_1 = new List<int> { 4058101, 4058102, 4058103, 4058104, 4058105 };

	private List<int> onceId_2_2 = new List<int> { 4058121, 4058122, 4058123, 4058124, 4058125 };

	private List<int> skillId_s3 = new List<int> { 4058201, 4058202, 4058203, 4058204, 4058205 };

	private List<int> buffId_3 = new List<int> { 4058201, 4058202, 4058203, 4058204, 4058205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private readonly List<MonsterAdventureActor> _summons = new List<MonsterAdventureActor>();

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214058, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214058, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214058, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnMainPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s3 > 0)
			{
				actor.buffComponent.AddBuff(buffId_3.get_Item(stage_s3), actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE && actor.buffComponent.CheckBuffByBuffID(buffId_1.get_Item(stage_s1)))
		{
			bool isMax = lv_s2 > 0 && actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1));
			AddTeamDarkDamageBuff(isMax);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s2 > 0 && !(evt.triggerActor != _actor) && _actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1)
		{
			_actor.buffComponent.AddBuff(buffId_2_1.get_Item(stage_s2), _actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforeHit(damageEvent);
		if (!(damageEvent.from is AdventureActor adventureActor) || adventureActor.buffComponent == null)
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActor is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.DE)
			{
				return;
			}
		}
		else if (!adventureActor.IsPlayerMinion(out summoner) || summoner.actorElementInfo.elementType != HotfixEnum.elementType.DE)
		{
			return;
		}
		if (lv_s1 > 0 && adventureActor.buffComponent.CheckBuffByBuffID(buffId_1_darkDmg.get_Item(stage_s1)))
		{
			AdventureActor.AddFromAttr(onceId_1_darkDmg.get_Item(stage_s1), adventureActor);
		}
		if (lv_s2 > 0 && _actor != null && _actor.buffComponent != null && _actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
		{
			AdventureActor.AddFromAttr(onceId_2_2.get_Item(stage_s2), adventureActor);
		}
	}

	private void AddTeamDarkDamageBuff(bool isMax)
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (!(actorL == null) && !(actorL.buffComponent == null) && actorL.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				actorL.buffComponent.AddBuff(buffId_1_darkDmg.get_Item(stage_s1), actorL);
			}
		}
		_summons.Clear();
		CommonUtils.GetAllSummons(_summons);
		for (int i = 0; i < _summons.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = _summons.get_Item(i);
			if (!(monsterAdventureActor == null) && !(monsterAdventureActor.buffComponent == null) && monsterAdventureActor.IsPlayerMinion(out var summoner) && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_1_darkDmg.get_Item(stage_s1), monsterAdventureActor);
			}
		}
	}
}
