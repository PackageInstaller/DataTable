using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214043 : DiscScriptBase
{
	private const int discId = 214043;

	private readonly int lockedTag = CommonHelper.StringToHash("DarkAnZhuo");

	private List<int> skillId_s1 = new List<int> { 404301, 404302, 404303, 404304, 404305, 404306 };

	private List<int> buffId_s1 = new List<int> { 4043021, 4043022, 4043023, 4043024, 4043025, 4043026 };

	private List<int> skillId_s2 = new List<int> { 4043101, 4043102, 4043103, 4043104, 4043105 };

	private List<int> buffId_s2 = new List<int> { 4043101, 4043102, 4043103, 4043104, 4043105 };

	private List<int> skillId_s3 = new List<int> { 4043201, 4043202, 4043203, 4043204, 4043205 };

	private List<int> once_s3 = new List<int> { 4043201, 4043202, 4043203, 4043204, 4043205 };

	private List<int> once_s3_1 = new List<int> { 4043221, 4043222, 4043223, 4043224, 4043225 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	private int lv_s3;

	private int stage_s3;

	private CoroutineNode corBuff;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		(stage_s1, lv_s1) = GetDiscInfo(214043, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214043, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214043, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		StopCoroutine(ref corBuff);
	}

	private void OnActorSpawned(IEvent _evt)
	{
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)_evt;
		if (adventurActorSpawned != null)
		{
			AdventureActor adventureActor = adventurActorSpawned.sender as AdventureActor;
			if (lv_s1 > 0 && adventureActor is MonsterAdventureActor monsterAdventureActor && adventureActor.IsPlayerMinion(out var summoner) && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && summoner == mainCtrActor)
			{
				mainCtrActor.buffComponent.GetBuffNumByID(buffId_s1.get_Item(stage_s1));
				monsterAdventureActor.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), summoner);
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s3 > 0 && damageEvent.from is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.IsPlayerMinion(out var summoner) && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && summoner == mainCtrActor && damageEvent.to is MonsterAdventureActor monsterAdventureActor2 && monsterAdventureActor2.buffComponent.CheckBuffByBuffTag(lockedTag))
		{
			AdventureActor.AddFromAttr(once_s3_1.get_Item(stage_s3), monsterAdventureActor);
		}
	}

	protected override void OnBeforeMainPlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor monster, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s3 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.DE && damageEvent.damageType == HotfixEnum.damageType.SKILL && monster.buffComponent.CheckBuffByBuffTag(lockedTag))
		{
			AdventureActor.AddFromAttr(once_s3.get_Item(stage_s3), actor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		if (lv_s2 <= 0 || evt.markTriggerType != HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1 || evt.triggerActor.actorElementInfo.elementType != HotfixEnum.elementType.DE)
		{
			return;
		}
		CommonUtils.GetAllSummons(monsters);
		for (int i = 0; i < monsters.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsters.get_Item(i);
			if (monsterAdventureActor.IsPlayerMinion(out var summoner) && summoner == evt.triggerActor)
			{
				monsterAdventureActor.buffComponent.AddBuff(buffId_s2.get_Item(stage_s2), monsterAdventureActor);
			}
		}
	}
}
