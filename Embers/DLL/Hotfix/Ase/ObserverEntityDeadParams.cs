using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverEntityDeadParams : IObserverParams, IReference
{
	protected BaseEntity deadEntity;

	protected BaseEntity killerEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.EntityDead;

	public BaseEntity Trigger => deadEntity;

	public BaseEntity DeadEntity => deadEntity;

	public BaseEntity KillerEntity => killerEntity;

	public bool DeadEntityIsBoss()
	{
		if (deadEntity is MonsterEntity monsterEntity)
		{
			return monsterEntity.IsBoss;
		}
		return false;
	}

	public void Init(BaseEntity killer, BaseEntity entity)
	{
		killerEntity = killer;
		deadEntity = entity;
	}

	public void Clear()
	{
		killerEntity = null;
		deadEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverEntityDeadParams observerEntityDeadParams = ReferencePool.Acquire<ObserverEntityDeadParams>();
		observerEntityDeadParams.killerEntity = killerEntity;
		observerEntityDeadParams.deadEntity = deadEntity;
		return observerEntityDeadParams;
	}
}
