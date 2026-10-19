using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseOverMessageListener : MessageListener
{
	private void OnMouseOver()
	{
		EventBus.Trigger("OnMouseOver", gameObject);
	}
}
