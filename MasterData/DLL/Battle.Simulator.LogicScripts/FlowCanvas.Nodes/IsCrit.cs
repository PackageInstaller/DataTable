using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否暴击(已过时)", 0)]
[Category("Logic/Attribute")]
[Description("判断是否暴击")]
public class IsCrit : FlowControlNode
{
	public static bool IsCritMethod(SimEntity attacker)
	{
		return false;
	}

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> entityInput = AddValueInput<int>("entityID");
		AddFlowInput("In", delegate(Flow f)
		{
			if (IsCritMethod(base.mSimContext.GetEntityWithEntityID(entityInput.value)))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
