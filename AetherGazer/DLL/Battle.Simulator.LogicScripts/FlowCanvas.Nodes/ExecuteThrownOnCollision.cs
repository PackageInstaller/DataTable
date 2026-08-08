using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物接触分支", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物接触到其他实体之后,根据抛掷物接触配置进行响应的处理")]
public class ExecuteThrownOnCollision : FlowControlNode
{
	private ThrownCollisionCheckInfo m_thrownCollisionCheckInfo;

	private Int3 m_spawnPosition;

	private Int3 m_spawnForward;

	protected override void RegisterPorts()
	{
		_ = new FlowOutput[3];
		FlowOutput despawnSelfOutput = AddFlowOutput("自我销毁");
		FlowOutput spawnThrownOutput = AddFlowOutput("产生抛掷物");
		FlowOutput changeTarget = AddFlowOutput("切换目标");
		FlowOutput finalOutput = AddFlowOutput("处理完毕");
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		AddValueInput<int>("TimelineID");
		ValueInput<List<int>> collisionsVar = AddValueInput<List<int>>("接触列表");
		ValueInput<int> behaviourOnCollidedVar = AddValueInput<int>("接触行为置");
		ValueInput<int> spawnThrownTimelineIDVar = AddValueInput<int>("产生的抛掷物TimelineID");
		AddFlowInput("In", delegate(Flow f)
		{
			ThrownState thrownState = null;
			if (ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState))
			{
				m_spawnPosition = thrownState.mPosition;
				m_spawnForward = thrownState.mForward;
				if (behaviourOnCollidedVar.value != 0)
				{
					if ((behaviourOnCollidedVar.value & 1) == 1)
					{
						despawnSelfOutput.Call(f);
					}
					if ((behaviourOnCollidedVar.value & 2) == 2)
					{
						if ((behaviourOnCollidedVar.value & 4) == 4)
						{
							List<int> value = collisionsVar.value;
							for (int i = 0; i < value.Count; i++)
							{
								SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value[i]);
								if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon && !entityWithEntityID.hasEntityActionDeath)
								{
									m_spawnPosition = entityWithEntityID.entityPositon.mPosition;
									m_spawnForward = thrownState.mForward;
									if (m_spawnForward == Int3.zero)
									{
										m_spawnForward = Int3.forward;
									}
									spawnThrownOutput.Call(f);
								}
							}
						}
						else
						{
							spawnThrownOutput.Call(f);
						}
					}
					if ((behaviourOnCollidedVar.value & 8) == 8)
					{
						changeTarget.Call(f);
					}
					finalOutput.Call(f);
				}
				else
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
					if (config != null)
					{
						int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
						if (mConllisionCheckIndex >= config.ThrownCollisionCheckInfoList.Count)
						{
							m_thrownCollisionCheckInfo = null;
						}
						else
						{
							m_thrownCollisionCheckInfo = config.ThrownCollisionCheckInfoList.get_Item(mConllisionCheckIndex);
							if ((m_thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 1) == 1)
							{
								despawnSelfOutput.Call(f);
							}
							if ((m_thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 2) == 2)
							{
								if ((m_thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 4) == 4)
								{
									List<int> value2 = collisionsVar.value;
									for (int j = 0; j < value2.Count; j++)
									{
										SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(value2[j]);
										if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityPositon && !entityWithEntityID2.hasEntityActionDeath)
										{
											m_spawnPosition = entityWithEntityID2.entityPositon.mPosition;
											m_spawnForward = entityWithEntityID2.entityPositon.mForward;
											if (m_spawnForward == Int3.zero)
											{
												m_spawnForward = Int3.forward;
											}
											spawnThrownOutput.Call(f);
										}
									}
								}
								else
								{
									spawnThrownOutput.Call(f);
								}
							}
							finalOutput.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("产生的抛掷物使用的TimelineID", () => (spawnThrownTimelineIDVar.value != 0) ? spawnThrownTimelineIDVar.value : m_thrownCollisionCheckInfo.SpawnThrownTimelineID);
		AddValueOutput("产生的抛掷物的位置(多个会改变):", () => m_spawnPosition);
		AddValueOutput("产生的抛掷物的朝向(多个会改变):", () => m_spawnForward);
	}
}
