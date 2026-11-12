using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Disc;

public class Disc_214041 : DiscScriptBase
{
	private const int discId = 214041;

	private List<int> skillId_s1 = new List<int> { 404101, 404102, 404103, 404104, 404105, 404106 };

	private List<int> buffId_s1 = new List<int> { 4041021, 4041022, 4041023, 4041024, 4041025, 4041026 };

	private List<int> skillId_s3 = new List<int> { 4041201, 4041202, 4041203, 4041204, 4041205 };

	private List<int> buffId_s3 = new List<int> { 4041201, 4041202, 4041203, 4041204, 4041205 };

	private int count_s3 = 2;

	private int lv_s1;

	private int stage_s1;

	private int lv_s3;

	private int stage_s3;

	private int summonCount_s1;

	private int summonCount_s3;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		(int, int) discInfo = GetDiscInfo(214041, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214041, skillId_s3);
		stage_s3 = discInfo.Item1;
		lv_s3 = discInfo.Item2;
		summonCount_s1 = 0;
		summonCount_s3 = 0;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		monsters.Clear();
	}

	private void OnActorSpawned(IEvent _evt)
	{
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)_evt;
		if (adventurActorSpawned == null || !(adventurActorSpawned.sender is MonsterAdventureActor entity) || !entity.IsPlayerMinion(out var summoner))
		{
			return;
		}
		if (lv_s1 > 0 && summoner.isAssist && summoner.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			summonCount_s1++;
			if (summonCount_s1 > 0)
			{
				CommonUtils.GetAllSummons(monsters);
				for (int i = 0; i < monsters.Count; i++)
				{
					if (monsters.get_Item(i).IsPlayerMinion(out var summoner2) && summoner2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
					{
						monsters.get_Item(i).buffComponent.AddBuff(buffId_s1.get_Item(stage_s1), monsters.get_Item(i));
					}
				}
			}
		}
		if (lv_s3 <= 0 || summoner.actorElementInfo.elementType != HotfixEnum.elementType.FE)
		{
			return;
		}
		summonCount_s3++;
		if (summonCount_s3 < count_s3)
		{
			return;
		}
		for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_s3.get_Item(stage_s3), summoner);
			}
		}
	}

	protected override void OnActorDied(AdventureActorDiedEvent evt)
	{
		if (!(evt.actor is MonsterAdventureActor entity) || !entity.IsPlayerMinion(out var summoner))
		{
			return;
		}
		if (lv_s1 > 0 && summoner.isAssist && summoner.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			summonCount_s1--;
			if (summonCount_s1 <= 0)
			{
				CommonUtils.GetAllSummons(monsters);
				for (int i = 0; i < monsters.Count; i++)
				{
					MonsterAdventureActor monsterAdventureActor = monsters.get_Item(i);
					if (monsterAdventureActor.IsPlayerMinion(out var summoner2) && summoner2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
					{
						monsterAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_s1.get_Item(stage_s1));
					}
				}
			}
		}
		if (lv_s3 <= 0 || summoner.actorElementInfo.elementType != HotfixEnum.elementType.FE)
		{
			return;
		}
		summonCount_s3--;
		if (summonCount_s3 >= count_s3)
		{
			return;
		}
		for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buffId_s3.get_Item(stage_s3));
			}
		}
	}
}
