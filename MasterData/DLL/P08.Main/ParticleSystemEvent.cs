using System;
using UnityEngine;

public class ParticleSystemEvent : MonoBehaviour
{
	private Action<UnityEngine.Object> startEvent;

	private Action<UnityEngine.Object> endEvent;

	private ParticleSystem ps;

	private bool isStart;

	private bool isEnd;

	private void Awake()
	{
		ps = GetComponent<ParticleSystem>();
	}

	private void Start()
	{
	}

	private void OnEnable()
	{
		isStart = false;
		isEnd = false;
	}

	private void Update()
	{
		if (!ps)
		{
			return;
		}
		if (!isStart && ps.isPlaying)
		{
			if (startEvent != null)
			{
				startEvent(base.gameObject);
			}
			isStart = true;
		}
		if (!isEnd && ps.isStopped)
		{
			if (endEvent != null)
			{
				endEvent(base.gameObject);
			}
			isEnd = true;
		}
	}

	public void AddStartEvent(Action<UnityEngine.Object> func)
	{
		startEvent = (Action<UnityEngine.Object>)Delegate.Combine(startEvent, func);
	}

	public void SetStartEvent(Action<UnityEngine.Object> func)
	{
		startEvent = func;
	}

	public void AddEndEvent(Action<UnityEngine.Object> func)
	{
		endEvent = (Action<UnityEngine.Object>)Delegate.Combine(endEvent, func);
	}

	public void SetEndEvent(Action<UnityEngine.Object> func)
	{
		endEvent = func;
	}
}
