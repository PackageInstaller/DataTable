using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnBecameVisibleMessageListener : MessageListener
{
	private void OnBecameVisible()
	{
		EventBus.Trigger("OnBecameVisible", gameObject);
	}
}
