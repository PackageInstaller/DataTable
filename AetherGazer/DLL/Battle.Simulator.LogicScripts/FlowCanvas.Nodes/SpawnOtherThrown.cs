using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物检定创建抛掷物", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物碰撞后,检查行为参数,发送创建抛掷物实体事件")]
public class SpawnOtherThrown : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput abnormal = AddFlowOutput("异常退出");
		FlowOutput execution = AddFlowOutput("执行");
		FlowOutput nonexecution = AddFlowOutput("未执行");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> collisionIDVar = AddValueInput<int>("接触实体ID");
		ValueInput<bool> useCommonVar = AddValueInput<bool>("使用通用创建流程").SetDefaultAndSerializedValue(v: true);
		ValueInput<int> thrownBehaviourOnCollisionVar = AddValueInput<int>("接触行为参数(可选)").SetDefaultAndSerializedValue(-1);
		ValueInput<int> spawnThrownTimelineIDVar = AddValueInput<int>("孵化的抛掷物TimelineID(可选)").SetDefaultAndSerializedValue(-1);
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				abnormal.Call(f);
			}
			else
			{
				int num = thrownBehaviourOnCollisionVar.GetValue();
				int num2 = spawnThrownTimelineIDVar.GetValue();
				if (num == -1 || num2 == -1)
				{
					ThrownCollisionCheckInfo thrownCollisionCheckInfo = null;
					if (!ThrownHelper.TryGetThrownCollisionCheckInfo(thrownState.mAbilityID, thrownState.mConllisionCheckIndex, out thrownCollisionCheckInfo))
					{
						abnormal.Call(f);
						return;
					}
					if (num == -1)
					{
						num = thrownCollisionCheckInfo.ThrownBehaviourOnCollision;
					}
					if (num2 == -1)
					{
						num2 = thrownCollisionCheckInfo.SpawnThrownTimelineID;
					}
				}
				if (num <= 0 || (num & 2) != 2)
				{
					nonexecution.Call(f);
				}
				else
				{
					Int3 mPosition = thrownState.mPosition;
					Int3 @int = thrownState.mForward;
					if ((num & 4) == 4)
					{
						SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(collisionIDVar.GetValue());
						if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon && !entityWithEntityID.hasEntityActionDeath)
						{
							mPosition = entityWithEntityID.entityPositon.mPosition;
							@int = thrownState.mForward;
							if (@int == Int3.zero)
							{
								@int = Int3.forward;
							}
						}
					}
					ThrownProcessor.SpawnThrown(base.mSimContext, thrownState.mCasterID, 0, 0, mPosition, @int, num2, useCommonVar.value, thrownState.mCreationIndex, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID, out var _);
					execution.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", () => thrownIDVar.GetValue());
		AddValueOutput("接触实体ID", () => collisionIDVar.GetValue());
	}
}
