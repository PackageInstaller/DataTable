using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnInputFieldValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<InputField>()?.onValueChanged?.AddListener((string value) =>
		{
			EventBus.Trigger("OnInputFieldValueChanged", gameObject, value);
		});
	}
}
