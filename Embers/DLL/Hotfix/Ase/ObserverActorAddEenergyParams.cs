using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverActorAddEenergyParams : IObserverParams, IReference
{
	private BaseEntity actorHeroEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ActorAddEnergy;

	public BaseEntity Trigger => actorHeroEntity;

	public void Init(BaseEntity actorHeroEntity)
	{
		this.actorHeroEntity = actorHeroEntity;
	}

	public void Clear()
	{
		actorHeroEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverActorAddEenergyParams observerActorAddEenergyParams = ReferencePool.Acquire<ObserverActorAddEenergyParams>();
		observerActorAddEenergyParams.actorHeroEntity = actorHeroEntity;
		return observerActorAddEenergyParams;
	}
}
