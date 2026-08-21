using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverChangeStateParams : IObserverParams, IReference
{
	protected BaseEntity changeEntity;

	protected int fromId;

	protected StateData data;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ChangeState;

	public BaseEntity Trigger => changeEntity;

	public BaseEntity ChangeEntity => changeEntity;

	public int FromId => fromId;

	public StateData Data => data;

	public void Init(BaseEntity entity, int fId, StateData stateData)
	{
		changeEntity = entity;
		fromId = fId;
		data = stateData;
	}

	public void Clear()
	{
		changeEntity = null;
		fromId = 0;
		data = null;
	}

	public IObserverParams Copy()
	{
		ObserverChangeStateParams observerChangeStateParams = ReferencePool.Acquire<ObserverChangeStateParams>();
		observerChangeStateParams.changeEntity = changeEntity;
		observerChangeStateParams.fromId = fromId;
		observerChangeStateParams.data = data;
		return observerChangeStateParams;
	}
}
