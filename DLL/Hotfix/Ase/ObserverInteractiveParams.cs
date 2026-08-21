using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverInteractiveParams : IObserverParams, IReference
{
	protected BattleObserverEventEnum observerEventEnum;

	protected BaseEntity heroEntity;

	protected BaseEntity interactiveEntity;

	public BattleObserverEventEnum ObserverEventType => observerEventEnum;

	public BaseEntity Trigger => heroEntity;

	public BaseEntity HeroEntity => heroEntity;

	public BaseEntity InteractiveEntity => interactiveEntity;

	public void Init(BattleObserverEventEnum observerEventEnum, BaseEntity heroEntity, BaseEntity interactiveEntity)
	{
		this.observerEventEnum = observerEventEnum;
		this.heroEntity = heroEntity;
		this.interactiveEntity = interactiveEntity;
	}

	public void Clear()
	{
		heroEntity = null;
		interactiveEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverInteractiveParams observerInteractiveParams = ReferencePool.Acquire<ObserverInteractiveParams>();
		observerInteractiveParams.observerEventEnum = observerEventEnum;
		observerInteractiveParams.heroEntity = heroEntity;
		observerInteractiveParams.interactiveEntity = interactiveEntity;
		return observerInteractiveParams;
	}
}
