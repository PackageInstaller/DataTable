using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverBattleStateChangeParams : IObserverParams, IReference
{
	protected BaseEntity entity;

	private bool inBattleState;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.BattleStateChange;

	public BaseEntity Trigger => entity;

	public bool InBattleState => inBattleState;

	public void Init(BaseEntity entity, bool battleState)
	{
		this.entity = entity;
		inBattleState = battleState;
	}

	public void Clear()
	{
		entity = null;
		inBattleState = false;
	}

	public IObserverParams Copy()
	{
		ObserverBattleStateChangeParams observerBattleStateChangeParams = ReferencePool.Acquire<ObserverBattleStateChangeParams>();
		observerBattleStateChangeParams.entity = entity;
		observerBattleStateChangeParams.inBattleState = inBattleState;
		return observerBattleStateChangeParams;
	}
}
