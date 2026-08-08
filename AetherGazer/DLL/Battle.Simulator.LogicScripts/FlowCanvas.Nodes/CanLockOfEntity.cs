using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被锁定(本体)", 0)]
[Category("Logic/AI")]
[Description("判断目标能否被锁定，可以被锁定走True，不能被锁定走 False，传入的实体不存在走 Error")]
public class CanLockOfEntity : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (AIProcessor.CanLockOfEntity(CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID)))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
