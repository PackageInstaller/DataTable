using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否长按了按钮(带判断)(已过时)", 0)]
[Category("Logic/Control")]
[Description("判断指定角色正在执行的技能是不是被按住了")]
public class IsPressingTrueOrFalse : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "EntityIDInput");
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
			else if (entityWithEntityID.entityActionAbility.mIsPressing)
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
