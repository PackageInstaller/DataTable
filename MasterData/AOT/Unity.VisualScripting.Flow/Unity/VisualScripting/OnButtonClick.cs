using System;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[TypeIcon(typeof(Button))]
[UnitOrder(1)]
public sealed class OnButtonClick : GameObjectEventUnit<EmptyEventArgs>
{
	protected override string hookName => "OnButtonClick";

	public override Type MessageListenerType => typeof(UnityOnButtonClickMessageListener);
}
