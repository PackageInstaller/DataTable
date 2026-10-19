using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnToggleValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<Toggle>()?.onValueChanged?.AddListener((bool value) =>
		{
			EventBus.Trigger("OnToggleValueChanged", gameObject, value);
		});
	}
}
