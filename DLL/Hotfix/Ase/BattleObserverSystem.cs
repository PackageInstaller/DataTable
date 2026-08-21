using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BattleObserverSystem : BaseSystem
{
	private Dictionary<BattleObserverEventEnum, List<IObserverHandler>> observers = new Dictionary<BattleObserverEventEnum, List<IObserverHandler>>();

	protected override bool IsLogicSystem => true;

	public void Attach(BattleObserverEventEnum eventType, IObserverHandler observer)
	{
		if (!observers.TryGetValue(eventType, out var value))
		{
			value = new List<IObserverHandler>();
			observers.Add(eventType, value);
		}
		value.Add(observer);
	}

	public void Detach(BattleObserverEventEnum eventType, IObserverHandler observer)
	{
		if (observers.TryGetValue(eventType, out var value))
		{
			value.Remove(observer);
		}
	}

	public void Notify(BattleObserverEventEnum eventType, IObserverParams param)
	{
		if (observers.TryGetValue(eventType, out var value))
		{
			IObserverHandler[] array = value.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				array[i]?.OnNotify(param);
			}
		}
		NotifyAny(param);
	}

	protected virtual void NotifyAny(IObserverParams param)
	{
		if (observers.TryGetValue(BattleObserverEventEnum.Any, out var value))
		{
			IObserverHandler[] array = value.ToArray();
			for (int i = 0; i < array.Length; i++)
			{
				array[i]?.OnNotify(param);
			}
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		observers?.Clear();
	}
}
