using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否可以移动(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("用于检查 EntityID 对应的实体是否可以移动")]
public class CanMovement : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null)
			{
				if (entityWithEntityID[EntityVarName.ENTITY_ATTR_LOCK_MOVEMENT] == 0)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
