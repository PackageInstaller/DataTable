using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;

public class ChoiceSelect : MonoBehaviour, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	public GameObject prompt;

	private void Awake()
	{
		prompt.SetActive(EventSystemHelper.CurrentSelected == gameObject);
	}

	public void OnSelect(BaseEventData eventData)
	{
		prompt.SetActive(value: true);
	}

	public void OnDeselect(BaseEventData eventData)
	{
		prompt.SetActive(value: false);
	}
}
