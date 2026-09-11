using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否最后长按的按钮(指定按钮)(过时)", 0)]
[Category("Logic/Control")]
[Description("判断指定按钮是否按住\n这个过时了，新写的逻辑用【是否长按了按钮(指定按钮)】这个节点")]
public class IsPressing2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "EntityIDInput");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonTypeInput").SetDefaultAndSerializedValue(ButtonType.MELEE);
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else if (entityWithEntityID.entityBlackboard.var.mOnPressDownBtnID == (int)buttonTypeInput.GetValue())
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
