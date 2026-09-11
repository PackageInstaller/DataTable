using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]修改闪避效果最大使用次数", 0)]
[Category("Logic/Attribute")]
[Description("修改闪避效果最大使用次数")]
public class SetUltimateAvoidMaxUseCount : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> countIDInput = AddValueInput<int>("次数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.mUltimateAvoidMaxUseCount = countIDInput.value;
				output.Call(f);
			}
		});
	}
}
