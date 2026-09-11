using UnityEngine;

namespace T0World;

public class T0WorldBehavior : MonoBehaviour, IT0WorldBehavior
{
	[HideInInspector]
	protected IT0WorldAgent m_agent;

	public T0WorldAgent mAgent => m_agent as T0WorldAgent;

	public virtual void Initialize()
	{
		if (m_agent == null)
		{
			m_agent = base.gameObject.GetComponent<IT0WorldAgent>();
			XLogger.Assert(m_agent != null, "this gameobject don't have NAgent!");
		}
	}

	public virtual void FixedUpdateBehavior()
	{
	}

	public virtual void UpdateBehavior()
	{
	}

	public virtual void LateUpdateBehavior()
	{
	}

	public virtual void DestroyBehavior()
	{
	}

	public virtual void OnLowMemory()
	{
	}
}
