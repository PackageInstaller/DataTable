using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnTriggerStay2DMessageListener : MessageListener
{
	private void OnTriggerStay2D(Collider2D other)
	{
		EventBus.Trigger("OnTriggerStay2D", gameObject, other);
	}
}
