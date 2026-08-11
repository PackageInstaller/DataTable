using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverBuffLayerChangedParams : IObserverParams, IReference
{
	protected Buff buff;

	protected int layer;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.BuffLayerChanged;

	public BaseEntity Trigger => buff?.BuffOwner ?? null;

	public Buff ChangedBuff => buff;

	public int Layer => layer;

	public void Init(Buff toBuff, int toLayer)
	{
		buff = toBuff;
		layer = toLayer;
	}

	public void Clear()
	{
		buff = null;
		layer = 0;
	}

	public IObserverParams Copy()
	{
		ObserverBuffLayerChangedParams observerBuffLayerChangedParams = ReferencePool.Acquire<ObserverBuffLayerChangedParams>();
		observerBuffLayerChangedParams.buff = buff;
		observerBuffLayerChangedParams.layer = layer;
		return observerBuffLayerChangedParams;
	}
}
