using UnityEngine;

namespace Unity.VisualScripting;

[AddComponentMenu("")]
public sealed class UnityOnCollisionEnter2DMessageListener : MessageListener
{
	private void OnCollisionEnter2D(Collision2D collision)
	{
		EventBus.Trigger("OnCollisionEnter2D", gameObject, collision);
	}
}
