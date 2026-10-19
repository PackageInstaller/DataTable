using System;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[TypeIcon(typeof(InputField))]
[UnitCategory("Events/GUI")]
[UnitOrder(3)]
public sealed class OnInputFieldEndEdit : GameObjectEventUnit<string>
{
	public override Type MessageListenerType => typeof(UnityOnInputFieldEndEditMessageListener);

	protected override string hookName => "OnInputFieldEndEdit";

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput<string>("value");
	}

	protected override void AssignArguments(Flow flow, string value)
	{
		flow.SetValue(this.value, value);
	}
}
