using Unity.VisualScripting;
using UnityEngine;

namespace Bolt.Addons.Community.Fundamentals;

[UnitCategory("Events\\Community\\Input")]
[UnitTitle("OnKeys")]
[TypeIcon(typeof(OnKeyboardInput))]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.OnDualKeyInput")]
public class OnKeysPressed : MachineEventUnit<EmptyEventArgs>
{
	public new class Data : EventUnit<EmptyEventArgs>.Data
	{
		public KeyCode key1;

		public KeyCode key2;
	}

	protected override string hookName => "Update";

	[DoNotSerialize]
	[PortLabel("Key 1")]
	public ValueInput Key1 { get; private set; }

	[PortLabel("Key 2")]
	[DoNotSerialize]
	public ValueInput Key2 { get; private set; }

	public override IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override void Definition()
	{
		base.Definition();
		Key1 = ValueInput("Key1", KeyCode.None);
		Key2 = ValueInput("Key2", KeyCode.None);
	}

	public override void StartListening(GraphStack stack)
	{
		base.StartListening(stack);
		stack.GetElementData<Data>(this);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		if (!elementData.isListening)
		{
			return false;
		}
		elementData.key1 = flow.GetValue<KeyCode>(Key1);
		elementData.key2 = flow.GetValue<KeyCode>(Key2);
		if (Input.GetKey(elementData.key1) && Input.GetKey(elementData.key2))
		{
			return true;
		}
		return false;
	}
}
