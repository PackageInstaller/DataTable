using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverRemoveBuffParams : IObserverParams, IReference
{
	protected Buff removeBuff;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.RemoveBuff;

	public BaseEntity Trigger => removeBuff?.BuffOwner ?? null;

	public Buff RemoveBuff => removeBuff;

	public void Init(Buff buff)
	{
		removeBuff = buff;
	}

	public void Clear()
	{
		removeBuff = null;
	}

	public IObserverParams Copy()
	{
		ObserverRemoveBuffParams observerRemoveBuffParams = ReferencePool.Acquire<ObserverRemoveBuffParams>();
		observerRemoveBuffParams.removeBuff = removeBuff;
		return observerRemoveBuffParams;
	}
}
