using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置能否被抓取结果(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("该节点用于接在【能否被抓取扩展事件】后,调整【能否被抓取】的流出结果")]
public class SetCanBeGrabResult : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> beGrabEntityIDInput = AddValueInput<int>("被抓取实体ID", "beGrabEntityID");
		ValueInput<bool> resutlInput = AddValueInput<bool>("新值", "result");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(beGrabEntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mTempCanBeGrab = resutlInput.value;
				output.Call(f);
			}
		});
	}
}
