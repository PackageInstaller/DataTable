using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用输入", 0)]
[Description("移除掉输入组件")]
[Category("Logic/Control")]
public class DisableInput : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityActionManualInput)
			{
				entityWithEntityID.RemoveEntityActionManualInput();
			}
			if (entityWithEntityID.hasEntityActionMoveDirection)
			{
				entityWithEntityID.RemoveEntityActionMoveDirection();
			}
			if (entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.ClearOnPressDownBtnID();
			}
			output.Call(f);
		});
	}
}
