using System;

namespace Unity.VisualScripting;

[UnitOrder(25)]
[UnitCategory("Events/GUI")]
public sealed class OnCancel : GenericGuiEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnCancelMessageListener);

	protected override string hookName => "OnCancel";
}
