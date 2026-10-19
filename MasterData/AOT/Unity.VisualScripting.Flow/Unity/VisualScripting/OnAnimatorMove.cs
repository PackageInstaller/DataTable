using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Animation")]
public sealed class OnAnimatorMove : GameObjectEventUnit<EmptyEventArgs>
{
	public override Type MessageListenerType => typeof(AnimatorMessageListener);

	protected override string hookName => "OnAnimatorMove";
}
