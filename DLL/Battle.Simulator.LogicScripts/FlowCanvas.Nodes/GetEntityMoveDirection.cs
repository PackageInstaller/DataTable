using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取移动组件方向", 0)]
[Category("Logic/PosAndRot")]
[Description("获取移动组件方向")]
public class GetEntityMoveDirection : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		Int3 res = Int3.zero;
		AddValueOutput("当前朝向", () => res);
		Int3 last = Int3.zero;
		AddValueOutput("之前朝向", () => last);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionMoveDirection)
			{
				falseOut.Call(f);
			}
			else
			{
				res = entityWithEntityID.entityActionMoveDirection.mDirection;
				last = entityWithEntityID.entityActionMoveDirection.mLastDirection;
				trueOut.Call(f);
			}
		});
	}
}
