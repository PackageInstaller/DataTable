using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Keyboard Key", 0)]
[Category("Events/Input")]
[Description("Calls respective outputs when the defined keyboard key is pressed down, held down or released")]
public class KeyboardEvents : EventNode, IUpdatable
{
	public BBParameter<KeyCode> keyCode = new BBParameter<KeyCode>(KeyCode.Space);

	private FlowOutput down;

	private FlowOutput up;

	private FlowOutput pressed;

	public override string name => $"{base.name} [{keyCode}]";

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		keyCode = options.Resolver.GetFormatter<BBParameter<KeyCode>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<BBParameter<KeyCode>>().Serialize(ref writer, keyCode, options);
	}

	protected override void RegisterPorts()
	{
		down = AddFlowOutput("Down");
		pressed = AddFlowOutput("Pressed");
		up = AddFlowOutput("Up");
	}

	public void Update()
	{
		KeyCode value = keyCode.value;
		if (Input.GetKeyDown(value))
		{
			down.Call(default(Flow));
		}
		if (Input.GetKey(value))
		{
			pressed.Call(default(Flow));
		}
		if (Input.GetKeyUp(value))
		{
			up.Call(default(Flow));
		}
	}
}
