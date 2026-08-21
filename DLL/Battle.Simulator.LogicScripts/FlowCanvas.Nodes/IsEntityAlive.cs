using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体血量大于0(逻辑)", 0)]
[Category("Logic/Entity")]
[Description("判断输入实体的生命值是否大于0，仅判断血量。\nTrue:生命值大于0时\nFalse:生命值小于等于0时\nError:实体不存在时")]
public class IsEntityAlive : FlowControlNode
{
	private ValueInput<int> vInEntId;

	protected override void RegisterPorts()
	{
		vInEntId = AddValueInput<int>("实体Id");
		FlowOutput outTrue = AddFlowOutput("True");
		FlowOutput outFalse = AddFlowOutput("False");
		FlowOutput outError = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInEntId.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				f.Call(outError);
			}
			else if (entityWithEntityID.entityBlackboard.var.mHP > 0)
			{
				f.Call(outTrue);
			}
			else
			{
				f.Call(outFalse);
			}
		});
		AddValueOutput("实体Id", () => vInEntId.value);
	}
}
