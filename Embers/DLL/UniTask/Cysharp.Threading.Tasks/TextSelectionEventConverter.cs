using System;
using UnityEngine.Events;

namespace Cysharp.Threading.Tasks;

internal class TextSelectionEventConverter : UnityEvent<(string, int, int)>, IDisposable
{
	private readonly UnityEvent<string, int, int> innerEvent;

	private readonly UnityAction<string, int, int> invokeDelegate;

	public TextSelectionEventConverter(UnityEvent<string, int, int> unityEvent)
	{
		innerEvent = unityEvent;
		invokeDelegate = InvokeCore;
		innerEvent.AddListener(invokeDelegate);
	}

	private void InvokeCore(string item1, int item2, int item3)
	{
		innerEvent.Invoke(item1, item2, item3);
	}

	public void Dispose()
	{
		innerEvent.RemoveListener(invokeDelegate);
	}
}
