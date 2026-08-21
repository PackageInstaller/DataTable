using System.Collections.Generic;
using UnityEngine;

public class ThreadLogger : MonoBehaviour
{
	private Queue<string> _logQueue = new Queue<string>();

	private readonly object _queueLock = new object();

	public static ThreadLogger Instance { get; private set; }

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			Object.DontDestroyOnLoad(base.gameObject);
		}
		else
		{
			Object.Destroy(base.gameObject);
		}
	}

	public void SafeLog(string message)
	{
		lock (_queueLock)
		{
			_logQueue.Enqueue(message);
		}
	}

	private void Update()
	{
		lock (_queueLock)
		{
			while (_logQueue.Count > 0)
			{
				string text = _logQueue.Dequeue();
				Debug.Log("[Thread] → " + text);
			}
		}
	}

	public void OnDisable()
	{
		Object.Destroy(base.gameObject);
	}
}
