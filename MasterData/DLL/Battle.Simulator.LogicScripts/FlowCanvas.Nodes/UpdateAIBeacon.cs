using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟子摇杆更新", 0)]
[Category("Logic/AI/信标")]
[Description("AI更新信标位置")]
public class UpdateAIBeacon : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<int> abilityTimelineIDInput = AddValueInput<int>("技能ID", "abilityIDVar");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("信标坐标", "positionVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
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
	}
}
