using ACT.UI;
using UnityEngine.EventSystems;

namespace ACT.ViewControl.Components;

public class SelectionUGUIActToggle : SelectionResolver, ISubmitHandler, IEventSystemHandler
{
	private ActToggle m_Toggle;

	private void Awake()
	{
		m_Toggle = GetComponent<ActToggle>();
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		m_Toggle.onToggleClick?.Invoke();
	}
}
