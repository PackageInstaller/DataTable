using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class ObserverTeachGuideParams : IObserverParams, IReference
{
	protected BaseEntity releaseEntity;

	public Transform FrameTrans;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.TeachHitSpawn;

	public BaseEntity Trigger => releaseEntity;

	public void Init(BaseEntity releaseEntity, Transform hpTransform)
	{
		this.releaseEntity = releaseEntity;
		FrameTrans = hpTransform;
	}

	public void Clear()
	{
		releaseEntity = null;
		FrameTrans = null;
	}

	public IObserverParams Copy()
	{
		ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
		observerTeachGuideParams.releaseEntity = releaseEntity;
		observerTeachGuideParams.FrameTrans = FrameTrans;
		return observerTeachGuideParams;
	}
}
