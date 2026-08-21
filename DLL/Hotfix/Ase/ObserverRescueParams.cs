using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverRescueParams : IObserverParams, IReference
{
	protected BaseEntity wounded;

	protected BaseEntity rescue;

	protected BattleObserverEventEnum observerEventEnum;

	public BaseEntity Wounded => wounded;

	public BaseEntity Rescue => rescue;

	public BattleObserverEventEnum ObserverEventType => observerEventEnum;

	public BaseEntity Trigger => wounded;

	public void Init(BattleObserverEventEnum observerEventEnum, BaseEntity wounded, BaseEntity rescue)
	{
		this.observerEventEnum = observerEventEnum;
		this.wounded = wounded;
		this.rescue = rescue;
	}

	public void Clear()
	{
		wounded = null;
		rescue = null;
	}

	public IObserverParams Copy()
	{
		ObserverRescueParams observerRescueParams = ReferencePool.Acquire<ObserverRescueParams>();
		observerRescueParams.observerEventEnum = observerEventEnum;
		observerRescueParams.wounded = wounded;
		observerRescueParams.rescue = rescue;
		return observerRescueParams;
	}
}
