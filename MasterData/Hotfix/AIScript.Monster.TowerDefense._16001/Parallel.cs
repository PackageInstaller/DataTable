using System.Collections.Generic;
using Nova.Hotfix;

namespace AIScript.Monster.TowerDefense._16001;

public class Parallel : TowerCharacterParalletBase
{
	private List<int> buffList = new List<int>();

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1600107] = 25 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		buffList.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
	}

	private void OnSummonSpawned(IEvent evt)
	{
		if (!(evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent) || adventureMonsterSummonerSpawnedEvent.summonerId != _actor.Id)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureMonsterSummonerSpawnedEvent.sender as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || buffList.Count <= 0)
		{
			return;
		}
		foreach (int buff in buffList)
		{
			monsterAdventureActor.buffComponent.AddBuff(buff, monsterAdventureActor);
		}
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (!evt.isNew || evt.actorDataId != _actor.dataID)
		{
			return;
		}
		TowerDefensePotential towerDefensePotential = Singleton<HotfixDataController>.Instance.GetTowerDefensePotential(evt.perkId);
		if (towerDefensePotential == null || towerDefensePotential.Effect1 == 0)
		{
			return;
		}
		buffList.Add(towerDefensePotential.Effect1);
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(8016001);
		if (list != null && list.Count > 0)
		{
			MonsterAdventureActor monsterAdventureActor = list.get_Item(0) as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(towerDefensePotential.Effect1, monsterAdventureActor);
			}
		}
	}
}
