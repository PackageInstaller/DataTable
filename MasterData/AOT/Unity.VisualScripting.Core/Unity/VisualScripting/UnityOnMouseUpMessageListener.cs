using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseUpMessageListener : MessageListener
{
	private void OnMouseUp()
	{
		EventBus.Trigger("OnMouseUp", gameObject);
	}
}
