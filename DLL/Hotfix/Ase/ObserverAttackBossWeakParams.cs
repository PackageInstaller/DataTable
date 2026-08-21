using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverAttackBossWeakParams : IObserverParams, IReference
{
	protected BaseEntity monsterEntity;

	public bool ReduceHp;

	public bool ReduceTenacity;

	protected bool isAttackWeak;

	public int weaknessLevel;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.AttackBossWeak;

	public BaseEntity Trigger => monsterEntity;

	public bool IsAttackWeak => isAttackWeak;

	public void Init(BaseEntity monsterEntity, int level, float damage, float tenacity)
	{
		this.monsterEntity = monsterEntity;
		isAttackWeak = level > 1;
		weaknessLevel = level;
		ReduceHp = damage > 0f;
		ReduceTenacity = tenacity > 0f;
	}

	public void Clear()
	{
		monsterEntity = null;
		isAttackWeak = false;
		ReduceHp = false;
		ReduceTenacity = false;
	}

	public IObserverParams Copy()
	{
		ObserverAttackBossWeakParams observerAttackBossWeakParams = ReferencePool.Acquire<ObserverAttackBossWeakParams>();
		observerAttackBossWeakParams.monsterEntity = monsterEntity;
		observerAttackBossWeakParams.isAttackWeak = isAttackWeak;
		observerAttackBossWeakParams.ReduceHp = ReduceHp;
		observerAttackBossWeakParams.ReduceTenacity = ReduceTenacity;
		return observerAttackBossWeakParams;
	}
}
