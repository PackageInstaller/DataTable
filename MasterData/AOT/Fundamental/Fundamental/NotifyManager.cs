using System.Collections.Generic;

namespace Fundamental;

public class NotifyManager : MonoSingleton<NotifyManager>
{
	private const int NotifyTiers = 5;

	private List<List<INotifyHandler>> _invokeList;

	private List<List<INotifyHandler>> _listenerList;

	protected override void Init()
	{
		_invokeList = new List<List<INotifyHandler>>(5);
		for (int i = 0; i < 5; i++)
		{
			_invokeList[i] = new List<INotifyHandler>();
		}
		_listenerList = new List<List<INotifyHandler>>(5);
		for (int j = 0; j < 5; j++)
		{
			_listenerList[j] = new List<INotifyHandler>();
		}
	}

	protected override void UnInit()
	{
	}

	public void InvokeNotify(Notify type, object body)
	{
	}
}
