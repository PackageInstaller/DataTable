using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214004 : DiscScriptBase
{
	private const int discId = 214004;

	private List<int> skillId_s1 = new List<int> { 400401, 400402, 400403, 400404, 400405, 400406 };

	private List<int> buffId_s1 = new List<int> { 4004020, 4004020, 4004020, 4004020, 4004020, 4004020 };

	private List<int> buffId_s1_Dmg = new List<int> { 4004021, 4004022, 4004023, 4004024, 4004025, 4004026 };

	private List<int> buffId_s1_Hurt = new List<int> { 4004041, 4004042, 4004043, 4004044, 4004045, 4004046 };

	private List<int> skillId_s2 = new List<int> { 4004101, 4004102, 4004103, 4004104, 4004105 };

	private List<int> buffId_s2 = new List<int> { 4004101, 4004102, 4004103, 4004104, 4004105 };

	private List<int> skillId_s3 = new List<int> { 4004201, 4004202, 4004203, 4004204, 4004205 };

	private List<int> buffId_s3 = new List<int> { 4004201, 4004202, 4004203, 4004204, 4004205 };

	private int lv_s1;

	private int stage_s1;

	private int lv_s2;

	private int stage_s2;

	private int lv_s3;

	private int stage_s3;

	private CoroutineNode corBuff;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		(stage_s1, lv_s1) = GetDiscInfo(214004, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214004, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214004, skillId_s3);
		if (lv_s2 > 0 && mainCtrActor != null && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			StartCoroutine(ref corBuff, DoAddBuff());
		}
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
		if (adventurActorSpawned == null)
		{
			return;
		}
		AdventureActor adventureActor = adventurActorSpawned.sender as AdventureActor;
		if (lv_s1 <= 0 || !(adventureActor is MonsterAdventureActor monsterAdventureActor) || !adventureActor.IsPlayerMinion(out var summoner))
		{
			return;
		}
		if (summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), summoner);
			if (lv_s3 > 0)
			{
				mainCtrActor.buffComponent.AddBuff(buffId_s3.get_Item(stage_s3), summoner);
			}
		}
		if (summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && summoner == mainCtrActor)
		{
			int buffNumByID = mainCtrActor.buffComponent.GetBuffNumByID(buffId_s1.get_Item(stage_s1));
			monsterAdventureActor.buffComponent.AddBuffNum(buffId_s1_Dmg.get_Item(stage_s1), buffNumByID, summoner);
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (lv_s1 > 0 && damageEvent.from is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.IsPlayerMinion(out var summoner) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && mainCtrActor.buffComponent.CheckBuffByBuffID(buffId_s1.get_Item(stage_s1)) && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE && damageEvent.to is MonsterAdventureActor monsterAdventureActor2)
		{
			monsterAdventureActor2.buffComponent.AddBuff(buffId_s1_Hurt.get_Item(stage_s1), monsterAdventureActor);
		}
	}

	private IEnumerator DoAddBuff()
	{
		bool isBuffAdd = false;
		while (true)
		{
			if (mainCtrActor != null && mainCtrActor.buffComponent.CheckBuffByBuffID(buffId_s1.get_Item(stage_s1)))
			{
				if (!isBuffAdd)
				{
					isBuffAdd = true;
					for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
					{
						PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
						if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
						{
							playerAdventureActor.buffComponent.AddBuff(buffId_s2.get_Item(stage_s2), _actor);
						}
					}
				}
			}
			else if (isBuffAdd)
			{
				isBuffAdd = false;
				for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
				{
					PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
					if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.DE)
					{
						playerAdventureActor2.buffComponent.RemoveBuffByBuffId(buffId_s2.get_Item(stage_s2));
					}
				}
			}
			yield return null;
		}
	}
}
