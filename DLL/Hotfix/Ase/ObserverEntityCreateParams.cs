using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverEntityCreateParams : IObserverParams, IReference
{
	protected BaseEntity createEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.EntityCreate;

	public BaseEntity Trigger => createEntity;

	public BaseEntity CreateEntity => createEntity;

	public void Init(BaseEntity entity)
	{
		createEntity = entity;
	}

	public void Clear()
	{
		createEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverEntityCreateParams observerEntityCreateParams = ReferencePool.Acquire<ObserverEntityCreateParams>();
		observerEntityCreateParams.createEntity = createEntity;
		return observerEntityCreateParams;
	}
}
