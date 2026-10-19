using System;

namespace Unity.VisualScripting;

public sealed class OnCollisionExit2D : CollisionEvent2DUnit
{
	public override Type MessageListenerType => typeof(UnityOnCollisionExit2DMessageListener);

	protected override string hookName => "OnCollisionExit2D";
}
