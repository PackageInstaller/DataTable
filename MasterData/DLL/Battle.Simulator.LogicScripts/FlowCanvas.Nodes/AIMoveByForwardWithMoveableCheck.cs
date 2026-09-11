using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI向前移动(带撞墙检测)", 0)]
[Category("Logic/AI")]
[Description("AI向前移动，朝着正前方移动, 不会看着目标")]
public class AIMoveByForwardWithMoveableCheck : FlowNode
{
	public Int3 GetTargetPos(Int3 startPos, Int3 forward, int distance)
	{
		Int3 @int = forward.NormalizeTo(distance);
		Int3 int2 = CommonProcessor.GetPositionInGraphWithoutTangentMove(startPos, startPos + @int + @int) - startPos;
		Int3 int3 = CommonProcessor.GetPositionInGraphWithoutTangentMove(startPos, startPos - @int) - startPos;
		Int3 int4 = CommonProcessor.GetPositionInGraphWithoutTangentMove(startPos, startPos + IntMath.GetXZLeft(@int)) - startPos;
		Int3 int5 = CommonProcessor.GetPositionInGraphWithoutTangentMove(startPos, startPos + IntMath.GetXZRight(@int)) - startPos;
		return startPos + int2 + int3 + int4 + int5;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度因子");
		ValueInput<int> distanceInput = AddValueInput<int>("检测距离");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = false;
				Int3 targetPos = GetTargetPos(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, distanceInput.value);
				AIProcessor.MoveAIDirection(entityIDInput.value, targetPos, new VFactor(speedFactorInput.value, 100L));
				f.Call(output);
			}
		});
	}
}
