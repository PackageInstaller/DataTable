using UnityEngine;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnScrollRectValueChangedMessageListener : MessageListener
{
	private void Start()
	{
		GetComponent<ScrollRect>()?.onValueChanged?.AddListener((Vector2 value) =>
		{
			EventBus.Trigger("OnScrollRectValueChanged", gameObject, value);
		});
	}
}
