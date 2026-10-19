using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnMouseExitMessageListener : MessageListener
{
	private void OnMouseExit()
	{
		EventBus.Trigger("OnMouseExit", gameObject);
	}
}
