using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Flow Controllers/Togglers")]
[Description("When In is called, calls On or Off depending on the current toggle state. Whenever Toggle input is called the state changes.")]
public class Toggle : FlowControlNode
{
	[Name("Start Open", 0)]
	public bool open = true;

	private bool original;

	public override string name => base.name + " " + (open ? "[ON]" : "[OFF]");

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(open);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		open = reader.ReadBoolean();
	}

	public override void OnGraphStarted()
	{
		original = open;
	}

	public override void OnGraphStoped()
	{
		open = original;
	}

	protected override void RegisterPorts()
	{
		FlowOutput fOn = AddFlowOutput("On");
		FlowOutput fOff = AddFlowOutput("Off");
		AddFlowInput("In", delegate(Flow f)
		{
			f.Call(open ? fOn : fOff);
		});
		AddFlowInput("Open", delegate
		{
			open = true;
		});
		AddFlowInput("Close", delegate
		{
			open = false;
		});
		AddFlowInput("Toggle", delegate
		{
			open = !open;
		});
	}
}
