using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnTransformChildrenChangedMessageListener : MessageListener
{
	private void OnTransformChildrenChanged()
	{
		EventBus.Trigger("OnTransformChildrenChanged", gameObject);
	}
}
