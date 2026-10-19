using System;

namespace Unity.VisualScripting;

public sealed class OnCollisionEnter : CollisionEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnCollisionEnterMessageListener);

	protected override string hookName => "OnCollisionEnter";
}
