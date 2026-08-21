using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverMonsterFuzzyParams : IObserverParams, IReference
{
	private BaseEntity _attackerEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.MonsterFuzzy;

	public BaseEntity Trigger => _attackerEntity;

	public void Init(BaseEntity attackerEntity)
	{
		_attackerEntity = attackerEntity;
	}

	public void Clear()
	{
		_attackerEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverMonsterFuzzyParams observerMonsterFuzzyParams = ReferencePool.Acquire<ObserverMonsterFuzzyParams>();
		observerMonsterFuzzyParams._attackerEntity = _attackerEntity;
		return observerMonsterFuzzyParams;
	}
}
