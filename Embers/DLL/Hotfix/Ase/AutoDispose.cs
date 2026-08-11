using System;
using UnityEngine;

namespace Ase;

public class AutoDispose : MonoBehaviour
{
	public float time;

	private float cur;

	private Action<GameObject> disposeAction;

	private Action disposeAction2;

	private bool isOnDispose;

	private bool reset;

	private void OnEnable()
	{
		cur = 0f;
		isOnDispose = false;
	}

	private void Update()
	{
		if (reset)
		{
			isOnDispose = false;
		}
		if (cur >= time && !isOnDispose)
		{
			if (disposeAction != null)
			{
				disposeAction(base.gameObject);
			}
			if (disposeAction2 != null)
			{
				disposeAction2();
			}
			isOnDispose = true;
		}
		else
		{
			cur += Time.deltaTime;
		}
	}

	public void AddDisposeAction(Action<GameObject> disposeAction)
	{
		this.disposeAction = disposeAction;
	}

	public void AddDisposeAction(Action disposeAction2)
	{
		this.disposeAction2 = disposeAction2;
	}

	public void ResetTime(float t)
	{
		time = t;
		cur = 0f;
		reset = true;
	}
}
