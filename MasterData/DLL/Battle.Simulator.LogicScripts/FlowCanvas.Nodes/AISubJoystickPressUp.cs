using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟子摇杆抬起", 0)]
[Category("Logic/AI/信标")]
[Description("AI更新信标位置")]
public class AISubJoystickPressUp : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "entityIDVar");
		ValueInput<Int3> positionVar = AddValueInput<Int3>("信标坐标", "positionVar");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonTypeVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mBeaconPosition = positionVar.GetValue();
				entityWithEntityID.entityBlackboard.var.mBeaconForward = entityWithEntityID.entityPositon.mForward;
				if (entityWithEntityID.hasEntityActionSubJoystick)
				{
					entityWithEntityID.RemoveEntityActionSubJoystick();
				}
				AIProcessor.RunMelee(entityWithEntityID, mIsPressing: false, (int)buttonTypeInput.GetValue());
				output.Call(f);
			}
		});
	}
}
