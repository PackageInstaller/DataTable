using System.Collections;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Services;

[ComVisible(true)]
public class TrackingServices
{
	private static ArrayList _handlers = new ArrayList();

	internal static void NotifyMarshaledObject(object obj, ObjRef or)
	{
		ITrackingHandler[] array;
		lock (_handlers.SyncRoot)
		{
			if (_handlers.Count == 0)
			{
				return;
			}
			array = (ITrackingHandler[])_handlers.ToArray(typeof(ITrackingHandler));
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i].MarshaledObject(obj, or);
		}
	}

	internal static void NotifyUnmarshaledObject(object obj, ObjRef or)
	{
		ITrackingHandler[] array;
		lock (_handlers.SyncRoot)
		{
			if (_handlers.Count == 0)
			{
				return;
			}
			array = (ITrackingHandler[])_handlers.ToArray(typeof(ITrackingHandler));
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i].UnmarshaledObject(obj, or);
		}
	}

	internal static void NotifyDisconnectedObject(object obj)
	{
		ITrackingHandler[] array;
		lock (_handlers.SyncRoot)
		{
			if (_handlers.Count == 0)
			{
				return;
			}
			array = (ITrackingHandler[])_handlers.ToArray(typeof(ITrackingHandler));
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i].DisconnectedObject(obj);
		}
	}
}
