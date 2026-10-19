using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnTriggerStayMessageListener : MessageListener
{
	private void OnTriggerStay(Collider other)
	{
		EventBus.Trigger("OnTriggerStay", gameObject, other);
	}
}
