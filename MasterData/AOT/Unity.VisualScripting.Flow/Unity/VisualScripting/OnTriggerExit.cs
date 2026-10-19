using System;

namespace Unity.VisualScripting;

public sealed class OnTriggerExit : TriggerEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnTriggerExitMessageListener);

	protected override string hookName => "OnTriggerExit";
}
