using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverWeaknessBarParams : IObserverParams, IReference
{
	protected bool isShow;

	protected BaseWeaknessData weaknessData;

	public bool IsShow => isShow;

	public BaseWeaknessData WeaknessData => weaknessData;

	public BaseEntity Trigger => weaknessData?.monsterEntity ?? null;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.WeaknessBar;

	public void Init(BaseWeaknessData weaknessData, bool isShow)
	{
		this.weaknessData = weaknessData;
		this.isShow = isShow;
	}

	public void Clear()
	{
		weaknessData = null;
		isShow = false;
	}

	public IObserverParams Copy()
	{
		ObserverWeaknessBarParams observerWeaknessBarParams = ReferencePool.Acquire<ObserverWeaknessBarParams>();
		observerWeaknessBarParams.weaknessData = weaknessData;
		observerWeaknessBarParams.isShow = isShow;
		return observerWeaknessBarParams;
	}
}
