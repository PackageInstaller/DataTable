using System;

namespace Unity.VisualScripting;

[UnitOrder(24)]
[UnitCategory("Events/GUI")]
public sealed class OnSubmit : GenericGuiEventUnit
{
	public override Type MessageListenerType => typeof(UnityOnSubmitMessageListener);

	protected override string hookName => "OnSubmit";
}
