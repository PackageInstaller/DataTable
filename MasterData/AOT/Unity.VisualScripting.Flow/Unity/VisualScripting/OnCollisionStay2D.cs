using System;

namespace Unity.VisualScripting;

public sealed class OnCollisionStay2D : CollisionEvent2DUnit
{
	public override Type MessageListenerType => typeof(UnityOnCollisionStay2DMessageListener);

	protected override string hookName => "OnCollisionStay2D";
}
