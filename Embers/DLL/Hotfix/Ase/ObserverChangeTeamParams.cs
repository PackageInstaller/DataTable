using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverChangeTeamParams : IObserverParams, IReference
{
	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ChangeTeam;

	public BaseEntity Trigger => null;

	public void Init()
	{
	}

	public void Clear()
	{
	}

	public IObserverParams Copy()
	{
		return ReferencePool.Acquire<ObserverChangeTeamParams>();
	}
}
