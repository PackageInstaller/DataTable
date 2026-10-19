using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnTransformParentChangedMessageListener : MessageListener
{
	private void OnTransformParentChanged()
	{
		EventBus.Trigger("OnTransformParentChanged", gameObject);
	}
}
