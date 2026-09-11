using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算攻击接近参数", 0)]
[Category("Logic/PosAndRot")]
[Description("计算攻击接近参数,目标位置, 速度 和 设置朝向, \n小于最小距离的话, 就不移动, 大于最大距离的话, 只会走最大距离那么远")]
public class ApproachTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> speedVarNameInput = AddValueInput<int>("速度的变量名");
		ValueInput<int> maxApproachDistanceInput = AddValueInput<int>("最大接近距离");
		ValueInput<int> stopDistanceInput = AddValueInput<int>("接近停止距离");
		ValueInput<int> durationInput = AddValueInput<int>("移动持续帧数");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (entityWithEntityID2 == null)
				{
					errorOut.Call(f);
				}
				else
				{
					int value = durationInput.value;
					if (value == 0)
					{
						errorOut.Call(f);
					}
					else
					{
						long a = MovementProcessor.SqrDistance(entityWithEntityID2.entityShape.mShape.WorldPos, entityWithEntityID.entityPositon.mPosition);
						a = IntMath.Sqrt(a) - entityWithEntityID2.entityShape.mShape.AvgCollisionRadius;
						Int3 mForward = (entityWithEntityID2.entityShape.mShape.WorldPos - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
						entityWithEntityID.entityPositon.mForward = mForward;
						entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
						int value2 = stopDistanceInput.value;
						int value3 = maxApproachDistanceInput.value;
						if (a <= value2)
						{
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, speedVarNameInput.value, 0L, 0L, 0L);
						}
						else if (a <= value3)
						{
							long num = a - value2;
							entityWithEntityID.entityBlackboard.var.mTargetPos = mForward.NormalizeTo((int)num) + entityWithEntityID.entityPositon.mPosition;
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, speedVarNameInput.value, num / value, 0L, 0L);
						}
						else
						{
							int num2 = value3;
							entityWithEntityID.entityBlackboard.var.mTargetPos = mForward.NormalizeTo(num2) + entityWithEntityID.entityPositon.mPosition;
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, speedVarNameInput.value, num2 / value, 0L, 0L);
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
