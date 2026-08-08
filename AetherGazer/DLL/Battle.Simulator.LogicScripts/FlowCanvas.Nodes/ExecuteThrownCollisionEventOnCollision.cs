using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物接触事件分支", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物接触到其他实体之后,根据抛掷物接触配置进行响应的处理")]
public class ExecuteThrownCollisionEventOnCollision : FlowControlNode
{
	private Int3 m_spawnPosition;

	private Int3 m_spawnForward;

	private int m_spawnThrownTimelineID;

	protected override void RegisterPorts()
	{
		_ = new FlowOutput[3];
		FlowOutput despawnSelfOutput = AddFlowOutput("自我销毁");
		FlowOutput spawnThrownOutput = AddFlowOutput("产生抛掷物");
		FlowOutput changeTarget = AddFlowOutput("切换目标");
		FlowOutput finalOutput = AddFlowOutput("处理完毕");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> collisionIDVar = AddValueInput<int>("接触实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			m_spawnThrownTimelineID = 0;
			m_spawnPosition = Int3.zero;
			m_spawnForward = Int3.zero;
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
				if (config != null && config.ThrownCollisionCheckInfoList.Count > 0)
				{
					int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
					if (mConllisionCheckIndex >= 0 && mConllisionCheckIndex < config.ThrownCollisionCheckInfoList.Count)
					{
						ThrownCollisionCheckInfo thrownCollisionCheckInfo = config.ThrownCollisionCheckInfoList.get_Item(mConllisionCheckIndex);
						int thrownBehaviourOnCollision = thrownCollisionCheckInfo.ThrownBehaviourOnCollision;
						if (thrownBehaviourOnCollision != 0)
						{
							if ((thrownBehaviourOnCollision & 1) == 1)
							{
								despawnSelfOutput.Call(f);
							}
							if ((thrownBehaviourOnCollision & 2) == 2)
							{
								m_spawnThrownTimelineID = thrownCollisionCheckInfo.SpawnThrownTimelineID;
								if ((thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 4) == 4)
								{
									SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(collisionIDVar.GetValue());
									if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon && !entityWithEntityID.hasEntityActionDeath)
									{
										m_spawnPosition = entityWithEntityID.entityPositon.mPosition;
										m_spawnForward = entityWithEntityID.entityPositon.mForward;
										if (m_spawnForward == Int3.zero)
										{
											m_spawnForward = Int3.forward;
										}
										spawnThrownOutput.Call(f);
									}
								}
								else
								{
									spawnThrownOutput.Call(f);
								}
							}
							if ((thrownBehaviourOnCollision & 8) == 8)
							{
								changeTarget.Call(f);
							}
							finalOutput.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("产生的抛掷物使用的TimelineID", () => m_spawnThrownTimelineID);
		AddValueOutput("产生的抛掷物的位置:", () => m_spawnPosition);
		AddValueOutput("产生的抛掷物的朝向:", () => m_spawnForward);
	}
}
