using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverEntityReleaseParams : IObserverParams, IReference
{
	protected BaseEntity releaseEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.EntityRelease;

	public BaseEntity Trigger => releaseEntity;

	public BaseEntity ReleaseEntity => releaseEntity;

	public void Init(BaseEntity releaseEntity)
	{
		this.releaseEntity = releaseEntity;
	}

	public void Clear()
	{
		releaseEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverEntityReleaseParams observerEntityReleaseParams = ReferencePool.Acquire<ObserverEntityReleaseParams>();
		observerEntityReleaseParams.releaseEntity = releaseEntity;
		return observerEntityReleaseParams;
	}
}
