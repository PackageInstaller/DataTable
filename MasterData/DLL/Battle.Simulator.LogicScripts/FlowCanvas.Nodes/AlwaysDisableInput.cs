using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用输入(一直生效)", 0)]
[Description("移除掉输入组件, 并设置不可输入")]
[Category("Logic/Control")]
public class AlwaysDisableInput : FlowNode
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
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2010, 1L, 0L, 0L);
				entityWithEntityID.entityBlackboard.var.ClearOnPressDownBtnID();
			}
			output.Call(f);
		});
	}
}
