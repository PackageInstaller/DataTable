using UnityEngine;

public class QWAgentBehaviour : MonoBehaviour, IQWCBehavior
{
	[HideInInspector]
	protected IQWAgent m_agent;

	public QWAgent mAgent => m_agent as QWAgent;

	public virtual void ActiveBehavior()
	{
	}

	public virtual void DestroyBehavior()
	{
	}

	public void FixedUpdateBehavior()
	{
	}

	public virtual void Initialize()
	{
		if (m_agent == null)
		{
			m_agent = base.gameObject.GetComponent<IQWAgent>();
			XLogger.Assert(m_agent != null, "this gameobject don't have NAgent!");
		}
	}

	public virtual void LateUpdateBehavior()
	{
	}

	public virtual void ResetBehavior()
	{
	}

	public virtual void UpdateBehavior()
	{
	}

	public virtual void OnFirstAddToStage()
	{
	}
}
