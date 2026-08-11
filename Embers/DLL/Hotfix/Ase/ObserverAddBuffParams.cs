using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverAddBuffParams : IObserverParams, IReference
{
	protected Buff addBuff;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.AddBuff;

	public BaseEntity Trigger => addBuff?.BuffOwner ?? null;

	public Buff AddBuff => addBuff;

	public void Init(Buff buff)
	{
		addBuff = buff;
	}

	public void Clear()
	{
		addBuff = null;
	}

	public IObserverParams Copy()
	{
		ObserverAddBuffParams observerAddBuffParams = ReferencePool.Acquire<ObserverAddBuffParams>();
		observerAddBuffParams.addBuff = addBuff;
		return observerAddBuffParams;
	}
}
