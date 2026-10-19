using ACT.UI;
using UnityEngine.EventSystems;

namespace ACT.ViewControl.Components;

public class SelectionUGUIToggle : SelectionResolver, ISubmitHandler, IEventSystemHandler
{
	private PublicToggle m_Toggle;

	private void Awake()
	{
		m_Toggle = GetComponent<PublicToggle>();
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		m_Toggle.OnSubmit(eventData);
	}
}
