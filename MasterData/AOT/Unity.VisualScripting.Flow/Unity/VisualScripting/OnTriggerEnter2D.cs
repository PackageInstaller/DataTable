using System;

namespace Unity.VisualScripting;

public sealed class OnTriggerEnter2D : TriggerEvent2DUnit
{
	public override Type MessageListenerType => typeof(UnityOnTriggerEnter2DMessageListener);

	protected override string hookName => "OnTriggerEnter2D";
}
