using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("傀儡跟随玩家", 0)]
[Category("Logic/AI")]
[Description("傀儡跟随玩家")]
public class PuppetFollowPlayer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> puppetIDInput = AddValueInput<int>("傀儡ID");
		ValueInput<int> targetIDInput = AddValueInput<int>("要跟随的目标ID");
		ValueInput<Int> angleInput = AddValueInput<Int>("偏移角度");
		ValueInput<int> lengthInput = AddValueInput<int>("偏移长度");
		ValueInput<int> distanceInput = AddValueInput<int>("刹车距离");
		ValueInput<int> moveSpeedFactorInput = AddValueInput<int>("移动速度百分比");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (AIProcessor.IsAIBusying(puppetIDInput.value))
			{
				output.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
				Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
				Int3 @int = IntMath.VectorOfAngle(IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward) - angleInput.value).NormalizeTo(lengthInput.value);
				mPosition += @int;
				mPosition = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID.entityPositon.mPosition, mPosition);
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(puppetIDInput.value);
				bool flag = false;
				if ((!entityWithEntityID2.hasEntityActionMoveDirection) ? AIProcessor.IsAITargetInRange(puppetIDInput.value, mPosition, distanceInput.value + 1000) : AIProcessor.IsAITargetInRange(puppetIDInput.value, mPosition, distanceInput.value))
				{
					AIProcessor.DoStopAbility(entityWithEntityID2);
				}
				else
				{
					entityWithEntityID2.entityBlackboard.var.mIsLookatAimTarget = false;
					entityWithEntityID2.entityPositon.mForward = (mPosition - entityWithEntityID2.entityPositon.mPosition).NormalizeTo(1000);
					AIProcessor.MoveAIDirection(puppetIDInput.value, mPosition, new VFactor(moveSpeedFactorInput.value, 100L));
				}
				output.Call(f);
			}
		});
	}
}
