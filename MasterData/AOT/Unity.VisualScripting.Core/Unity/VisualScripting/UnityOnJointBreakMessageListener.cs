using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnJointBreakMessageListener : MessageListener
{
	private void OnJointBreak(float breakForce)
	{
		EventBus.Trigger("OnJointBreak", gameObject, breakForce);
	}
}
