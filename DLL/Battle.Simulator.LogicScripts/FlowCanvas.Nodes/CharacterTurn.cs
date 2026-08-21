using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("角色旋转", 0)]
[Category("Logic/PosAndRot")]
[Description("1000毫度=1度;\n在Ability执行的过程中进行旋转,1左转,-1右转,0默认为最小角度并且面向停止;\n没有地方记录下转向,故而当转向为0时候,自动面向停止!!!")]
public class CharacterTurn : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> turnDirectionVar = AddValueInput<int>("方向", "turnDirectionVar").SetDefaultAndSerializedValue(0);
		ValueInput<int> speedVar = AddValueInput<int>("速度(毫度/帧(30帧))", "speedVar").SetDefaultAndSerializedValue(1000);
		ValueInput<bool> needStopOnFaceVar = AddValueInput<bool>("是否正对停下", "needStopOnFaceVar").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("Input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.value);
			if (turnDirectionVar.GetValue() != 0 && !needStopOnFaceVar.GetValue())
			{
				Int obj = IntMath.Divide(new Int(speedVar.GetValue() * 30).i * CommonProcessor.GetLogicConstTick(), 1000);
				Int angleSpeed = ((turnDirectionVar.GetValue() < 0) ? obj : (0 - obj));
				Int3 lookat = entityWithEntityID.entityPositon.mForward;
				MovementProcessor.Turn(entityWithEntityID, angleSpeed, out lookat);
				if (entityWithEntityID.hasEntityActionMoveDirection)
				{
					entityWithEntityID.entityActionMoveDirection.mDirection = entityWithEntityID.entityPositon.mForward;
				}
				output.Call(f);
			}
			else
			{
				SimEntity entity = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget);
				if (entityWithEntityID.hasEntityActionAbility)
				{
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityActionAbility.mTargetID);
					if (entityWithEntityID2 != null)
					{
						entity = entityWithEntityID2;
					}
				}
				entity = CommonProcessor.GetSimEntityByMultiColliders(entity);
				if (entity != null)
				{
					Int3 rhs = (entity.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
					Int3 lookat2 = entityWithEntityID.entityPositon.mForward;
					long num = Int3.Det(lookat2, rhs);
					int num2 = Int3.Dot(lookat2, rhs);
					if (num == 0L && num2 > 0)
					{
						output.Call(f);
						return;
					}
					if (turnDirectionVar.GetValue() != 0)
					{
						Int obj2 = IntMath.Divide(new Int(speedVar.GetValue() * 30).i * CommonProcessor.GetLogicConstTick(), 1000);
						Int angleSpeed2 = ((turnDirectionVar.GetValue() < 0) ? obj2 : (0 - obj2));
						VFactor radians = new VFactor(angleSpeed2.i, 1000L) * IntMath.Deg2Rad;
						lookat2 = lookat2.RotateY(ref radians);
						if (num * Int3.Det(lookat2, rhs) < 0 && Int3.Dot(lookat2, rhs) > 0 && needStopOnFaceVar.GetValue())
						{
							lookat2 = rhs.NormalizeTo(1000);
							entityWithEntityID.entityPositon.mForward = lookat2;
							entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(lookat2);
						}
						else
						{
							MovementProcessor.Turn(entityWithEntityID, angleSpeed2, out lookat2);
						}
					}
					else if (MovementProcessor.LookAt(speed: new Int(speedVar.GetValue() * 30), looker: entityWithEntityID, aimDirection: (entity.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000), deltaTime: CommonProcessor.GetLogicConstTick(), lookat: out lookat2))
					{
						entityWithEntityID.entityPositon.mForward = lookat2;
						entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(lookat2);
					}
					if (entityWithEntityID.hasEntityActionMoveDirection)
					{
						entityWithEntityID.entityActionMoveDirection.mDirection = entityWithEntityID.entityPositon.mForward;
					}
				}
				output.Call(f);
			}
		});
	}
}
