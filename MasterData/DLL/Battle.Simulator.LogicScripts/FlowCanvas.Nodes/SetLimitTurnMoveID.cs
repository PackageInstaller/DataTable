using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置转身动作", 0)]
[Category("Logic/Abilities")]
[Description("设置转身动作, 如果当前的移动是移动ID的话(不是起步刹车等), 方向和移动输入角度超过固定值之后会播左右转身")]
public class SetLimitTurnMoveID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> enableTurnMoveInput = AddValueInput<bool>("是否开启左右转身");
		ValueInput<int> turnLeftMoveIDInput = AddValueInput<int>("左转ID");
		ValueInput<int> turnRightMoveIDInput = AddValueInput<int>("右转ID");
		ValueInput<int> turnLimitAngleInput = AddValueInput<int>("角度限制");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mHasTurnMoveID = enableTurnMoveInput.value;
				entityWithEntityID.entityBlackboard.var.mTurnLeftMoveID = turnLeftMoveIDInput.value;
				entityWithEntityID.entityBlackboard.var.mTurnRightMoveID = turnRightMoveIDInput.value;
				entityWithEntityID.entityBlackboard.var.mTurnLimitAngle = turnLimitAngleInput.value;
				output.Call(f);
			}
		});
	}
}
