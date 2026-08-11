using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverEntityRebornParams : IObserverParams, IReference
{
	protected BaseEntity rebornEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.EntityReborn;

	public BaseEntity Trigger => rebornEntity;

	public BaseEntity RebornEntity => rebornEntity;

	public void Init(BaseEntity entity)
	{
		rebornEntity = entity;
	}

	public void Clear()
	{
		rebornEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverEntityRebornParams observerEntityRebornParams = ReferencePool.Acquire<ObserverEntityRebornParams>();
		observerEntityRebornParams.rebornEntity = rebornEntity;
		return observerEntityRebornParams;
	}
}
