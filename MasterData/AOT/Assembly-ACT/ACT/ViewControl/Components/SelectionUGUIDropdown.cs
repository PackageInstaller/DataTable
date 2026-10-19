using TMPro;
using UnityEngine.EventSystems;

namespace ACT.ViewControl.Components;

public class SelectionUGUIDropdown : SelectionResolver, ISubmitHandler, IEventSystemHandler
{
	private TMP_Dropdown m_Dropdown;

	private void Awake()
	{
		m_Dropdown = GetComponent<TMP_Dropdown>();
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		m_Dropdown.OnSubmit(eventData);
	}
}
