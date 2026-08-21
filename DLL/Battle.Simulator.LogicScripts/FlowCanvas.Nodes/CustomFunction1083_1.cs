using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[埃克]八方向行为控制", 0)]
[Category("Logic/角色定制/埃克")]
[Description("1083埃克什瓦的八方向行为控制整合节点")]
public class CustomFunction1083_1 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<bool> forceInput = AddValueInput<bool>("不考虑当前行为", "force").SetDefaultAndSerializedValue(v: false);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput falseOut = AddFlowOutput("不处理", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		int time235 = 9 * CommonProcessor.GetConfigInterval();
		int loopStart = 20 * CommonProcessor.GetConfigInterval();
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				int num = 235;
				if (forceInput.value)
				{
					if (entityWithEntityID.hasEntityActionMoveDirection)
					{
						Int3 mDirection = entityWithEntityID.entityActionMoveDirection.mDirection;
						Int3 mForward = entityWithEntityID.entityPositon.mForward;
						num = Direction2ActionID(mForward, mDirection);
					}
					entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = 0;
					AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, 1083000 + num);
					output.Call(f);
				}
				else if (!entityWithEntityID.hasEntityActionAbility)
				{
					falseOut.Call(f);
				}
				else
				{
					int mAbilityID = entityWithEntityID.entityActionAbility.mAbilityID;
					if (mAbilityID != 1083203 && mAbilityID != 1083231 && mAbilityID != 1083232 && mAbilityID != 1083233 && mAbilityID != 1083234 && mAbilityID != 1083235 && mAbilityID != 1083236 && mAbilityID != 1083237 && mAbilityID != 1083238 && mAbilityID != 1083239)
					{
						falseOut.Call(f);
					}
					else
					{
						int mLogicTime = entityWithEntityID.entityActionAbility.mLogicTime;
						if (mAbilityID == 1083203 && mLogicTime < time235)
						{
							falseOut.Call(f);
						}
						else
						{
							if (entityWithEntityID.hasEntityActionMoveDirection)
							{
								Int3 mDirection2 = entityWithEntityID.entityActionMoveDirection.mDirection;
								Int3 mForward2 = entityWithEntityID.entityPositon.mForward;
								num = Direction2ActionID(mForward2, mDirection2);
							}
							int num2 = 1083000 + num;
							if (mAbilityID == num2 && mLogicTime < loopStart)
							{
								falseOut.Call(f);
							}
							else
							{
								entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = 0;
								AIProcessor.AIStartAttack(entityIDInput.value, entityWithEntityID.entityPositon.mPosition, num2);
								output.Call(f);
							}
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}

	public int Direction2ActionID(Int3 forward, Int3 direction)
	{
		if (InRange(forward, direction, -22500, 22500))
		{
			return 238;
		}
		if (InRange(forward, direction, -67500, -22500))
		{
			return 237;
		}
		if (InRange(forward, direction, 22500, 67500))
		{
			return 239;
		}
		if (InRange(forward, direction, -112500, -67500))
		{
			return 234;
		}
		if (InRange(forward, direction, 67500, 112500))
		{
			return 236;
		}
		if (InRange(forward, direction, -157500, -112500))
		{
			return 231;
		}
		if (InRange(forward, direction, 112500, 157500))
		{
			return 233;
		}
		return 232;
	}

	public bool InRange(Int3 forward, Int3 direction, Int startAngle, Int endAngle)
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
