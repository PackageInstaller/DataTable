using System;
using UnityEngine;

public abstract class CriMonoBehaviour : MonoBehaviour
{
	public Guid guid { get; private set; }

	public CriMonoBehaviour()
	{
		guid = Guid.NewGuid();
	}

	protected virtual void OnEnable()
	{
		CriMonoBehaviourManager.instance.Register(this);
	}

	protected virtual void OnDisable()
	{
		CriMonoBehaviourManager.UnRegister(this);
	}

	public abstract void CriInternalUpdate();

	public abstract void CriInternalLateUpdate();
}
