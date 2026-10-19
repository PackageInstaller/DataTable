using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnControllerColliderHitMessageListener : MessageListener
{
	private void OnControllerColliderHit(ControllerColliderHit hit)
	{
		EventBus.Trigger("OnControllerColliderHit", gameObject, hit);
	}
}
