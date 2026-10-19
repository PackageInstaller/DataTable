using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnScrollbarValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<Scrollbar>()?.onValueChanged?.AddListener((float value) =>
		{
			EventBus.Trigger("OnScrollbarValueChanged", gameObject, value);
		});
	}
}
