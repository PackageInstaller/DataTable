using System;

namespace Unity.VisualScripting;

public sealed class OnCollisionStay : CollisionEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnCollisionStayMessageListener);

	protected override string hookName => "OnCollisionStay";
}
