using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnInputFieldEndEditMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<InputField>()?.onEndEdit?.AddListener((string value) =>
		{
			EventBus.Trigger("OnInputFieldEndEdit", gameObject, value);
		});
	}
}
