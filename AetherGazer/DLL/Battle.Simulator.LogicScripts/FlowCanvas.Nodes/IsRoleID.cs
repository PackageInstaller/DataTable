using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是实体类型ID(逻辑)", 0)]
[Category("Logic/Config")]
[Description("获取实体ID的角色ID")]
public class IsRoleID : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.ENTITY_CONFIG_ID == roleIDInput.value)
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
