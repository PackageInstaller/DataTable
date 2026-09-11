using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体类型ID", 0)]
[Category("Logic/Config")]
[Description("判断实体ID的角色ID")]
public class CheckRoleID : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput outputTrue = AddFlowOutput("true");
		FlowOutput outputFalse = AddFlowOutput("false");
		ValueInput<int> it = AddValueInput<int>("实体ID");
		ValueInput<int> it2 = AddValueInput<int>("实体类型ID", "角色类型ID");
		AddFlowInput("in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(it.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == it2.value)
			{
				f.Call(outputTrue);
			}
			else
			{
				f.Call(outputFalse);
			}
		});
		AddValueOutput("实体ID", "entityID", () => it.value);
	}
}
