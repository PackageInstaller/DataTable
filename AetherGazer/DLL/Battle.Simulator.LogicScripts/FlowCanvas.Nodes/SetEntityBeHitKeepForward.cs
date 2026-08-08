using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体受击是否保持方向", 0)]
[Category("Logic/Attribute")]
[Description("设置实体受击后是否保持原本朝向而非朝向受击方向")]
public class SetEntityBeHitKeepForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<bool> isKeepForward = AddValueInput<bool>("是否保持方向");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mBeHitKeepForward = isKeepForward.value;
				output.Call(f);
			}
		});
	}
}
