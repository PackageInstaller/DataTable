using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("1194八方向逻辑", 0)]
[Category("Logic/角色定制/1194")]
[Description("1194八方向逻辑")]
public class CustomFunction1194_2 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID", "entityID");
		int actionID = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput noDirectionOut = AddFlowOutput("非移动闪避", "noDirectionOut");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			actionID = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionMoveDirection)
			{
				noDirectionOut.Call(f);
			}
			else
			{
				Int3 mDirection = entityWithEntityID.entityActionMoveDirection.mDirection;
				Int3 forward = entityWithEntityID.entityPositon.mForward;
				if (entityWithEntityID.hasEntityPositon)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
					if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityPositon)
					{
						Int3 @int = (simEntityByMultiColliders.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
						forward = @int;
					}
				}
				actionID = Direction2ActionID(forward, mDirection);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityID.value);
		AddValueOutput("技能ID(后三位)", "actionID", () => actionID);
	}

	protected int Direction2ActionID(Int3 forward, Int3 direction)
	{
		if (InRange(forward, direction, -22500, 22500))
		{
			return 248;
		}
		if (InRange(forward, direction, -67500, -22500))
		{
			return 247;
		}
		if (InRange(forward, direction, 22500, 67500))
		{
			return 249;
		}
		if (InRange(forward, direction, -112500, -67500))
		{
			return 244;
		}
		if (InRange(forward, direction, 67500, 112500))
		{
			return 246;
		}
		if (InRange(forward, direction, -157500, -112500))
		{
			return 241;
		}
		if (InRange(forward, direction, 112500, 157500))
		{
			return 243;
		}
		return 242;
	}

	protected bool InRange(Int3 forward, Int3 direction, Int startAngle, Int endAngle)
	{
		Int obj = IntMath.AngleOfVector(direction);
		Int obj2 = IntMath.AngleOfVector(forward);
		if (obj2 - obj > 180000)
		{
			obj += (Int)360000;
		}
		else if (obj2 - obj < -180000)
		{
			obj2 += (Int)360000;
		}
		if (obj <= obj2 - startAngle && obj >= obj2 - endAngle)
		{
			return true;
		}
		return false;
	}
}
