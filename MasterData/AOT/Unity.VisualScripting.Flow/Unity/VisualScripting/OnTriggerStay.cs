using System;

namespace Unity.VisualScripting;

public sealed class OnTriggerStay : TriggerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnTriggerStayMessageListener);

	protected override string hookName => "OnTriggerStay";
}
