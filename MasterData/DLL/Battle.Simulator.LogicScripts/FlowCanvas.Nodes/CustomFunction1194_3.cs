using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("1194自动炮台逻辑", 0)]
[Category("Logic/角色定制/1194")]
[Description("1194自动炮台逻辑")]
public class CustomFunction1194_3 : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> thrownID = AddValueInput<int>("抛掷物ID", "thrownID");
		ValueInput<int> turningSpeed = AddValueInput<int>("转向速度(°/帧)", "turningSpeed");
		ValueInput<int> executeTime = AddValueInput<int>("时间(毫秒)", "executeTime");
		ValueInput<int> initFrame = AddValueInput<int>("初始化帧数", "initFrame");
		ValueInput<List<int>> fireFrame = AddValueInput<List<int>>("开炮帧数", "fireFrame");
		ValueInput<int> thrownTimelineID = AddValueInput<int>("炮弹TimelineID", "thrownTimelineID");
		ValueInput<int> rootTimelineID = AddValueInput<int>("根源TimelineID", "rootTimelineID");
		int entityID = 0;
		int newThrownID = 0;
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput onInitializingOut = AddFlowOutput("初始化中", "onInitializing");
		FlowOutput noTargetOut = AddFlowOutput("无目标", "noTarget");
		FlowOutput fireOut = AddFlowOutput("开炮", "fire");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			entityID = 0;
			newThrownID = 0;
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownID.value, out thrownState))
			{
				errorOut.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(thrownState.mCasterID);
				if (entityWithEntityID == null && entityWithEntityID.hasEntityBlackboard)
				{
					errorOut.Call(f);
				}
				else
				{
					entityID = entityWithEntityID.entityBlackboard.var.mEntityID;
					int num = executeTime.value / CommonProcessor.GetConfigInterval();
					if (num <= initFrame.value)
					{
						onInitializingOut.Call(f);
					}
					else
					{
						int num2 = 0;
						if (!entityWithEntityID.hasEntityActionDeath)
						{
							num2 = ((!entityWithEntityID.entityBlackboard.var.hasManualLock) ? entityWithEntityID.entityBlackboard.var.mAimTarget : entityWithEntityID.entityBlackboard.var.mLastTarget);
							SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(num2);
							if (simEntityByMultiColliders != null)
							{
								num2 = simEntityByMultiColliders.creationIndex;
							}
						}
						if (num2 == 0 || !CommonProcessor.IsAliveRole(base.mSimContext.GetEntityWithEntityID(num2)))
						{
							noTargetOut.Call(f);
						}
						else
						{
							Int obj = IntMath.AngleOfVector(AIProcessor.GetEntityPostion(num2) - thrownState.mPosition);
							Int obj2 = IntMath.AngleOfVector(thrownState.mForward);
							Int obj3 = obj2 - obj;
							int num3 = turningSpeed.value * 1000;
							if (IntMath.Abs(obj3) <= num3)
							{
								thrownState.mForward = (AIProcessor.GetEntityPostion(num2) - thrownState.mPosition).NormalizeTo(1000);
							}
							else if ((obj3 > -180000 && obj3 < 0) || obj3 > 180000)
							{
								thrownState.mForward = IntMath.VectorOfAngle(obj2 + num3).NormalizeTo(1000);
							}
							else
							{
								thrownState.mForward = IntMath.VectorOfAngle(obj2 - num3).NormalizeTo(1000);
							}
							if (fireFrame.value.Contains(num))
							{
								int mAttributeID = entityWithEntityID.entityBlackboard.var.mAttributeID;
								int value = thrownTimelineID.value;
								newThrownID = ThrownProcessor.SpawnThrown(base.mSimContext, thrownState.mCasterID, 0, 0, thrownState.mPosition, thrownState.mForward, value, useCommon: true, thrownState.mCasterID, rootTimelineID.value, mAttributeID, out var _);
								fireOut.Call(f);
							}
							output.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("1194实体ID", "entityID", () => entityID);
		AddValueOutput("抛掷物ID", "thrownID", () => thrownID.value);
		AddValueOutput("炮弹抛掷物ID", "newThrownID", () => newThrownID);
	}
}
