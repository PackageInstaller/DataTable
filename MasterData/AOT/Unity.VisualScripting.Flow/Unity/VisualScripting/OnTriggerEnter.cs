using System;

namespace Unity.VisualScripting;

public sealed class OnTriggerEnter : TriggerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnTriggerEnterMessageListener);

	protected override string hookName => "OnTriggerEnter";
}
