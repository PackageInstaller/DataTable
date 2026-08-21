using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverExcuteBuffParams : IObserverParams, IReference
{
	protected Buff excuteBuff;

	protected BaseEntity formEntity;

	protected BaseEntity ownerEntity;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ExcuteBuff;

	public BaseEntity Trigger => ownerEntity;

	public Buff ExcuteBuff => excuteBuff;

	public BaseEntity FormEntity => formEntity;

	public BaseEntity OwnerEntity => ownerEntity;

	public void Init(Buff eBuff, BaseEntity owner, BaseEntity from)
	{
		excuteBuff = eBuff;
		ownerEntity = owner;
		formEntity = from;
	}

	public void Clear()
	{
		excuteBuff = null;
		ownerEntity = null;
		formEntity = null;
	}

	public IObserverParams Copy()
	{
		ObserverExcuteBuffParams observerExcuteBuffParams = ReferencePool.Acquire<ObserverExcuteBuffParams>();
		observerExcuteBuffParams.excuteBuff = excuteBuff;
		observerExcuteBuffParams.ownerEntity = ownerEntity;
		observerExcuteBuffParams.formEntity = formEntity;
		return observerExcuteBuffParams;
	}
}
