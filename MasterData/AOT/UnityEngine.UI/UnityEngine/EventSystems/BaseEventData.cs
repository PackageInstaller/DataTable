namespace UnityEngine.EventSystems;

public class BaseEventData : AbstractEventData
{
	private readonly EventSystem m_EventSystem;

	public BaseInputModule currentInputModule => m_EventSystem.currentInputModule;

	public GameObject selectedObject
	{
		get
		{
			return m_EventSystem.currentSelectedGameObject;
		}
		set
		{
			m_EventSystem.SetSelectedGameObject(value, this);
		}
	}

	public BaseEventData(EventSystem eventSystem)
	{
		m_EventSystem = eventSystem;
	}
}
