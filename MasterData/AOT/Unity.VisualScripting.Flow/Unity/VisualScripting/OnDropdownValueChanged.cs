using System;
using UnityEngine.UI;

namespace Unity.VisualScripting;

[UnitCategory("Events/GUI")]
[UnitOrder(4)]
[TypeIcon(typeof(Dropdown))]
public sealed class OnDropdownValueChanged : GameObjectEventUnit<int>
{
	public override Type MessageListenerType => typeof(UnityOnDropdownValueChangedMessageListener);

	protected override string hookName => "OnDropdownValueChanged";

	[DoNotSerialize]
	public ValueOutput index { get; private set; }

	[DoNotSerialize]
	public ValueOutput text { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		index = ValueOutput<int>("index");
		text = ValueOutput<string>("text");
	}

	protected override void AssignArguments(Flow flow, int index)
	{
		flow.SetValue(this.index, index);
		flow.SetValue(text, flow.GetValue<Dropdown>(target).options[index].text);
	}
}
