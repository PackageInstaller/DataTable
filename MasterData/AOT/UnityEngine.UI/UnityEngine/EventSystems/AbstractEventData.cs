namespace UnityEngine.EventSystems;

public abstract class AbstractEventData
{
	protected bool m_Used;

	public virtual bool used => m_Used;

	public virtual void Reset()
	{
		m_Used = false;
	}

	public virtual void Use()
	{
		m_Used = true;
	}
}
