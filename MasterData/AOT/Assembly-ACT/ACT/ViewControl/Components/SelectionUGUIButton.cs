using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.ViewControl.Components;

public class SelectionUGUIButton : SelectionResolver, ISubmitHandler, IEventSystemHandler
{
	private Button m_Button;

	private void Awake()
	{
		m_Button = GetComponent<Button>();
	}

	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		m_Button.onClick.Invoke();
	}
}
