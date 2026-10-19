using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnCollisionStay2DMessageListener : MessageListener
{
	private void OnCollisionStay2D(Collision2D collision)
	{
		EventBus.Trigger("OnCollisionStay2D", gameObject, collision);
	}
}
