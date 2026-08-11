using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverMoveStateParams : IObserverParams, IReference
{
	protected BaseEntity entity;

	protected bool isMoving;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.MoveState;

	public BaseEntity Trigger => entity;

	public bool IsMoving => isMoving;

	public void Init(BaseEntity entity, bool isMoving)
	{
		this.entity = entity;
		this.isMoving = isMoving;
	}

	public void Clear()
	{
		entity = null;
		isMoving = false;
	}

	public IObserverParams Copy()
	{
		ObserverMoveStateParams observerMoveStateParams = ReferencePool.Acquire<ObserverMoveStateParams>();
		observerMoveStateParams.entity = entity;
		observerMoveStateParams.isMoving = isMoving;
		return observerMoveStateParams;
	}
}
