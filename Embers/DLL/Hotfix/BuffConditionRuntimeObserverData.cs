using Ase;
using Ase.ECS;
using GameFramework;

public class BuffConditionRuntimeObserverData : BuffRuntimeDataBase
{
	public IObserverParams observerParams;

	public override BaseEntity ToEntity => GetToEntity();

	private BaseEntity GetToEntity()
	{
		if (observerParams == null)
		{
			return null;
		}
		switch (observerParams.ObserverEventType)
		{
		case BattleObserverEventEnum.AttackBefore:
		case BattleObserverEventEnum.Attack:
			return (observerParams as ObserverDamageProgressParams).Defender;
		case BattleObserverEventEnum.DamageBefore:
		case BattleObserverEventEnum.Damage:
			return (observerParams as ObserverDamageProgressParams).Attacker;
		default:
			return observerParams.Trigger;
		}
	}

	public override void Clear()
	{
		base.Clear();
		if (observerParams != null)
		{
			ReferencePool.Release(observerParams);
			observerParams = null;
		}
	}

	public override BuffRuntimeDataBase Copy()
	{
		return new BuffConditionRuntimeObserverData
		{
			observerParams = observerParams,
			toEntity = toEntity
		};
	}
}
