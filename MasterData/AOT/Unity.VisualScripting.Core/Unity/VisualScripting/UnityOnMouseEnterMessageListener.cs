using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseEnterMessageListener : MessageListener
{
	private void OnMouseEnter()
	{
		EventBus.Trigger("OnMouseEnter", gameObject);
	}
}
