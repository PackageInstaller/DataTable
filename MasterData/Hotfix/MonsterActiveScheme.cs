using TrueSync;

public class MonsterActiveScheme : LogicComponent
{
	private enum MonsterActiveState
	{
		UnRef,
		Ref,
		Deactive,
		Active
	}

	private bool _deactived;

	private MonsterActiveState state;

	private bool forceActive;

	private MonsterAdventureActor _actor => (MonsterAdventureActor)Entity;

	public override void OnActive()
	{
		_deactived = false;
	}

	public void UpdateLogic(LogicEntity activePlayerActor)
	{
		if (_actor.actorHealthInfo.isAlive)
		{
			FP actRng = _actor.spawnerInfo.actRng;
			FP fP = _actor.spawnerInfo.disActRng;
			FP refRng = _actor.spawnerInfo.refRng;
			if (fP < actRng)
			{
				fP = (actRng + refRng) * 0.5f;
			}
			FP fP2 = TSVector2.DistanceSquared(_actor.tsTransform.Position, activePlayerActor.tsTransform.Position);
			switch (state)
			{
			case MonsterActiveState.UnRef:
				if (fP2 <= refRng * refRng)
				{
					state = MonsterActiveState.Ref;
				}
				break;
			case MonsterActiveState.Ref:
				if (fP2 > refRng * refRng)
				{
					DespawnActor();
				}
				else if (fP2 <= actRng * actRng)
				{
					ActiveActor();
				}
				else
				{
					DeactiveActor();
				}
				break;
			case MonsterActiveState.Active:
				if (fP2 > fP * fP && !forceActive)
				{
					DeactiveActor();
				}
				break;
			case MonsterActiveState.Deactive:
				if (fP2 > refRng * refRng)
				{
					DespawnActor();
				}
				else if (fP2 <= actRng * actRng)
				{
					ActiveActor();
				}
				break;
			}
		}
		else
		{
			ActiveActor();
		}
	}

	public void ActiveActor(bool forceActive = false)
	{
		this.forceActive = forceActive;
		state = MonsterActiveState.Active;
		if (_deactived)
		{
			_actor.ResumeLogicUpdate();
			if (_actor.attackTarget == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor);
			}
			_deactived = false;
		}
	}

	private void DeactiveActor()
	{
		state = MonsterActiveState.Deactive;
		if (!_deactived)
		{
			_actor.PauseLogicUpdate();
			_deactived = true;
			SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor, add: false);
		}
	}

	private void DespawnActor()
	{
		state = MonsterActiveState.UnRef;
		AdventureMonsterDespawnedEvent adventureMonsterDespawnedEvent = AdventureMonsterDespawnedEvent.Generate();
		adventureMonsterDespawnedEvent.id = _actor.Id;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterDespawnedEvent);
		_actor.Despawn();
		SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor, add: false);
		forceActive = false;
	}
}
