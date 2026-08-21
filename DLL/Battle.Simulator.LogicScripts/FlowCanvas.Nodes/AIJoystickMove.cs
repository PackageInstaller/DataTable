using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI信标移动", 0)]
[Category("Logic/AI/信标")]
[Description("AI信标移动, 用了'目标位置'")]
public class AIJoystickMove : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> targetIDVarNameInput = AddValueInput<int>("记录目标ID的变量名");
		ValueInput<int> stepLengthInput = AddValueInput<int>("步长");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, targetIDVarNameInput.value, out var baseValue, out var _, out var _);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID((int)baseValue);
			if (entityWithEntityID2 == null || !entityWithEntityID2.hasEntityBlackboard || !entityWithEntityID2.hasEntityPositon)
			{
				entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(value);
			}
			int value2 = stepLengthInput.value;
			Int3 @int = entityWithEntityID.entityBlackboard.var.mTargetPos + (entityWithEntityID2.entityPositon.mPosition - entityWithEntityID.entityBlackboard.var.mTargetPos).NormalizeTo(value2);
			if ((entityWithEntityID2.entityPositon.mPosition - @int).sqrMagnitudeLong < value2 * value2)
			{
				entityWithEntityID.entityBlackboard.var.mTargetPos = entityWithEntityID2.entityPositon.mPosition;
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.mTargetPos = @int;
			}
			int value3 = abilityIDInput.value;
			int newCommandCode = SubJoystickCommand.PositionToCommandCode(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityBlackboard.var.mTargetPos, value3);
			if (entityWithEntityID.hasEntityActionSubJoystick)
			{
				entityWithEntityID.ReplaceEntityActionSubJoystick(newCommandCode, value3);
			}
			else
			{
				entityWithEntityID.AddEntityActionSubJoystick(newCommandCode, value3);
			}
			f.Call(output);
		});
	}
}
