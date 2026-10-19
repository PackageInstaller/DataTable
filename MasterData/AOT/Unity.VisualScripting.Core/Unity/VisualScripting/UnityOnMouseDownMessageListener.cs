using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseDownMessageListener : MessageListener
{
	private void OnMouseDown()
	{
		EventBus.Trigger("OnMouseDown", gameObject);
	}
}
