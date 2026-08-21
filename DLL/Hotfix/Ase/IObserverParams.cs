using Ase.ECS;
using GameFramework;

namespace Ase;

public interface IObserverParams : IReference
{
	BattleObserverEventEnum ObserverEventType { get; }

	BaseEntity Trigger { get; }

	IObserverParams Copy();
}
