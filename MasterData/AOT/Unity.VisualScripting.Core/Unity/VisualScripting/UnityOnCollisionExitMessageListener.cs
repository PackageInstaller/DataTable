using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnCollisionExitMessageListener : MessageListener
{
	private void OnCollisionExit(Collision collision)
	{
		EventBus.Trigger("OnCollisionExit", gameObject, collision);
	}
}
