using System;

namespace Unity.VisualScripting;

[UnitCategory("Events/Rendering")]
public sealed class OnBecameInvisible : GameObjectEventUnit<EmptyEventArgs>
{
	public override Type MessageListenerType => typeof(UnityOnBecameInvisibleMessageListener);

	protected override string hookName => "OnBecameInvisible";
}
