using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnDropdownValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<Dropdown>()?.onValueChanged?.AddListener((int value) =>
		{
			EventBus.Trigger("OnDropdownValueChanged", gameObject, value);
		});
	}
}
