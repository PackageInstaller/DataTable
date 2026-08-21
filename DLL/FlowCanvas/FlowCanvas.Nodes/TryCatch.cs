using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Description("Similar to Try/Catch/Finally in code")]
public class TryCatch : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput fTry = AddFlowOutput("Try");
		FlowOutput fCatch = AddFlowOutput("Catch");
		FlowOutput fFinally = AddFlowOutput("Finally");
		AddFlowInput("In", delegate(Flow f)
		{
			try
			{
				fTry.Call(f);
			}
			catch
			{
				fCatch.Call(f);
			}
			finally
			{
				fFinally.Call(f);
			}
		});
	}
}
