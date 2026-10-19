using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnBecameInvisibleMessageListener : MessageListener
{
	private void OnBecameInvisible()
	{
		EventBus.Trigger("OnBecameInvisible", gameObject);
	}
}
