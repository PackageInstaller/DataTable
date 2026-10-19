using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseDragMessageListener : MessageListener
{
	private void OnMouseDrag()
	{
		EventBus.Trigger("OnMouseDrag", gameObject);
	}
}
