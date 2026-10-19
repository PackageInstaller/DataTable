using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Hierarchy")]
public sealed class OnTransformParentChanged : GameObjectEventUnit<EmptyEventArgs>
{
	public override Type MessageListenerType => typeof(UnityOnTransformParentChangedMessageListener);

	protected override string hookName => "OnTransformParentChanged";
}
