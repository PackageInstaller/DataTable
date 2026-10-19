using System;

namespace Unity.VisualScripting;

public sealed class OnCollisionExit : CollisionEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnCollisionExitMessageListener);

	protected override string hookName => "OnCollisionExit";
}
