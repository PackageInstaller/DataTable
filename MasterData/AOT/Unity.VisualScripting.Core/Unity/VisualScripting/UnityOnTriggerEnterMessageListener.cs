using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnTriggerEnterMessageListener : MessageListener
{
	private void OnTriggerEnter(Collider other)
	{
		EventBus.Trigger("OnTriggerEnter", gameObject, other);
	}
}
