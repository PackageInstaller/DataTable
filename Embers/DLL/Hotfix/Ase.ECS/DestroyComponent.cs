using GameFramework;

namespace Ase.ECS;

public class DestroyComponent : BaseComponent
{
	private BaseEntity killerEntity;

	public BaseEntity KillerEntity => killerEntity;

	public virtual void SetKillerEntity(BaseEntity killerEntity)
	{
		this.killerEntity = killerEntity;
	}

	public virtual void DoEntityDead(bool isKilled = false)
	{
		mBaseEntity.DoEntityDead(isRelease: false);
		ObserverEntityDeadParams observerEntityDeadParams = ReferencePool.Acquire<ObserverEntityDeadParams>();
		observerEntityDeadParams.Init(killerEntity, mBaseEntity);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.EntityDead, observerEntityDeadParams);
		ReferencePool.Release(observerEntityDeadParams);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		killerEntity = null;
	}
}
