using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverBattleStartParams : IObserverParams, IReference
{
	private BaseEntity _triggerEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.BattleStart;

	public BaseEntity Trigger => _triggerEntity;

	public void Init(BaseEntity triggerEntity)
	{
		_triggerEntity = triggerEntity;
	}

	public void Clear()
	{
		_triggerEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverBattleStartParams observerBattleStartParams = ReferencePool.Acquire<ObserverBattleStartParams>();
		observerBattleStartParams._triggerEntity = _triggerEntity;
		return observerBattleStartParams;
	}
}
