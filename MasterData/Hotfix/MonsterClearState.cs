public class MonsterClearState : ActorClearState
{
	protected override void DoClear()
	{
		AdventureMonsterClearSelfEvent adventureMonsterClearSelfEvent = AdventureMonsterClearSelfEvent.Generate();
		adventureMonsterClearSelfEvent.sender = _actor;
		SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor, add: false);
		AdventureActor actor = _actor;
		if (null != actor)
		{
			adventureMonsterClearSelfEvent.id = actor.Id;
			adventureMonsterClearSelfEvent.monsterID = actor.dataID;
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(actor.GroupId)?.RemoveMember(actor);
		}
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			MonsterInfo monsterInfo = monsterAdventureActor.monsterInfo;
			if (monsterInfo != null)
			{
				adventureMonsterClearSelfEvent.epicType = monsterInfo.epicType;
			}
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterClearSelfEvent);
		if (monsterAdventureActor != null && monsterAdventureActor.IsSummoned(out var summoner, out var _))
		{
			ModuleController<AdventureModuleController>.Instance?.AddMonsterSummons(monsterAdventureActor, monsterAdventureActor.Id, summoner.Id, summoner is PlayerAdventureActor, iDead: true, iAdd: false);
		}
		base.DoClear();
	}

	protected override void FinishClear()
	{
		base.FinishClear();
	}
}
