using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有抓取对象", 0)]
[Category("Logic/Config")]
[Description("判断抓取对象")]
public class HasGrabTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		int res = 0;
		AddValueOutput("对象ID", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				res = 0;
				falseOut.Call(f);
			}
			else
			{
				res = entityWithEntityID.entityBlackboard.var.mGrabTarget;
				if (res == 0)
				{
					falseOut.Call(f);
				}
				else
				{
					trueOut.Call(f);
				}
			}
		});
	}
}
