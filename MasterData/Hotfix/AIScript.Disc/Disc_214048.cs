using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214048 : DiscScriptBase
{
	private const int discId = 214048;

	private List<int> skillId_s1 = new List<int> { 404801, 404802, 404803, 404804, 404805, 404806 };

	private Dictionary<int, List<int>> dicBuff_s1 = new Dictionary<int, List<int>>
	{
		[0] = new List<int> { 4048010, 4048010, 4048010, 4048010, 4048010, 4048010 },
		[1] = new List<int> { 4048011, 4048011, 4048011, 4048011, 4048011, 4048011 },
		[2] = new List<int> { 4048012, 4048012, 4048012, 4048012, 4048012, 4048012 }
	};

	private int buffTag_s1 = CommonHelper.StringToHash("Carol");

	private List<int> buff_s1 = new List<int> { 4048013, 4048013, 4048013, 4048013, 4048013, 4048013 };

	private List<int> buffId_s1_2 = new List<int> { 4048021, 4048022, 4048023, 4048024, 4048025, 4048026 };

	private List<int> skillId_s2 = new List<int> { 4048101, 4048102, 4048103, 4048104, 4048105 };

	private List<int> buffId_s2_1 = new List<int> { 4048101, 4048102, 4048103, 4048104, 4048105 };

	private List<int> buffId_s2_2 = new List<int> { 4048121, 4048122, 4048123, 4048124, 4048125 };

	private List<int> skillId_s3 = new List<int> { 4048201, 4048202, 4048203, 4048204, 4048205 };

	private List<int> buffId_s3 = new List<int> { 4048201, 4048202, 4048203, 4048204, 4048205 };

	private List<int> once_s3 = new List<int> { 4048221, 4048222, 4048223, 4048224, 4048225 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	private int lv_s3;

	private int stage_s3;

	private Dictionary<long, List<int>> dicPlayer = new Dictionary<long, List<int>>();

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		(stage_s1, lv_s1) = GetDiscInfo(214048, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214048, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214048, skillId_s3);
		if (lv_s1 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				dicPlayer.Add(playerAdventureActor.Id, dicBuff_s1.get_Item(i));
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		dicPlayer.Clear();
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		if (lv_s3 > 0 && damageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE && damageEvent.to is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(buffTag_s1))
		{
			AdventureActor.AddFromAttr(once_s3.get_Item(stage_s3), playerAdventureActor);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (lv_s1 <= 0)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return;
		}
		if (damageEvent.from != null && damageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE && damageEvent.damageType == HotfixEnum.damageType.SKILL && dicPlayer.TryGetValue(playerAdventureActor.Id, out var value))
		{
			if (!monsterAdventureActor.buffComponent.CheckBuffByBuffID(value.get_Item(stage_s1)))
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_s1.get_Item(stage_s1), playerAdventureActor);
				if (lv_s3 > 0)
				{
					monsterAdventureActor.buffComponent.AddBuff(buffId_s3.get_Item(stage_s3), playerAdventureActor);
				}
			}
			monsterAdventureActor.buffComponent.AddBuff(value.get_Item(stage_s1), playerAdventureActor);
		}
		if (!(damageEvent.from != null) || !(damageEvent.from is MonsterAdventureActor entity) || !entity.IsPlayerMinion(out var summoner) || damageEvent.damageType != HotfixEnum.damageType.SUMMON || !dicPlayer.TryGetValue(summoner.Id, out var value2))
		{
			return;
		}
		int buffID = value2.get_Item(stage_s1);
		if (!monsterAdventureActor.buffComponent.CheckBuffByBuffID(buffID))
		{
			return;
		}
		monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffID);
		monsterAdventureActor.buffComponent.AddBuff(buffId_s1_2.get_Item(stage_s1), summoner);
		if (lv_s2 > 0)
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_s2_1.get_Item(stage_s2), summoner);
		}
		if (lv_s2 <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buffId_s2_2.get_Item(stage_s2), summoner);
			}
		}
	}

	private void OnBuffRemove(IEvent evt)
	{
		if (!(evt is AdventureActorRemoveBuff { sender: MonsterAdventureActor sender } adventureActorRemoveBuff))
		{
			return;
		}
		if (adventureActorRemoveBuff.eventInfo.buffTags.Contains(buffTag_s1))
		{
			sender.buffComponent.RemoveBuffByBuffId(buff_s1.get_Item(stage_s1), 1);
			if (lv_s3 > 0)
			{
				sender.buffComponent.RemoveBuffByBuffId(buffId_s3.get_Item(stage_s3), 1);
			}
		}
		else if (adventureActorRemoveBuff.eventInfo.buffId == buffId_s1_2.get_Item(stage_s1) && lv_s2 > 0)
		{
			sender.buffComponent.RemoveBuffByBuffId(buffId_s2_1.get_Item(stage_s2));
		}
	}
}
