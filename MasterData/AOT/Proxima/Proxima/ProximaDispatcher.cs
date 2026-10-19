using System;
using System.Collections;
using System.Collections.Concurrent;
using UnityEngine;

namespace Proxima;

internal class ProximaDispatcher
{
	private ConcurrentQueue<Action> _queue = new ConcurrentQueue<Action>();

	private MonoBehaviour _coroutineRunner;

	public ProximaDispatcher(MonoBehaviour coroutineRunner)
	{
		_coroutineRunner = coroutineRunner;
	}

	public void Dispatch(Action action)
	{
		_queue.Enqueue(action);
	}

	public void InvokeAll()
	{
		Action result;
		while (_queue.TryDequeue(out result))
		{
			try
			{
				result();
			}
			catch (Exception e)
			{
				Log.Exception(e);
			}
		}
	}

	public void StartCoroutine(IEnumerator coroutine)
	{
		if ((bool)_coroutineRunner)
		{
			_coroutineRunner.StartCoroutine(coroutine);
		}
	}
}
