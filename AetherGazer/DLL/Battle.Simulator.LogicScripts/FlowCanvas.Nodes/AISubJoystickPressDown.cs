using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟子摇杆按下", 0)]
[Category("Logic/AI/信标")]
[Description("AI更新信标位置")]
public class AISubJoystickPressDown : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonTypeVar");
		ValueInput<int> abilityTimelineIDInput = AddValueInput<int>("技能ID", "abilityIDVar");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("信标坐标", "positionVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				AIProcessor.RunMelee(entityWithEntityID, mIsPressing: true, (int)buttonTypeInput.GetValue());
				int newCommandCode = SubJoystickCommand.PositionToCommandCode(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, positionInput.GetValue(), abilityTimelineIDInput.GetValue());
				if (entityWithEntityID.hasEntityActionSubJoystick)
				{
					entityWithEntityID.ReplaceEntityActionSubJoystick(newCommandCode, abilityTimelineIDInput.GetValue());
				}
				else
				{
					entityWithEntityID.AddEntityActionSubJoystick(newCommandCode, abilityTimelineIDInput.GetValue());
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", () => entityIDInput.value);
	}
}
